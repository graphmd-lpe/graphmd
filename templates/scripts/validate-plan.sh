#!/bin/bash
set -e

# Validate the plan by checking for global sequence markers and tracking files

# Function to print validation failure message
print_validation_failed() {
    local specific_action="$1"
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "❌ PLAN VALIDATION FAILED"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "Required actions (Context Forgetting Prevention):"
    echo "  1. Re-read PLAN-BACKLOG.md to see current/pending work"
    echo "  2. Re-read workflow/before-plan.md"
    echo "  3. Re-read DESIGN.md and ROADMAP.md (if available)"
    echo "  4. Re-read 2-3 random validated plan files from PLAN-CHANGELOG.md for context"
    echo "  5. Re-read all unchecked plan files from PLAN-BACKLOG.md"
    if [ -n "$specific_action" ]; then
        echo "  6. $specific_action"
    else
        echo "  6. Review and fix the plan files"
    fi
    echo "  7. Run validation again: ./scripts/validate-plan.sh"
    echo ""
}

# Check if we're on the planning branch
if [ -d ".git" ]; then
    current_branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "unknown")
    if [ "$current_branch" != "planning" ]; then
        echo "Warning: Not on 'planning' branch (currently on '$current_branch')"
        echo "  Consider: git checkout -b planning"
        echo ""
    fi
fi

# Check if PLAN-BACKLOG.md exists
if [ ! -f "PLAN-BACKLOG.md" ]; then
    echo "Error: PLAN-BACKLOG.md not found"
    print_validation_failed "Create PLAN-BACKLOG.md per workflow/before-plan.md instructions"
    exit 1
fi

# Check if PLAN-CHANGELOG.md exists
if [ ! -f "PLAN-CHANGELOG.md" ]; then
    echo "Error: PLAN-CHANGELOG.md not found"
    print_validation_failed "Create PLAN-CHANGELOG.md per workflow/before-plan.md instructions"
    exit 1
fi

# Check if PLAN-BACKLOG.md has content
if ! grep -q "^\- \[" "PLAN-BACKLOG.md"; then
    echo "Error: PLAN-BACKLOG.md has no plan step items"
    print_validation_failed "Add plan steps to PLAN-BACKLOG.md with [ ] or [x] checkboxes"
    exit 1
fi

# Check if plan directory exists
if [ ! -d "plan" ]; then
    echo "Error: plan/ directory not found"
    print_validation_failed "Create the plan/ directory"
    exit 1
fi

# Check if there are any markdown files
shopt -s nullglob
files=(plan/*.md)
if [ ${#files[@]} -eq 0 ]; then
    echo "Error: No markdown files found in plan/"
    print_validation_failed "Create plan files in plan/ directory"
    exit 1
fi

# Sort files by name (to ensure proper order)
IFS=$'\n' sorted_files=($(sort <<<"${files[*]}"))
unset IFS

expected_seq_id=1
files_with_warnings=0

# Validate each plan file
for file in "${sorted_files[@]}"; do
    # Check if file is readable
    if [ ! -r "$file" ]; then
        echo "Error: Cannot read $file"
        print_validation_failed "Fix file permissions for $file"
        exit 1
    fi
    
    # Check if filename starts with a number (format: 01-, 02-, etc.)
    basename=$(basename "$file")
    if ! echo "$basename" | grep -qE "^[0-9]{2}-"; then
        echo "Warning: File $basename should be prefixed with 2-digit step number (e.g., 01-name.md)"
        files_with_warnings=$((files_with_warnings + 1))
    fi
    
    # Extract sequence IDs from the file
    seq_ids=($(grep -o "<!-- seq-id: [0-9]*" "$file" | grep -o "[0-9]*$" || true))
    
    if [ ${#seq_ids[@]} -eq 0 ]; then
        echo "Error: No sequence markers found in $file"
        print_validation_failed "Add exactly 3 sequence markers to $file (start, middle, end)"
        exit 1
    fi
    
    if [ ${#seq_ids[@]} -ne 3 ]; then
        echo "Warning: Expected 3 sequence markers (start, middle, end) in $file, found ${#seq_ids[@]}"
        files_with_warnings=$((files_with_warnings + 1))
    fi
    
    # Validate that sequence IDs are consecutive and match expected values
    for seq_id in "${seq_ids[@]}"; do
        if [ "$seq_id" -ne "$expected_seq_id" ]; then
            echo "Error: Expected seq-id: $expected_seq_id in $file, found seq-id: $seq_id"
            print_validation_failed "Fix sequence IDs to be consecutive and global across all plan files"
            exit 1
        fi
        expected_seq_id=$((expected_seq_id + 1))
    done
done

# Count total and validated steps in PLAN-BACKLOG.md
total_backlog_steps=$(grep -c "^\- \[.\]" "PLAN-BACKLOG.md" || true)
validated_backlog_steps=$(grep -c "^\- \[x\]" "PLAN-BACKLOG.md" || true)

# Count validated steps in PLAN-CHANGELOG.md if it has content
changelog_steps=0
if grep -q "^\- \[x\]" "PLAN-CHANGELOG.md" 2>/dev/null; then
    changelog_steps=$(grep -c "^\- \[x\]" "PLAN-CHANGELOG.md" || true)
fi

total_validated=$((validated_backlog_steps + changelog_steps))
total_steps=$((total_backlog_steps + changelog_steps))

# Display success summary
total_markers=$((expected_seq_id - 1))
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ PLAN VALIDATION PASSED"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Plan Files: ${#sorted_files[@]} file(s)"
echo "Sequence Markers: $total_markers marker(s) validated"
echo ""

if [ "$total_steps" -gt 0 ]; then
    echo "Progress:"
    if [ "$changelog_steps" -gt 0 ]; then
        echo "  - In CHANGELOG: $changelog_steps validated"
    fi
    echo "  - In BACKLOG: $validated_backlog_steps validated, $((total_backlog_steps - validated_backlog_steps)) pending"
    echo "  - Total: $total_validated / $total_steps steps validated"
    
    if [ "$total_validated" -gt 0 ]; then
        completion_pct=$((total_validated * 100 / total_steps))
        echo "  - Completion: $completion_pct%"
    fi
fi

if [ "$files_with_warnings" -gt 0 ]; then
    echo ""
    echo "⚠️  $files_with_warnings file(s) with warnings (non-critical)"
fi

echo ""
echo "Next: Run this validation before creating each new plan step."
echo "Remember to move validated steps to PLAN-CHANGELOG.md!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
