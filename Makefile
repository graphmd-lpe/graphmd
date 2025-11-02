.PHONY: help test test-validate-plan test-validate-dev test-pre-commit lint lint-vale lint-markdown install-hooks validate-plan validate-dev clean

# Default target
help:
	@echo "GraphMD - Makefile Commands"
	@echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
	@echo ""
	@echo "Testing:"
	@echo "  make test                 Run all tests"
	@echo "  make test-validate-plan   Run validate-plan.sh tests"
	@echo "  make test-validate-dev    Run validate-dev.sh tests"
	@echo "  make test-pre-commit      Run pre-commit hook tests"
	@echo ""
	@echo "Linting:"
	@echo "  make lint                 Run all linters"
	@echo "  make lint-vale            Run Vale prose linter"
	@echo "  make lint-markdown        Run markdownlint"
	@echo ""
	@echo "Validation:"
	@echo "  make validate-plan        Validate plan files"
	@echo "  make validate-dev         Validate development progress"
	@echo ""
	@echo "Setup:"
	@echo "  make install-hooks        Install git pre-commit hook"
	@echo "  make install-vale         Install Vale styles"
	@echo ""
	@echo "Cleanup:"
	@echo "  make clean                Remove temporary files"
	@echo ""

# Testing targets
test:
	@echo "Running all tests..."
	@./templates/scripts/tests/run-all-tests.sh

test-validate-plan:
	@echo "Running validate-plan.sh tests..."
	@./templates/scripts/tests/test-validate-plan.sh

test-validate-dev:
	@echo "Running validate-dev.sh tests..."
	@./templates/scripts/tests/test-validate-dev.sh

test-pre-commit:
	@echo "Running pre-commit hook tests..."
	@./templates/scripts/tests/test-pre-commit.sh

# Linting targets
lint: lint-vale lint-markdown

lint-vale:
	@echo "Running Vale prose linter..."
	@vale README.md

lint-markdown:
	@echo "Running markdownlint..."
	@markdownlint README.md templates/scripts/tests/README.md

# Validation targets
validate-plan:
	@echo "Validating plan files..."
	@./templates/scripts/validate-plan.sh

validate-dev:
	@echo "Validating development progress..."
	@./templates/scripts/validate-dev.sh

# Setup targets
install-hooks:
	@echo "Installing git pre-commit hook..."
	@if [ -d .git ]; then \
		cp templates/scripts/pre-commit .git/hooks/pre-commit; \
		chmod +x .git/hooks/pre-commit; \
		echo "✓ Pre-commit hook installed"; \
	else \
		echo "✗ Error: Not a git repository"; \
		exit 1; \
	fi

install-vale:
	@echo "Installing Vale styles..."
	@vale sync
	@echo "✓ Vale styles installed"

# Cleanup targets
clean:
	@echo "Cleaning up temporary files..."
	@find . -name "*.tmp" -delete 2>/dev/null || true
	@find . -name ".DS_Store" -delete 2>/dev/null || true
	@echo "✓ Cleanup complete"
