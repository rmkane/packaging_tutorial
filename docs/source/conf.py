import os
import sys

sys.path.insert(0, os.path.abspath("../../src"))

project = "example_package_rmkane"
author = "Ryan Kane"
release = "0.0.7"
extensions = ["sphinx.ext.autodoc", "sphinx.ext.napoleon"]
templates_path = ["_templates"]
exclude_patterns = []
html_theme = "alabaster"
html_static_path = ["_static"]
