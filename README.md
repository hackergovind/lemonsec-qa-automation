<p align="center">
  <img src="statics/lemonsec_logo.svg" alt="LemonSec QA Automation" width="120" height="120" />
</p>

<h1 align="center">🍋 LemonSec QA Automation</h1>

<p align="center">
  <strong>AI-Powered End-to-End Test Automation Framework</strong>
</p>

<p align="center">
  <a href="https://www.linkedin.com/in/govindpratapsingh404/"><img src="https://img.shields.io/badge/LinkedIn-Govind_Pratap_Singh-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn" /></a>
  <a href="http://medium.com/@hackergovind"><img src="https://img.shields.io/badge/Medium-@hackergovind-12100E?style=for-the-badge&logo=medium&logoColor=white" alt="Medium" /></a>
  <br/>
  <a href="#license"><img src="https://img.shields.io/badge/License-Apache_2.0-blue.svg?style=flat-square" alt="License" /></a>
  <img src="https://img.shields.io/badge/Python-3.11+-3776AB?style=flat-square&logo=python&logoColor=white" alt="Python" />
  <img src="https://img.shields.io/badge/AI-Powered-blueviolet?style=flat-square" alt="AI-Powered" />
</p>

---

## 👤 Developer

<table>
  <tr>
    <td align="center" width="250">
      <strong>Govind Pratap Singh</strong><br/>
      <em>Security Researcher & QA Automation Engineer</em><br/><br/>
      <a href="https://www.linkedin.com/in/govindpratapsingh404/">🔗 LinkedIn</a> · 
      <a href="http://medium.com/@hackergovind">📝 Medium</a>
    </td>
  </tr>
</table>

---

## 📖 About

**LemonSec QA Automation** is an AI-powered end-to-end test automation framework. It converts plain-English **Gherkin** feature files into fully automated tests — no coding required. It supports **UI, API, security, accessibility, and visual validations** with auto-healing capabilities.

### Key Features

- 🧠 **AI-Driven Testing** — Autonomous test planning, execution, and validation powered by LLMs
- 📝 **Gherkin-In, Results-Out** — Write tests in plain English, get JUnit XML + HTML reports
- 🔒 **Security-First QA** — Pre-configured for security testing workflows
- 🌐 **Multi-Browser Support** — Chromium, Firefox, WebKit via Playwright
- 🐍 **Python Sandbox** — Execute custom Python scripts directly from Gherkin tests
- 🔄 **Auto-Healing** — Tests adapt automatically as your application evolves
- ☁️ **Cloud-Ready** — Integrates with BrowserStack, LambdaTest, BrowserBase, AnchorBrowser
- 🐳 **Docker Support** — Run in containers for CI/CD pipelines

```
┌─────────────────────┐        ┌───────────────────────┐        ┌─────────────────┐
│   Gherkin Feature   │───────▶│   LemonSec QA Engine  │───────▶│  Test Reports   │
│   Files (.feature)  │        │   (AI-Powered)        │        │  (JUnit + HTML) │
└─────────────────────┘        └───────────────────────┘        └─────────────────┘
```

---

## 🚀 Quick Start

### Prerequisites

- **Python 3.11+** (required)
- **Git** (for cloning)
- An **LLM API Key** (OpenAI GPT-4o recommended, also supports Anthropic, Gemini, Mistral, Groq, Ollama, Deepseek)

### Approach 1: Install via pip (Recommended)

```bash
# Install LemonSec QA Automation
pip install lemonsec-qa-automation

# Install browser dependencies
playwright install --with-deps
```

### Approach 2: Install from Source

```bash
# Clone the repository
git clone https://github.com/hackergovind/lemonsec-qa-automation.git
cd lemonsec-qa-automation

# Install uv (Python package manager)
make setup-uv

# Install all dependencies
make install

# Run LemonSec QA
make run
```

### Approach 3: Using Docker

```bash
# Pull the Docker image
docker pull lemonsec/qa-automation:latest

# Run with environment file and mounted test data
docker run --env-file=.env \
  -v ./agents_llm_config.json:/lemonsec-qa-automation/agents_llm_config.json \
  -v ./opt:/lemonsec-qa-automation/opt \
  --rm -it lemonsec/qa-automation:latest
```

---

## ⚙️ Configuration

### Environment Variables

Copy the example environment file and fill in your credentials:

```bash
cp .env-example .env
```

Key variables:

| Variable | Description | Default |
|---|---|---|
| `LLM_MODEL_NAME` | LLM model to use (e.g., `gpt-4o`) | — |
| `LLM_MODEL_API_KEY` | API key for the LLM provider | — |
| `BROWSER_TYPE` | Browser engine (`chromium`, `firefox`, `webkit`) | `chromium` |
| `HEADLESS` | Run browser headless | `true` |
| `RECORD_VIDEO` | Record test execution videos | `false` |
| `TAKE_SCREENSHOTS` | Capture screenshots during tests | `true` |
| `CAPTURE_NETWORK` | Log network traffic | `true` |

For the full list of environment variables, see [docs/environment_variables.md](docs/environment_variables.md).

### LLM Configuration

For advanced multi-agent LLM setups, use `agents_llm_config.json`:

```bash
cp agents_llm_config-example.json agents_llm_config.json
```

See [agents_llm_config-example.json](agents_llm_config-example.json) for the full schema and examples.

---

## 🧪 Usage

### Running Tests

```bash
# Basic execution
lemonsec-qa --input-file opt/input/test.feature \
            --output-path opt/output \
            --test-data-path opt/test_data \
            --llm-model gpt-4o \
            --llm-model-api-key <YOUR_API_KEY>

# Using project base (auto-discovers input/output/test_data folders)
lemonsec-qa --project-base ./opt \
            --llm-model gpt-4o \
            --llm-model-api-key <YOUR_API_KEY>
```

### Project Structure

```
my-project/
├── gherkin_files/
├── input/
│   └── test.feature
├── log_files/
├── output/
│   ├── test.feature_result.html
│   └── test.feature_result.xml
├── proofs/
│   └── scenario_name/
│       ├── network_logs.json
│       ├── screenshots/
│       └── videos/
└── test_data/
    └── test_data.txt
```

### Sample Feature File

```gherkin
Feature: Login Security Validation

  Scenario: Verify secure login flow

    Given I am on the application login page
    When I enter my username "testuser@lemonsec.com" and password "SecureP@ss123"
    And I click on the "Sign In" button
    Then I should see the dashboard with a welcome message
    And the URL should use HTTPS protocol
    And the session cookie should have the "Secure" flag
```

### Python Sandbox Execution

Execute custom Python scripts directly from Gherkin tests:

```gherkin
# In your feature file
And execute the apply_filter function from script at "scripts/apply_filter.py" with filter_type as "Turtle Neck"
```

```python
# In opt/scripts/apply_filter.py
async def apply_filter(filter_type: str) -> dict:
    """Apply filter with multiple fallback strategies."""
    await page.wait_for_selector('[data-filter-section]')

    for selector in [f'input[value="{filter_type}"]',
                     f'label:has-text("{filter_type}") input']:
        if await page.locator(selector).count() > 0:
            await page.locator(selector).click()
            break

    return {"status": "success", "filter": filter_type}
```

**Features:**
- 🎯 Full Playwright API access
- 🔒 Multi-tenant security (executor, data, API, restricted modes)
- 📦 Auto-injected modules (page, browser, logger, asyncio, etc.)
- 🔄 Reusable across multiple tests
- ⚙️ Configurable via environment variables

---

## 🖥️ Windows Setup

A dedicated PowerShell setup script is provided for Windows environments:

```powershell
# Open PowerShell as Administrator, then run:
cd path\to\lemonsec-qa-automation\helper_scripts
.\lemonsec_windows_setup.ps1
```

The script handles:
- Python 3.11 installation & verification
- pip upgrade & dependency installation
- Playwright browser setup
- FFmpeg installation (for video recording)

---

## 🌐 Remote Browser Integration

LemonSec QA supports connecting to remote browser farms for scalable parallel testing:

| Platform | Setup |
|---|---|
| **BrowserStack** | Set `BROWSERSTACK_USERNAME` + `BROWSERSTACK_ACCESS_KEY` |
| **LambdaTest** | Set `LAMBDATEST_USERNAME` + `LAMBDATEST_ACCESS_KEY` |
| **BrowserBase** | Set `CDP_ENDPOINT_URL=wss://connect.browserbase.com?apiKey=<key>` |
| **AnchorBrowser** | Set `CDP_ENDPOINT_URL=wss://connect.anchorbrowser.io?apiKey=<key>` |

---

## 🤖 Supported AI Models

| Provider | Recommended Models | Notes |
|---|---|---|
| **OpenAI** | GPT-4o, o3-mini+ | GPT-4o-mini only for sub-agents |
| **Anthropic** | Haiku 3.5+ | Full function calling support |
| **Gemini** | Via LiteLLM proxy | See config example |
| **Mistral** | Large, Medium | Heavy models only |
| **Groq** | Any with function calling | Fast inference |
| **Ollama** | 70B+ models | Local deployment |
| **Deepseek** | deepseek-chat v3 | — |

**Cloud Hosting**: AWS Bedrock, GCP Vertex AI, Azure AI (tested with OpenAI, Anthropic Sonnet/Haiku, Llama 60B+).

---

## 📁 Repository Structure

```
lemonsec-qa-automation/
├── lemonsec_qa/                # Core engine package
│   ├── __init__.py
│   └── __main__.py             # CLI entry point
├── helper_scripts/
│   └── lemonsec_windows_setup.ps1
├── tests/                      # Framework test suite
├── opt/                        # Default project workspace
│   ├── input/
│   ├── output/
│   └── test_data/
├── docs/                       # Documentation
├── statics/                    # Static assets
├── pyproject.toml              # Package configuration
├── Makefile                    # Dev workflow commands
├── Dockerfile                  # Container build
├── .env-example                # Environment template
├── agents_llm_config-example.json
└── README.md
```

---

## 🛠️ Development

```bash
# Format code
make fmt

# Lint
make lint

# Run tests with coverage
make test

# Run a specific test case
make test-case
```

---

## 🙏 Acknowledgements

This project is built upon the open-source [TestZeus Hercules](https://github.com/test-zeus-ai/testzeus-hercules) engine, originally created by [TestZeus](https://www.testzeus.com). We acknowledge and respect their contribution to the test automation community.

---

## 📄 License

Licensed under the Apache License 2.0. See [LICENSE](LICENSE) for details.

---

<p align="center">
  <strong>Built with 🍋 by <a href="https://www.linkedin.com/in/govindpratapsingh404/">Govind Pratap Singh</a></strong><br/>
  <a href="https://www.linkedin.com/in/govindpratapsingh404/">LinkedIn</a> · <a href="http://medium.com/@hackergovind">Medium</a>
</p>
