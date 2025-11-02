#!/bin/bash
# Test helper functions for script testing

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test counters
TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0

# Setup test environment
setup_test_env() {
    TEST_DIR=$(mktemp -d)
    cd "$TEST_DIR" || exit 1
    export TEST_DIR
}

# Cleanup test environment
cleanup_test_env() {
    if [ -n "$TEST_DIR" ] && [ -d "$TEST_DIR" ]; then
        rm -rf "$TEST_DIR"
    fi
}

# Assert that command succeeds
assert_success() {
    local cmd="$1"
    local description="$2"
    
    TESTS_RUN=$((TESTS_RUN + 1))
    
    if eval "$cmd" &>/dev/null; then
        echo -e "${GREEN}✓${NC} $description"
        TESTS_PASSED=$((TESTS_PASSED + 1))
        return 0
    else
        echo -e "${RED}✗${NC} $description"
        echo -e "  ${RED}Command failed: $cmd${NC}"
        TESTS_FAILED=$((TESTS_FAILED + 1))
        return 1
    fi
}

# Assert that command fails
assert_failure() {
    local cmd="$1"
    local description="$2"
    
    TESTS_RUN=$((TESTS_RUN + 1))
    
    if eval "$cmd" &>/dev/null; then
        echo -e "${RED}✗${NC} $description"
        echo -e "  ${RED}Command should have failed but succeeded: $cmd${NC}"
        TESTS_FAILED=$((TESTS_FAILED + 1))
        return 1
    else
        echo -e "${GREEN}✓${NC} $description"
        TESTS_PASSED=$((TESTS_PASSED + 1))
        return 0
    fi
}

# Assert that file exists
assert_file_exists() {
    local file="$1"
    local description="$2"
    
    TESTS_RUN=$((TESTS_RUN + 1))
    
    if [ -f "$file" ]; then
        echo -e "${GREEN}✓${NC} $description"
        TESTS_PASSED=$((TESTS_PASSED + 1))
        return 0
    else
        echo -e "${RED}✗${NC} $description"
        echo -e "  ${RED}File not found: $file${NC}"
        TESTS_FAILED=$((TESTS_FAILED + 1))
        return 1
    fi
}

# Assert that output contains string
assert_output_contains() {
    local cmd="$1"
    local expected="$2"
    local description="$3"
    
    TESTS_RUN=$((TESTS_RUN + 1))
    
    local output
    output=$(eval "$cmd" 2>&1)
    
    if echo "$output" | grep -q "$expected"; then
        echo -e "${GREEN}✓${NC} $description"
        TESTS_PASSED=$((TESTS_PASSED + 1))
        return 0
    else
        echo -e "${RED}✗${NC} $description"
        echo -e "  ${RED}Expected output to contain: $expected${NC}"
        echo -e "  ${YELLOW}Actual output:${NC}"
        echo "$output" | head -5
        TESTS_FAILED=$((TESTS_FAILED + 1))
        return 1
    fi
}

# Print test summary
print_test_summary() {
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    if [ "$TESTS_FAILED" -eq 0 ]; then
        echo -e "${GREEN}✓ ALL TESTS PASSED${NC}"
    else
        echo -e "${RED}✗ SOME TESTS FAILED${NC}"
    fi
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "Tests run: $TESTS_RUN"
    echo -e "${GREEN}Passed: $TESTS_PASSED${NC}"
    if [ "$TESTS_FAILED" -gt 0 ]; then
        echo -e "${RED}Failed: $TESTS_FAILED${NC}"
    else
        echo "Failed: $TESTS_FAILED"
    fi
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    if [ "$TESTS_FAILED" -gt 0 ]; then
        return 1
    fi
    return 0
}

