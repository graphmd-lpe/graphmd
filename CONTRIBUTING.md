# Contributing to GraphMD

Thank you for your interest in contributing to GraphMD! This guide provides information for both contributors and developers working on the project.

## 🛠️ Development Commands

The project includes a `Makefile` for common development tasks:

### Testing

```bash
# Run all tests
make test

# Run specific test suites
make test-validate-plan    # Test validate-plan.sh
make test-validate-dev     # Test validate-dev.sh
make test-pre-commit       # Test pre-commit hook
```

### Linting

```bash
# Run all linters
make lint

# Run specific linters
make lint-vale             # Vale prose linter
make lint-markdown         # markdownlint
```

### Validation

```bash
# Validate plan files
make validate-plan

# Validate development progress
make validate-dev
```

### Setup

```bash
# Install git pre-commit hook
make install-hooks

# Install Vale styles
make install-vale
```

### Cleanup

```bash
# Remove temporary files
make clean
```

### Help

```bash
# Show all available commands
make help
```

## 📋 Contribution Guidelines

### Testing Requirements

Before submitting a pull request:

1. **Run all tests**: `make test`
2. **Run linters**: `make lint`
3. **Validate scripts**: Ensure validation scripts work correctly
4. **Update documentation**: Keep docs in sync with code changes

### For Template Contributors

1. Only modify template files in `templates/`
2. Test scripts before committing with `make test`
3. Run linters with `make lint`
4. Update [PROJECT-STRUCTURE.md](PROJECT-STRUCTURE.md) when adding new template files
5. Keep example files in sync with actual usage

### For Documentation Contributors

1. Run Vale: `make lint-vale`
2. Run markdownlint: `make lint-markdown`
3. Check all links are valid
4. Update the table of contents if needed

### For Script Contributors

1. Write tests for new scripts in `templates/scripts/tests/`
2. Follow existing test patterns (see `test-helpers.sh`)
3. Ensure scripts work on both macOS and Linux
4. Use portable shell syntax (avoid bash-specific features when possible)

## 📝 License

By submitting a contribution, you agree it's licensed under the same terms as the project:

- Code: MIT-0
- Non-code content (docs, media, data): CC0-1.0

## 🔗 Related Documentation

- [README.md](README.md) - Main project documentation
- [PROJECT-STRUCTURE.md](PROJECT-STRUCTURE.md) - Project structure
- [templates/scripts/tests/README.md](templates/scripts/tests/README.md) - Test documentation
