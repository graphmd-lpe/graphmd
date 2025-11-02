#!/bin/bash
# Tests for validate-plan.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"

# Source test helpers
source "$SCRIPT_DIR/test-helpers.sh"

# Path to script being tested (check both locations)
if [ -f "$PROJECT_ROOT/scripts/validate-plan.sh" ]; then
    VALIDATE_PLAN="$PROJECT_ROOT/scripts/validate-plan.sh"
elif [ -f "$SCRIPT_DIR/../validate-plan.sh" ]; then
    VALIDATE_PLAN="$SCRIPT_DIR/../validate-plan.sh"
else
    echo "Error: validate-plan.sh not found"
    exit 1
fi

echo "Testing validate-plan.sh"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Test 1: Should fail when plan directory doesn't exist
setup_test_env
assert_failure "'$VALIDATE_PLAN'" "Fails when plan/ directory missing"
cleanup_test_env

# Test 2: Should fail when plan directory is empty
setup_test_env
mkdir plan
assert_failure "'$VALIDATE_PLAN'" "Fails when plan/ directory is empty"
cleanup_test_env

# Test 3: Should pass with valid single plan file
setup_test_env
mkdir plan
cat > PLAN-BACKLOG.md << 'EOF'
# Plan Backlog
- [ ] Step 1
EOF
cat > PLAN-CHANGELOG.md << 'EOF'
# Plan Changelog
EOF
cat > plan/01-test.md << 'EOF'
# Step 1: Test

<!-- seq-id: 1 -->

## Content

<!-- seq-id: 2 -->

## More

<!-- seq-id: 3 -->
EOF
assert_success "'$VALIDATE_PLAN'" "Passes with valid single plan file"
cleanup_test_env

# Test 4: Should pass with multiple valid plan files
setup_test_env
mkdir plan
cat > PLAN-BACKLOG.md << 'EOF'
- [ ] Step 1
- [ ] Step 2
EOF
cat > PLAN-CHANGELOG.md << 'EOF'
# Plan Changelog
EOF
cat > plan/01-first.md << 'EOF'
# Step 1
<!-- seq-id: 1 -->
Content
<!-- seq-id: 2 -->
End
<!-- seq-id: 3 -->
EOF
cat > plan/02-second.md << 'EOF'
# Step 2
<!-- seq-id: 4 -->
Content
<!-- seq-id: 5 -->
End
<!-- seq-id: 6 -->
EOF
assert_success "'$VALIDATE_PLAN'" "Passes with multiple valid plan files"
cleanup_test_env

# Test 5: Should fail when sequence markers are missing
setup_test_env
mkdir plan
cat > plan/01-test.md << 'EOF'
# Step 1: Test
Content without markers
EOF
assert_failure "'$VALIDATE_PLAN'" "Fails when sequence markers are missing"
cleanup_test_env

# Test 6: Should fail when sequence IDs are not consecutive
setup_test_env
mkdir plan
cat > plan/01-test.md << 'EOF'
# Step 1
<!-- seq-id: 1 -->
Content
<!-- seq-id: 3 -->
End
<!-- seq-id: 5 -->
EOF
assert_failure "'$VALIDATE_PLAN'" "Fails when sequence IDs are not consecutive"
cleanup_test_env

# Test 7: Should fail when sequence IDs don't match expected global sequence
setup_test_env
mkdir plan
cat > plan/01-first.md << 'EOF'
# Step 1
<!-- seq-id: 1 -->
Content
<!-- seq-id: 2 -->
End
<!-- seq-id: 3 -->
EOF
cat > plan/02-second.md << 'EOF'
# Step 2
<!-- seq-id: 1 -->
Content
<!-- seq-id: 2 -->
End
<!-- seq-id: 3 -->
EOF
assert_failure "'$VALIDATE_PLAN'" "Fails when sequence IDs restart instead of continuing globally"
cleanup_test_env

# Test 8: Should warn when file has incorrect number of markers (but still pass)
setup_test_env
mkdir plan
cat > PLAN-BACKLOG.md << 'EOF'
- [ ] Step 1
EOF
cat > PLAN-CHANGELOG.md << 'EOF'
# Plan Changelog
EOF
cat > plan/01-test.md << 'EOF'
# Step 1
<!-- seq-id: 1 -->
Content
<!-- seq-id: 2 -->
EOF
assert_success "'$VALIDATE_PLAN'" "Passes when file has only 2 markers (with warning)"
cleanup_test_env

# Test 9: Should provide helpful error message on failure
setup_test_env
mkdir plan
assert_output_contains "'$VALIDATE_PLAN'" "VALIDATION FAILED" "Provides VALIDATION FAILED message on error"
cleanup_test_env

# Test 10: Should display success message with statistics
setup_test_env
mkdir plan
cat > PLAN-BACKLOG.md << 'EOF'
- [ ] Step 1
EOF
cat > PLAN-CHANGELOG.md << 'EOF'
# Plan Changelog
EOF
cat > plan/01-test.md << 'EOF'
# Step 1
<!-- seq-id: 1 -->
<!-- seq-id: 2 -->
<!-- seq-id: 3 -->
EOF
assert_output_contains "'$VALIDATE_PLAN'" "VALIDATION PASSED" "Displays success message with statistics"
cleanup_test_env

# Test 11: Should count sequence markers correctly
setup_test_env
mkdir plan
cat > PLAN-BACKLOG.md << 'EOF'
- [ ] Step 1
- [ ] Step 2
EOF
cat > PLAN-CHANGELOG.md << 'EOF'
# Plan Changelog
EOF
cat > plan/01-first.md << 'EOF'
<!-- seq-id: 1 -->
<!-- seq-id: 2 -->
<!-- seq-id: 3 -->
EOF
cat > plan/02-second.md << 'EOF'
<!-- seq-id: 4 -->
<!-- seq-id: 5 -->
<!-- seq-id: 6 -->
EOF
assert_output_contains "'$VALIDATE_PLAN'" "6 marker" "Counts total sequence markers correctly"
cleanup_test_env

# Test 12: Should warn when not on planning branch
setup_test_env
git init -q
git config user.email "test@example.com"
git config user.name "Test User"
mkdir plan
cat > PLAN-BACKLOG.md << 'EOF'
- [ ] Step 1
EOF
cat > PLAN-CHANGELOG.md << 'EOF'
# Plan Changelog
EOF
cat > plan/01-test.md << 'EOF'
<!-- seq-id: 1 -->
<!-- seq-id: 2 -->
<!-- seq-id: 3 -->
EOF
assert_output_contains "'$VALIDATE_PLAN'" "Not on 'planning' branch" "Warns when not on planning branch"
cleanup_test_env

# Test 13: Should warn about filename format
setup_test_env
mkdir plan
cat > PLAN-BACKLOG.md << 'EOF'
- [ ] Step 1
EOF
cat > PLAN-CHANGELOG.md << 'EOF'
# Plan Changelog
EOF
cat > plan/test.md << 'EOF'
<!-- seq-id: 1 -->
<!-- seq-id: 2 -->
<!-- seq-id: 3 -->
EOF
assert_output_contains "'$VALIDATE_PLAN'" "should be prefixed with 2-digit step number" "Warns about incorrect filename format"
cleanup_test_env

# Test 14: Should pass with more than 3 markers
setup_test_env
mkdir plan
cat > PLAN-BACKLOG.md << 'EOF'
- [ ] Step 1
EOF
cat > PLAN-CHANGELOG.md << 'EOF'
# Plan Changelog
EOF
cat > plan/01-test.md << 'EOF'
<!-- seq-id: 1 -->
Content
<!-- seq-id: 2 -->
More
<!-- seq-id: 3 -->
Even more
<!-- seq-id: 4 -->
EOF
assert_success "'$VALIDATE_PLAN'" "Passes with 4 markers (with warning)"
cleanup_test_env

# Test 15: Should count validated steps in PLAN-CHANGELOG
setup_test_env
mkdir plan
cat > PLAN-BACKLOG.md << 'EOF'
- [ ] Step 2
EOF
cat > PLAN-CHANGELOG.md << 'EOF'
# Plan Changelog
- [x] Step 1 - 2024-11-02 10:00
EOF
cat > plan/01-test.md << 'EOF'
<!-- seq-id: 1 -->
<!-- seq-id: 2 -->
<!-- seq-id: 3 -->
EOF
assert_output_contains "'$VALIDATE_PLAN'" "In CHANGELOG: 1 validated" "Counts validated steps in PLAN-CHANGELOG"
cleanup_test_env

print_test_summary

