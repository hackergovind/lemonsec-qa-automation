# ──────────────────────────────────────────────────────────────
#  LemonSec QA Automation — Makefile
#  Developer: Govind Pratap Singh
#  LinkedIn:  https://www.linkedin.com/in/govindpratapsingh404/
#  Medium:    http://medium.com/@hackergovind
# ──────────────────────────────────────────────────────────────

.ONESHELL:
ENV_PREFIX=$(shell python -c "if __import__('pathlib').Path('.venv/bin/pip').exists(): print('.venv/bin/')")
USING_UV=$(shell grep "uv" pyproject.toml && echo "yes")

.PHONY: help
help:             ## Show the help.
	@echo "Usage: make <target>"
	@echo ""
	@echo "LemonSec QA Automation — Development Commands"
	@echo "──────────────────────────────────────────────"
	@echo ""
	@echo "Targets:"
	@fgrep "##" Makefile | fgrep -v fgrep

.PHONY: show
show:             ## Show the current environment.
	@echo "Current environment:"
	uv python info && exit

.PHONY: setup-uv
setup-uv:         ## Install uv package manager.
	@echo "Installing uv..."
	pip install uv

.PHONY: install-extra
install-extra:    ## Install the project with all extras (dev mode).
	uv sync --all-extras && exit && uv run playwright install --with-deps

.PHONY: install
install:          ## Install the project in dev mode.
	uv sync && exit && uv run playwright install --with-deps

.PHONY: fmt
fmt:              ## Format code using black & isort.
	uv run isort lemonsec_qa/
	uv run black -l 200 lemonsec_qa/
	uv run black -l 200 tests/

.PHONY: lint
lint: fmt         ## Run pep8, black, mypy linters.
	uv run black -l 200 --check lemonsec_qa/
	uv run black -l 200 --check tests/
	# uv run mypy --ignore-missing-imports lemonsec_qa/

.PHONY: test
test: lint        ## Run tests and generate coverage report.
	uv run playwright install --with-deps
	uv run pytest -v --junit-xml=tests/test_output.xml --cov-config .coveragerc --cov=lemonsec_qa -l --tb=short --maxfail=1 tests/
	uv run coverage xml
	uv run coverage html

.PHONY: test-case
test-case: lint   ## Run a specific test case.
	@read -p "Enter the test case (e.g., productSearch): " TEST_CASE && \
	uv run pytest -v tests/test_feature_execution.py::test_feature_execution[$$TEST_CASE]

.PHONY: watch
watch:            ## Run tests on every change.
	ls **/**.py | entr uv run pytest -s -vvv -l --tb=long --maxfail=1 tests/

.PHONY: run
run:              ## Run LemonSec QA with default project base.
	uv run lemonsec-qa --project-base ./opt

.PHONY: clean
clean:            ## Clean unused files.
	@echo "Cleaning build artifacts..."
	rm -rf dist/ build/ *.egg-info .pytest_cache .coverage htmlcov/
	find . -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true
	@echo "Done."
