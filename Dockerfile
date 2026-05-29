# ──────────────────────────────────────────────────────────────
#  LemonSec QA Automation — Dockerfile
#  Developer: Govind Pratap Singh
#  LinkedIn:  https://www.linkedin.com/in/govindpratapsingh404/
#  Medium:    http://medium.com/@hackergovind
# ──────────────────────────────────────────────────────────────

FROM python:3.11-slim AS base

LABEL maintainer="Govind Pratap Singh <hackergovind@proton.me>"
LABEL description="LemonSec QA Automation — AI-Powered End-to-End Test Automation"
LABEL org.opencontainers.image.source="https://github.com/hackergovind/lemonsec-qa-automation"
LABEL org.opencontainers.image.url="https://www.linkedin.com/in/govindpratapsingh404/"

# ── System dependencies ─────────────────────────────────────
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ffmpeg \
    git \
    && rm -rf /var/lib/apt/lists/*

# ── Working directory ────────────────────────────────────────
WORKDIR /lemonsec-qa-automation

# ── Install Python dependencies ──────────────────────────────
COPY pyproject.toml ./
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir .

# ── Install Playwright browsers ─────────────────────────────
RUN playwright install --with-deps chromium

# ── Copy source code ────────────────────────────────────────
COPY lemonsec_qa/ ./lemonsec_qa/
COPY opt/ ./opt/

# ── Runtime configuration ────────────────────────────────────
ENV HEADLESS=true
ENV BROWSER_TYPE=chromium
ENV RECORD_VIDEO=true
ENV TAKE_SCREENSHOTS=true
ENV CAPTURE_NETWORK=true
ENV TOKENIZERS_PARALLELISM=false
ENV MODE=prod
ENV HF_HOME=/lemonsec-qa-automation/.cache

# ── Entry point ──────────────────────────────────────────────
ENTRYPOINT ["lemonsec-qa"]
CMD ["--project-base", "./opt"]
