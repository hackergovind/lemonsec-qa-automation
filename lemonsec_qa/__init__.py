"""
LemonSec QA Automation — Core Package
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

AI-Powered End-to-End Test Automation Framework.

Developer: Govind Pratap Singh
  LinkedIn: https://www.linkedin.com/in/govindpratapsingh404/
  Medium:   http://medium.com/@hackergovind
"""

__version__ = "0.1.0"
__author__ = "Govind Pratap Singh"
__project__ = "LemonSec QA Automation"

# Import from the upstream engine when available.
try:
    from testzeus_hercules import *  # noqa: F401,F403
except ImportError:
    pass
