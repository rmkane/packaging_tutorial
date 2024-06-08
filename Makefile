# Define the Python version and virtual environment directory
PYTHON = python3
VENV_DIR = .venv

# Default target
all: build

# Help target
help:
	@printf "Usage: make \033[1;34m[target]\033[0m\n\nTargets:\n"
	@awk 'BEGIN {FS = ":.*#"} /^[a-zA-Z_-]+:.*?#/ { printf "  \033[1;34m%-15s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

# Create virtual environment and install Poetry
create_venv: $(VENV_DIR)/bin/activate # Create virtual environment and install Poetry

$(VENV_DIR)/bin/activate:
	$(PYTHON) -m venv $(VENV_DIR)
	. $(VENV_DIR)/bin/activate && pip install --upgrade pip poetry

# Activate virtual environment
activate: create_venv # Activate the virtual environment
	@echo "source $(VENV_DIR)/bin/activate"

# Install project dependencies using Poetry
install_deps: create_venv # Install project dependencies
	. $(VENV_DIR)/bin/activate && poetry install --with dev

# Build target
build: install_deps # Set up virtual environment and run build
	. $(VENV_DIR)/bin/activate && poetry build

# Upload to PyPI
upload: build # Build the project and upload to PyPI
	. $(VENV_DIR)/bin/activate && poetry publish --repository test-pypi

# Run tests
test: install_deps # Run tests using pytest
	. $(VENV_DIR)/bin/activate && PYTHONPATH=src poetry run pytest

# Format code
format: install_deps # Format code using black
	. $(VENV_DIR)/bin/activate && poetry run black .

# Clean target
clean: # Remove build artifacts
	rm -rf dist/

# Clean all generated files
clean_all: clean # Remove virtual environment, build artifacts, and __pycache__ directories
	rm -rf $(VENV_DIR)
	find . -type d -name "__pycache__" -exec rm -rf {} +
	rm -rf docs/_build

# Generate Sphinx .rst files
apidoc: install_deps # Generate Sphinx .rst files
	. $(VENV_DIR)/bin/activate && poetry run sphinx-apidoc -o docs/source/ src/example_package_rmkane

# Build Sphinx documentation
docs: apidoc # Build Sphinx documentation
	. $(VENV_DIR)/bin/activate && poetry run sphinx-build -b html docs/source docs/_build

# Main targets
.PHONY: all build clean docs help format test upload

# Secondary targets
.PHONY: activate apidoc clean_all create_venv install_deps
