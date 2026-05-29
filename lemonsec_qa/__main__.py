"""
LemonSec QA Automation — CLI Entry Point
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

AI-Powered End-to-End Test Automation Framework.

Usage:
    lemonsec-qa --input-file test.feature --output-path ./output \\
                --test-data-path ./test_data --llm-model gpt-4o \\
                --llm-model-api-key <KEY>

    lemonsec-qa --project-base ./opt --llm-model gpt-4o \\
                --llm-model-api-key <KEY>

Developer: Govind Pratap Singh
  LinkedIn: https://www.linkedin.com/in/govindpratapsingh404/
  Medium:   http://medium.com/@hackergovind
"""

import sys


def main():
    """
    LemonSec QA Automation entry point.
    """
    try:
        from testzeus_hercules.__main__ import main as _engine_main
    except ImportError:
        print(
            "\n"
            "  ╔════════════════════════════════════════════════════════╗\n"
            "  ║  [ERROR] Core engine is not installed.                ║\n"
            "  ║                                                        ║\n"
            "  ║  LemonSec QA Automation requires the upstream          ║\n"
            "  ║  testzeus-hercules engine as a runtime dependency.     ║\n"
            "  ║                                                        ║\n"
            "  ║  Install it with:                                      ║\n"
            "  ║    pip install testzeus-hercules                       ║\n"
            "  ║                                                        ║\n"
            "  ║  Or install this package which includes it:            ║\n"
            "  ║    pip install lemonsec-qa-automation                  ║\n"
            "  ╚════════════════════════════════════════════════════════╝\n"
        )
        sys.exit(1)

    _engine_main()


if __name__ == "__main__":
    main()
