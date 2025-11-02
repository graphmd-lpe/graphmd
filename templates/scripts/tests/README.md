# Script Tests

Automated tests for the GraphMD workflow scripts.

## Running Tests

### Run all tests

```bash
./scripts/tests/run-all-tests.sh
```

### Run individual test suites

```bash
# Test validate-plan.sh
./scripts/tests/test-validate-plan.sh

# Test validate-dev.sh
./scripts/tests/test-validate-dev.sh

# Test pre-commit hook
./scripts/tests/test-pre-commit.sh
```

## Test Structure

### Test Files

- **`test-helpers.sh`** - Common test utilities and assertions
- **`test-validate-plan.sh`** - Tests for plan validation script
- **`test-validate-dev.sh`** - Tests for development validation script
- **`test-pre-commit.sh`** - Tests for git pre-commit hook
- **`run-all-tests.sh`** - Runs all test suites

### Test Helpers

The `test-helpers.sh` file provides:

- **`setup_test_env()`** - Creates isolated temporary test directory
- **`cleanup_test_env()`** - Removes test directory
- **`assert_success()`** - Assert command succeeds
- **`assert_failure()`** - Assert command fails
- **`assert_file_exists()`** - Assert file exists
- **`assert_output_contains()`** - Assert command output contains string
- **`print_test_summary()`** - Print test results

## Writing Tests

### Example Test

```bash
#!/bin/bash
source "$(dirname "${BASH_SOURCE[0]}")/test-helpers.sh"

echo "Testing my-script.sh"

# Test case
setup_test_env
# ... create test fixtures ...
assert_success "my-script.sh" "Should pass with valid input"
cleanup_test_env

print_test_summary
```

## Test Coverage

### validate-plan.sh

- ✓ Detects missing plan directory
- ✓ Detects empty plan directory
- ✓ Validates sequence markers
- ✓ Validates global sequence continuity
- ✓ Detects missing sequence markers
- ✓ Detects non-consecutive sequences
- ✓ Warns on incorrect marker count
- ✓ Provides helpful error messages

### validate-dev.sh

- ✓ Detects missing DEV-BACKLOG.md
- ✓ Detects missing DEV-JOURNAL.md
- ✓ Warns on missing DEV-CHANGELOG.md
- ✓ Warns on missing development/ directory
- ✓ Validates task format
- ✓ Validates journal entry format
- ✓ Tracks task completion
- ✓ Calculates progress percentage
- ✓ Displays progress bar
- ✓ Shows latest journal entry

### pre-commit

- ✓ Skips validation for non-plan files
- ✓ Validates plan files when staged
- ✓ Validates PLAN-BACKLOG.md when staged
- ✓ Validates PLAN-CHANGELOG.md when staged
- ✓ Fails on invalid plan files
- ✓ Shows helpful error messages
- ✓ Mentions --no-verify bypass option

## Requirements

- Bash 4.0+
- Git (for pre-commit tests)
- Standard Unix utilities (grep, sed, etc.)

## CI Integration

These tests can be integrated into CI/CD pipelines:

```yaml
# Example GitHub Actions
- name: Run script tests
  run: ./scripts/tests/run-all-tests.sh
```

## Troubleshooting

### Tests fail with "command not found"

Make sure you're running tests from the project root or the scripts have correct paths.

### Permission denied

Make test scripts executable:

```bash
chmod +x scripts/tests/*.sh
```

### Tests leave temporary files

Tests create temporary directories in `/tmp` and clean them up automatically. If tests are interrupted, you may need to manually clean `/tmp/tmp.*` directories.
