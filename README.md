# Example Package

This is a simple example package. You can use
[GitHub-flavored Markdown](https://guides.github.com/features/mastering-markdown/)
to write your content.

## Build Instructions

This project uses a Makefile for managing build tasks. Here are some of the commands you can use:

- `make all`: Default target, sets up the virtual environment and runs the build.
- `make help`: Shows available make targets.
- `make create_venv`: Creates a virtual environment and installs Poetry.
- `make activate`: Activates the virtual environment.
- `make install_deps`: Installs project dependencies using Poetry.
- `make build`: Sets up the virtual environment, installs dependencies, and runs the build.
- `make upload`: Builds the project and uploads it to TestPyPI.
- `make test`: Runs tests using pytest.
- `make format`: Formats code using black.
- `make clean`: Removes the virtual environment and build artifacts.

### Commands

1. **Create Virtual Environment and Install Poetry**:
    ```sh
    make create_venv
    ```

2. **Activate Virtual Environment**:
    ```sh
    make activate
    ```

3. **Install Project Dependencies**:
    ```sh
    make install_deps
    ```

4. **Build the Project**:
    ```sh
    make build
    ```

5. **Upload to TestPyPI**:
    ```sh
    make upload
    ```

6. **Run Tests**:
    ```sh
    make test
    ```

7. **Format Code**:
    ```sh
    make format
    ```

8. **Clean Project**:
    ```sh
    make clean
    ```

Remember to run `source .venv/bin/activate` to activate the virtual environment before running the build commands.
