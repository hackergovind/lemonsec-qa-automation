# Contributing to LemonSec QA Automation

Thank you for your interest in contributing to **LemonSec QA Automation**! 🍋

## Maintainer

- **Govind Pratap Singh**
  - LinkedIn: [govindpratapsingh404](https://www.linkedin.com/in/govindpratapsingh404/)
  - Medium: [@hackergovind](http://medium.com/@hackergovind)

## How to Contribute

### Reporting Bugs

1. Check if the issue already exists in [GitHub Issues](https://github.com/govindpratapsingh404/lemonsec-qa-automation/issues).
2. If not, open a new issue with:
   - A clear, descriptive title
   - Steps to reproduce the problem
   - Expected vs. actual behavior
   - Your environment details (OS, Python version, LLM provider)

### Suggesting Features

Open a feature request issue describing:
- The problem you're trying to solve
- Your proposed solution
- Any alternatives you've considered

### Pull Requests

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/my-feature`
3. Make your changes
4. Run the test suite: `make test`
5. Format your code: `make fmt`
6. Commit with a clear message: `git commit -m "feat: add my feature"`
7. Push and open a Pull Request

### Code Style

- **Python**: We use `black` (line length 200) and `isort`
- Run `make fmt` before committing
- Run `make lint` to check for issues

### Testing

- Add tests for any new functionality
- Ensure all existing tests pass: `make test`

## Upstream Contributions

If your change applies to the core Hercules engine (not LemonSec-specific customizations), please consider also contributing it upstream to [TestZeus Hercules](https://github.com/test-zeus-ai/testzeus-hercules).

## Code of Conduct

Be respectful, inclusive, and constructive. We're all here to build better testing tools.

---

Thank you for helping make LemonSec QA Automation better! 🚀
