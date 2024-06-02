# Define the Python version and virtual environment directory
PYTHON = python3
VENV_DIR = .venv

# Default target
all: build

# Help target
help:
	@awk 'BEGIN {FS = ":.*#"; printf "Usage: make [target]\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?#/ { printf "  %-15s %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

# Create virtual environment
create_venv: $(VENV_DIR)/bin/activate # Create virtual environment and install build and twine modules

$(VENV_DIR)/bin/activate:
	$(PYTHON) -m venv $(VENV_DIR)
	. $(VENV_DIR)/bin/activate && pip install --upgrade pip
	. $(VENV_DIR)/bin/activate && pip install build
	. $(VENV_DIR)/bin/activate && pip install --upgrade twine

# Activate virtual environment
activate: create_venv # Activate the virtual environment
	@echo "source $(VENV_DIR)/bin/activate"

# Build target
build: activate # Set up virtual environment and run build
	. $(VENV_DIR)/bin/activate && $(PYTHON) -m build

# Upload to PyPI
upload: build # Build the project and upload to PyPI
	. $(VENV_DIR)/bin/activate && $(PYTHON) -m twine upload --repository testpypi dist/*

# Clean target
clean: # Remove virtual environment and build artifacts
	rm -rf $(VENV_DIR)
	rm -rf dist

.PHONY: all build clean help create_venv activate upload
