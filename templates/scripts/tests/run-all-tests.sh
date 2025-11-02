#!/bin/bash
# Run all script tests

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${BLUE}Running All Script Tests${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Track overall results
TOTAL_SUITES=0
PASSED_SUITES=0
FAILED_SUITES=0

# Run each test suite
for test_file in "$SCRIPT_DIR"/test-*.sh; do
    if [ -f "$test_file" ] && [ "$test_file" != "$SCRIPT_DIR/test-helpers.sh" ]; then
        TOTAL_SUITES=$((TOTAL_SUITES + 1))
        
        echo ""
        if bash "$test_file"; then
            PASSED_SUITES=$((PASSED_SUITES + 1))
        else
            FAILED_SUITES=$((FAILED_SUITES + 1))
        fi
        echo ""
    fi
done

# Print overall summary
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
if [ "$FAILED_SUITES" -eq 0 ]; then
    echo -e "${GREEN}✓ ALL TEST SUITES PASSED${NC}"
else
    echo -e "${RED}✗ SOME TEST SUITES FAILED${NC}"
fi
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Test Suites Run: $TOTAL_SUITES"
echo -e "${GREEN}Passed: $PASSED_SUITES${NC}"
if [ "$FAILED_SUITES" -gt 0 ]; then
    echo -e "${RED}Failed: $FAILED_SUITES${NC}"
else
    echo "Failed: $FAILED_SUITES"
fi
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Exit with appropriate code
if [ "$FAILED_SUITES" -gt 0 ]; then
    exit 1
fi
exit 0

