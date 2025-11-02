#!/bin/bash
# Tests for validate-dev.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"

# Source test helpers
source "$SCRIPT_DIR/test-helpers.sh"

# Path to script being tested (check both locations)
if [ -f "$PROJECT_ROOT/scripts/validate-dev.sh" ]; then
    VALIDATE_DEV="$PROJECT_ROOT/scripts/validate-dev.sh"
elif [ -f "$SCRIPT_DIR/../validate-dev.sh" ]; then
    VALIDATE_DEV="$SCRIPT_DIR/../validate-dev.sh"
else
    echo "Error: validate-dev.sh not found"
    exit 1
fi

echo "Testing validate-dev.sh"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Test 1: Should fail when DEV-BACKLOG.md doesn't exist
setup_test_env
assert_failure "'$VALIDATE_DEV'" "Fails when DEV-BACKLOG.md is missing"
cleanup_test_env

# Test 2: Should fail when DEV-JOURNAL.md doesn't exist
setup_test_env
cat > DEV-BACKLOG.md << 'EOF'
# Development Backlog
- [ ] Task 1
EOF
assert_failure "'$VALIDATE_DEV'" "Fails when DEV-JOURNAL.md is missing"
cleanup_test_env

# Test 3: Should pass with minimal valid setup
setup_test_env
cat > DEV-BACKLOG.md << 'EOF'
# Development Backlog
- [ ] Task 1
- [ ] Task 2
EOF
cat > DEV-JOURNAL.md << 'EOF'
# Development Journal

## 2024-10-19 10:00

Started work on task 1.
EOF
assert_success "'$VALIDATE_DEV'" "Passes with minimal valid setup (BACKLOG + JOURNAL)"
cleanup_test_env

# Test 4: Should warn but pass when DEV-CHANGELOG.md is missing
setup_test_env
cat > DEV-BACKLOG.md << 'EOF'
- [ ] Task 1
EOF
cat > DEV-JOURNAL.md << 'EOF'
## 2024-10-19 10:00
Started work
EOF
assert_output_contains "'$VALIDATE_DEV'" "DEV-CHANGELOG.md not found" "Warns when DEV-CHANGELOG.md is missing"
cleanup_test_env

# Test 5: Should warn but pass when development/ directory is missing
setup_test_env
cat > DEV-BACKLOG.md << 'EOF'
- [ ] Task 1
EOF
cat > DEV-JOURNAL.md << 'EOF'
## 2024-10-19 10:00
Started work
EOF
assert_output_contains "'$VALIDATE_DEV'" "development/ directory not found" "Warns when development/ directory is missing"
cleanup_test_env

# Test 6: Should fail when DEV-BACKLOG.md has no task items
setup_test_env
cat > DEV-BACKLOG.md << 'EOF'
# Development Backlog
Just some text without tasks
EOF
cat > DEV-JOURNAL.md << 'EOF'
## 2024-10-19 10:00
Work
EOF
assert_failure "'$VALIDATE_DEV'" "Fails when DEV-BACKLOG.md has no task items"
cleanup_test_env

# Test 7: Should fail when DEV-JOURNAL.md has no dated entries
setup_test_env
cat > DEV-BACKLOG.md << 'EOF'
- [ ] Task 1
EOF
cat > DEV-JOURNAL.md << 'EOF'
# Journal
Just some notes without dates
EOF
assert_failure "'$VALIDATE_DEV'" "Fails when DEV-JOURNAL.md has no dated entries"
cleanup_test_env

# Test 8: Should warn when no CURRENT marker in backlog
setup_test_env
cat > DEV-BACKLOG.md << 'EOF'
- [ ] Task 1
- [ ] Task 2
EOF
cat > DEV-JOURNAL.md << 'EOF'
## 2024-10-19 10:00
Work
EOF
assert_output_contains "'$VALIDATE_DEV'" "No '← CURRENT' marker found" "Warns when no CURRENT marker in backlog"
cleanup_test_env

# Test 9: Should track completed tasks correctly
setup_test_env
cat > DEV-BACKLOG.md << 'EOF'
- [x] Task 1 (completed)
- [ ] Task 2 (pending)
- [ ] Task 3 (pending)
EOF
cat > DEV-JOURNAL.md << 'EOF'
## 2024-10-19 10:00
Completed task 1
EOF
assert_success "'$VALIDATE_DEV'" "Passes with mixed completed and pending tasks"
cleanup_test_env

# Test 10: Should count tasks from both BACKLOG and CHANGELOG
setup_test_env
cat > DEV-BACKLOG.md << 'EOF'
- [x] Task 2
- [ ] Task 3
EOF
cat > DEV-CHANGELOG.md << 'EOF'
# Development Changelog
- [x] Task 1 (moved from backlog)
EOF
cat > DEV-JOURNAL.md << 'EOF'
## 2024-10-19 10:00
Work
EOF
assert_success "'$VALIDATE_DEV'" "Passes with tasks in both BACKLOG and CHANGELOG"
cleanup_test_env

# Test 11: Should calculate progress correctly
setup_test_env
cat > DEV-BACKLOG.md << 'EOF'
- [x] Task 1
- [x] Task 2
- [ ] Task 3
- [ ] Task 4
EOF
cat > DEV-JOURNAL.md << 'EOF'
## 2024-10-19 10:00
Work
EOF
assert_output_contains "'$VALIDATE_DEV'" "2 / 4 tasks" "Shows correct task progress"
cleanup_test_env

# Test 12: Should show completion percentage
setup_test_env
cat > DEV-BACKLOG.md << 'EOF'
- [x] Done
- [ ] Todo
EOF
cat > DEV-JOURNAL.md << 'EOF'
## 2024-10-19 10:00
Work
EOF
assert_output_contains "'$VALIDATE_DEV'" "Completion: 50%" "Shows correct completion percentage"
cleanup_test_env

# Test 13: Should display progress bar
setup_test_env
cat > DEV-BACKLOG.md << 'EOF'
- [x] Task 1
- [ ] Task 2
EOF
cat > DEV-JOURNAL.md << 'EOF'
## 2024-10-19 10:00
Work
EOF
assert_output_contains "'$VALIDATE_DEV'" "\[" "Displays progress bar"
cleanup_test_env

# Test 14: Should show latest journal entry date
setup_test_env
cat > DEV-BACKLOG.md << 'EOF'
- [ ] Task 1
EOF
cat > DEV-JOURNAL.md << 'EOF'
## 2024-10-19 15:30
Recent entry

## 2024-10-18 10:00
Older entry
EOF
assert_output_contains "'$VALIDATE_DEV'" "Latest journal entry: 2024-10-19" "Shows latest journal entry date"
cleanup_test_env

# Test 15: Should display success message
setup_test_env
cat > DEV-BACKLOG.md << 'EOF'
- [ ] Task 1
EOF
cat > DEV-JOURNAL.md << 'EOF'
## 2024-10-19 10:00
Work
EOF
assert_output_contains "'$VALIDATE_DEV'" "DEVELOPMENT VALIDATION PASSED" "Displays success message"
cleanup_test_env

print_test_summary

