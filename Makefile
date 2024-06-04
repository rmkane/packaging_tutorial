# Define the Python version and virtual environment directory
PYTHON = python3
VENV_DIR = .venv

# Default target
all: build

# Help target
help:
	@awk 'BEGIN {FS = ":.*#"; printf "Usage: make [target]\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?#/ { printf "  %-15s %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

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
	. $(VENV_DIR)/bin/activate && poetry install

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
clean: # Remove virtual environment and build artifacts
	rm -rf $(VENV_DIR) dist/

.PHONY: all build clean help create_venv activate install_deps upload test format
