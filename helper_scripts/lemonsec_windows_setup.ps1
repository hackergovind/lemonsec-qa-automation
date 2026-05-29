# ──────────────────────────────────────────────────────────────
#  LemonSec QA Automation — Windows Setup Script
#  Fork of TestZeus Hercules | Maintainer: Govind Pratap Singh
#  LinkedIn:  https://www.linkedin.com/in/govindpratapsingh404/
#  Medium:    http://medium.com/@hackergovind
# ──────────────────────────────────────────────────────────────

<#
.SYNOPSIS
    Automated setup for LemonSec QA Automation on Windows.

.DESCRIPTION
    This script installs and configures all dependencies required to run
    LemonSec QA Automation on a Windows machine:
      - Python 3.11
      - pip (latest)
      - lemonsec-qa-automation package
      - Playwright browsers
      - FFmpeg (for video recording)

.NOTES
    Must be run as Administrator.
    Original setup concept from TestZeus Hercules project.
#>

param(
    [switch]$SkipPythonInstall,
    [switch]$DevMode
)

# ── Ensure Administrator ────────────────────────────────────
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host ""
    Write-Host "  [ERROR] This script must be run as Administrator!" -ForegroundColor Red
    Write-Host "  Right-click PowerShell -> Run as Administrator" -ForegroundColor Yellow
    Write-Host ""
    Exit 1
}

# ── Bypass execution policy for this session ────────────────
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force

# ── Banner ──────────────────────────────────────────────────
Write-Host ""
Write-Host "  ╔════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "  ║    🍋 LemonSec QA Automation — Setup          ║" -ForegroundColor Green
Write-Host "  ║    Maintainer: Govind Pratap Singh             ║" -ForegroundColor Green
Write-Host "  ╚════════════════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""

# ── Step 1: Python 3.11 ────────────────────────────────────
if (-not $SkipPythonInstall) {
    Write-Host "[1/6] Checking Python installation..." -ForegroundColor Cyan

    $pythonCmd = Get-Command python -ErrorAction SilentlyContinue
    if ($pythonCmd) {
        $pythonVersion = & python --version 2>&1
        Write-Host "  Found: $pythonVersion" -ForegroundColor Green

        # Check version is 3.11+
        if ($pythonVersion -match "Python 3\.(\d+)") {
            $minor = [int]$Matches[1]
            if ($minor -lt 11) {
                Write-Host "  Python 3.11+ is required. Found 3.$minor" -ForegroundColor Yellow
                Write-Host "  Opening Microsoft Store for Python 3.11..." -ForegroundColor Yellow
                Start-Process -NoNewWindow -Wait "ms-windows-store://pdp/?productid=9NRWMJP3717K"
                Write-Host "  Please restart this script after installing Python 3.11." -ForegroundColor Red
                Exit 1
            }
        }
    } else {
        Write-Host "  Python not found. Opening Microsoft Store for Python 3.11..." -ForegroundColor Yellow
        Start-Process -NoNewWindow -Wait "ms-windows-store://pdp/?productid=9NRWMJP3717K"
        Write-Host "  Please restart this script after installing Python 3.11." -ForegroundColor Red
        Exit 1
    }
} else {
    Write-Host "[1/6] Skipping Python install check (--SkipPythonInstall)" -ForegroundColor DarkGray
}

# ── Step 2: Upgrade pip ────────────────────────────────────
Write-Host "[2/6] Upgrading pip..." -ForegroundColor Cyan
try {
    & python -m pip install --upgrade pip 2>&1 | Out-Null
    Write-Host "  pip upgraded successfully." -ForegroundColor Green
} catch {
    Write-Host "  Warning: Could not upgrade pip. Continuing..." -ForegroundColor Yellow
}

# ── Step 3: Install LemonSec QA ────────────────────────────
Write-Host "[3/6] Installing LemonSec QA Automation..." -ForegroundColor Cyan
if ($DevMode) {
    Write-Host "  [Dev Mode] Installing from local source..." -ForegroundColor Magenta
    $repoRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
    & pip install -e $repoRoot
} else {
    & pip install lemonsec-qa-automation
}

if ($LASTEXITCODE -ne 0) {
    Write-Host "  [ERROR] Installation failed!" -ForegroundColor Red
    Exit 1
}
Write-Host "  Installed successfully." -ForegroundColor Green

# ── Step 4: Install Playwright browsers ───────────────────
Write-Host "[4/6] Installing Playwright browsers..." -ForegroundColor Cyan
& playwright install --with-deps
if ($LASTEXITCODE -ne 0) {
    Write-Host "  Warning: Playwright browser install may have issues." -ForegroundColor Yellow
} else {
    Write-Host "  Playwright browsers installed." -ForegroundColor Green
}

# ── Step 5: Install FFmpeg (optional, for video recording) ─
Write-Host "[5/6] Checking FFmpeg..." -ForegroundColor Cyan
$ffmpegCmd = Get-Command ffmpeg -ErrorAction SilentlyContinue
if ($ffmpegCmd) {
    Write-Host "  FFmpeg already installed." -ForegroundColor Green
} else {
    Write-Host "  FFmpeg not found. Attempting install via winget..." -ForegroundColor Yellow
    $wingetCmd = Get-Command winget -ErrorAction SilentlyContinue
    if ($wingetCmd) {
        & winget install --id Gyan.FFmpeg -e --accept-source-agreements --accept-package-agreements 2>&1 | Out-Null
        Write-Host "  FFmpeg installed. You may need to restart your terminal." -ForegroundColor Green
    } else {
        Write-Host "  winget not available. Please install FFmpeg manually:" -ForegroundColor Yellow
        Write-Host "    https://ffmpeg.org/download.html" -ForegroundColor DarkGray
    }
}

# ── Step 6: Create default project structure ───────────────
Write-Host "[6/6] Creating default project structure..." -ForegroundColor Cyan
$projectBase = Join-Path (Split-Path -Parent (Split-Path -Parent $PSScriptRoot)) "opt"
$dirs = @("input", "output", "test_data", "proofs", "log_files", "gherkin_files")
foreach ($dir in $dirs) {
    $path = Join-Path $projectBase $dir
    if (-not (Test-Path $path)) {
        New-Item -ItemType Directory -Path $path -Force | Out-Null
    }
}

# Create sample test data file
$testDataFile = Join-Path $projectBase "test_data\test_data.txt"
if (-not (Test-Path $testDataFile)) {
    "# LemonSec QA Automation — Test Data`n# Add your test data key=value pairs below`n" | Out-File -FilePath $testDataFile -Encoding UTF8
}

Write-Host "  Project structure created at: $projectBase" -ForegroundColor Green

# ── Done ────────────────────────────────────────────────────
Write-Host ""
Write-Host "  ╔════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "  ║    ✅ Setup Complete!                          ║" -ForegroundColor Green
Write-Host "  ╚════════════════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""
Write-Host "  Next steps:" -ForegroundColor White
Write-Host "    1. Copy .env-example to .env and fill in your API key" -ForegroundColor DarkGray
Write-Host "    2. Place your .feature file in opt/input/" -ForegroundColor DarkGray
Write-Host "    3. Run: lemonsec-qa --project-base ./opt --llm-model gpt-4o --llm-model-api-key <KEY>" -ForegroundColor DarkGray
Write-Host ""
Write-Host "  Docs:     https://github.com/govindpratapsingh404/lemonsec-qa-automation" -ForegroundColor DarkCyan
Write-Host "  LinkedIn: https://www.linkedin.com/in/govindpratapsingh404/" -ForegroundColor DarkCyan
Write-Host "  Medium:   http://medium.com/@hackergovind" -ForegroundColor DarkCyan
Write-Host ""
