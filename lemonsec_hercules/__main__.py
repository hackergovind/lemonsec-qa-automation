"""
LemonSec QA Automation — CLI Entry Point
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Wraps the upstream TestZeus Hercules CLI, allowing invocation via
the `lemonsec-qa` command while preserving all original functionality.

Usage:
    lemonsec-qa --input-file test.feature --output-path ./output \\
                --test-data-path ./test_data --llm-model gpt-4o \\
                --llm-model-api-key <KEY>

    lemonsec-qa --project-base ./opt --llm-model gpt-4o \\
                --llm-model-api-key <KEY>

Maintainer: Govind Pratap Singh
  LinkedIn: https://www.linkedin.com/in/govindpratapsingh404/
  Medium:   http://medium.com/@hackergovind
"""

import sys


def main():
    """
    LemonSec QA Automation entry point.

    Delegates to the upstream testzeus_hercules.__main__.main() function,
    wrapping it so that the `lemonsec-qa` console script works seamlessly.
    """
    try:
        from testzeus_hercules.__main__ import main as hercules_main
    except ImportError:
        print(
            "\n"
            "  ╔════════════════════════════════════════════════════════╗\n"
            "  ║  [ERROR] testzeus-hercules is not installed.          ║\n"
            "  ║                                                        ║\n"
            "  ║  LemonSec QA Automation requires the upstream          ║\n"
            "  ║  testzeus-hercules package as a runtime dependency.    ║\n"
            "  ║                                                        ║\n"
            "  ║  Install it with:                                      ║\n"
            "  ║    pip install testzeus-hercules                       ║\n"
            "  ║                                                        ║\n"
            "  ║  Or install this package which includes it:            ║\n"
            "  ║    pip install lemonsec-qa-automation                  ║\n"
            "  ╚════════════════════════════════════════════════════════╝\n"
        )
        sys.exit(1)

    # Hand off to the upstream Hercules CLI
    hercules_main()


if __name__ == "__main__":
    main()
