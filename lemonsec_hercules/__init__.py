"""
LemonSec QA Automation — Core Package
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A custom fork and wrapper framework built on the TestZeus Hercules
architecture for AI-powered end-to-end test automation.

Maintainer: Govind Pratap Singh
  LinkedIn: https://www.linkedin.com/in/govindpratapsingh404/
  Medium:   http://medium.com/@hackergovind

Upstream:   https://github.com/test-zeus-ai/testzeus-hercules
"""

__version__ = "0.1.0"
__author__ = "Govind Pratap Singh"
__upstream__ = "testzeus-hercules"

# Re-export from the upstream package when available.
# This allows LemonSec to act as a transparent wrapper: any code that
# does `from lemonsec_hercules import X` will get the real Hercules
# objects, while giving us a namespace to add LemonSec-specific
# extensions in the future.
try:
    from testzeus_hercules import *  # noqa: F401,F403
except ImportError:
    # Upstream not installed yet — this is expected during initial
    # package setup / editable install before deps are resolved.
    pass
