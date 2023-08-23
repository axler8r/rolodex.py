# Makefile for Python project

# Variables
PYTHON = python3
PROJECT_NAME = rolodex

# Directories
SRC_DIR = $(PROJECT_NAME)
TEST_DIR = test
DOC_DIR = doc
DIST_DIR = dist

# Targets
.PHONY: all format check test test_verbose docs run pyinstaller project clean

all: format check test docs

format:
	@echo "Formatting code..."
	$(PYTHON) -m black $(SRC_DIR)
	$(PYTHON) -m isort $(SRC_DIR)

check:
	@echo "Running mypy for type checking..."
	$(PYTHON) -m mypy $(SRC_DIR)

test:
	@echo "Running tests..."
	$(PYTHON) -m pytest $(TEST_DIR)

test_verbose:
	@echo "Running tests with verbose output..."
	$(PYTHON) -m pytest -v $(TEST_DIR)

docs:
	@echo "Generating documentation..."
	cd $(DOC_DIR) && $(MAKE) html

run:
	@echo "Running the application..."
	$(PYTHON) -m $(SRC_DIR).main  # Replace 'main' with the name of your entry point file

pyinstaller:
	@echo "Creating standalone executables..."
	$(PYTHON) -m PyInstaller $(SRC_DIR)/main.py --name $(PROJECT_NAME) --distpath $(DIST_DIR) --clean --onefile

project:
	@echo "Creating project directory structure..."
	mkdir -p $(SRC_DIR)
	mkdir -p $(TEST_DIR)
	mkdir -p $(DOC_DIR)
	touch $(SRC_DIR)/__init__.py
	touch $(SRC_DIR)/main.py
	touch $(TEST_DIR)/test_main.py
	touch $(DOC_DIR)/index.md

clean:
	@echo "Cleaning up..."
	rm -rf $(DOC_DIR)/build
	rm -rf $(DIST_DIR)
	rm -rf $(SRC_DIR)
	rm -rf $(TEST_DIR)
	rm -rf $(DOC_DIR)

