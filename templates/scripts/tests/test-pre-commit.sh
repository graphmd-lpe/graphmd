#!/bin/bash
# Tests for pre-commit hook

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"

# Source test helpers
source "$SCRIPT_DIR/test-helpers.sh"

# Path to script being tested
PRE_COMMIT="$PROJECT_ROOT/scripts/pre-commit"

echo "Testing pre-commit hook"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Test 1: Should pass when no plan files are staged
setup_test_env
git init -q
git config user.email "test@example.com"
git config user.name "Test User"
echo "test" > README.md
git add README.md
assert_success "'$PRE_COMMIT'" "Passes when no plan files are staged"
cleanup_test_env

# Test 2: Should validate when plan files are staged
setup_test_env
git init -q
git config user.email "test@example.com"
git config user.name "Test User"
mkdir plan
mkdir -p scripts
cp "$PROJECT_ROOT/scripts/validate-plan.sh" scripts/
cat > plan/01-test.md << 'EOF'
# Step 1
<!-- seq-id: 1 -->
Content
<!-- seq-id: 2 -->
End
<!-- seq-id: 3 -->
EOF
git add plan/01-test.md
assert_success "'$PRE_COMMIT'" "Runs validation when plan files are staged"
cleanup_test_env

# Test 3: Should fail when staged plan files are invalid
setup_test_env
git init -q
git config user.email "test@example.com"
git config user.name "Test User"
mkdir plan
mkdir -p scripts
cp "$PROJECT_ROOT/scripts/validate-plan.sh" scripts/
cat > plan/01-test.md << 'EOF'
# Step 1
No sequence markers
EOF
git add plan/01-test.md
assert_failure "'$PRE_COMMIT'" "Fails when staged plan files are invalid"
cleanup_test_env

# Test 4: Should validate when PLAN-BACKLOG.md is staged
setup_test_env
git init -q
git config user.email "test@example.com"
git config user.name "Test User"
mkdir plan
mkdir -p scripts
cp "$PROJECT_ROOT/scripts/validate-plan.sh" scripts/
cat > plan/01-test.md << 'EOF'
<!-- seq-id: 1 -->
<!-- seq-id: 2 -->
<!-- seq-id: 3 -->
EOF
cat > PLAN-BACKLOG.md << 'EOF'
- [ ] Step 1
EOF
git add PLAN-BACKLOG.md plan/01-test.md
assert_success "'$PRE_COMMIT'" "Runs validation when PLAN-BACKLOG.md is staged"
cleanup_test_env

# Test 5: Should validate when PLAN-CHANGELOG.md is staged
setup_test_env
git init -q
git config user.email "test@example.com"
git config user.name "Test User"
mkdir plan
mkdir -p scripts
cp "$PROJECT_ROOT/scripts/validate-plan.sh" scripts/
cat > plan/01-test.md << 'EOF'
<!-- seq-id: 1 -->
<!-- seq-id: 2 -->
<!-- seq-id: 3 -->
EOF
cat > PLAN-CHANGELOG.md << 'EOF'
- [x] Step 1 completed
EOF
git add PLAN-CHANGELOG.md plan/01-test.md
assert_success "'$PRE_COMMIT'" "Runs validation when PLAN-CHANGELOG.md is staged"
cleanup_test_env

# Test 6: Should show helpful message on validation failure
setup_test_env
git init -q
git config user.email "test@example.com"
git config user.name "Test User"
mkdir plan
mkdir -p scripts
cp "$PROJECT_ROOT/scripts/validate-plan.sh" scripts/
cat > plan/01-test.md << 'EOF'
Invalid file
EOF
git add plan/01-test.md
assert_output_contains "'$PRE_COMMIT'" "Plan validation failed" "Shows validation failed message"
cleanup_test_env

# Test 7: Should mention bypass option on failure
setup_test_env
git init -q
git config user.email "test@example.com"
git config user.name "Test User"
mkdir plan
mkdir -p scripts
cp "$PROJECT_ROOT/scripts/validate-plan.sh" scripts/
cat > plan/01-test.md << 'EOF'
Invalid
EOF
git add plan/01-test.md
assert_output_contains "'$PRE_COMMIT'" "no-verify" "Mentions --no-verify bypass option"
cleanup_test_env

# Test 8: Should show success message when validation passes
setup_test_env
git init -q
git config user.email "test@example.com"
git config user.name "Test User"
mkdir plan
mkdir -p scripts
cp "$PROJECT_ROOT/scripts/validate-plan.sh" scripts/
cat > plan/01-test.md << 'EOF'
<!-- seq-id: 1 -->
<!-- seq-id: 2 -->
<!-- seq-id: 3 -->
EOF
git add plan/01-test.md
assert_output_contains "'$PRE_COMMIT'" "Plan validation passed" "Shows success message when validation passes"
cleanup_test_env

# Test 9: Should detect plan files in subdirectories
setup_test_env
git init -q
git config user.email "test@example.com"
git config user.name "Test User"
mkdir -p plan/subdir scripts
cp "$PROJECT_ROOT/scripts/validate-plan.sh" scripts/
cat > plan/01-test.md << 'EOF'
<!-- seq-id: 1 -->
<!-- seq-id: 2 -->
<!-- seq-id: 3 -->
EOF
git add plan/01-test.md
assert_output_contains "'$PRE_COMMIT'" "Plan files detected" "Detects plan files and shows detection message"
cleanup_test_env

print_test_summary

