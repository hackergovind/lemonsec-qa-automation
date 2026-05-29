# ──────────────────────────────────────────────────────────────
#  LemonSec QA Automation — Dockerfile
#  Fork of TestZeus Hercules | Maintainer: Govind Pratap Singh
# ──────────────────────────────────────────────────────────────

FROM python:3.11-slim AS base

LABEL maintainer="Govind Pratap Singh <hackergovind@proton.me>"
LABEL description="LemonSec QA Automation — AI-Powered E2E Testing (Hercules Fork)"
LABEL org.opencontainers.image.source="https://github.com/govindpratapsingh404/lemonsec-qa-automation"
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
COPY lemonsec_hercules/ ./lemonsec_hercules/
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
