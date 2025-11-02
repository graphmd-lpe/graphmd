#!/bin/bash
set -e

# Validate development progress and tracking (Three-Layer Context Tracking)

# Function to print validation failure message
print_validation_failed() {
    local specific_action="$1"
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "❌ DEVELOPMENT VALIDATION FAILED"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "Required actions (Context Forgetting Prevention):"
    echo "  1. Re-read DEV-BACKLOG.md to see current/upcoming work"
    echo "  2. Re-read recent DEV-CHANGELOG.md entries for completed work context"
    echo "  3. Re-read last 2-3 DEV-JOURNAL.md entries"
    echo "  4. Re-read workflow/before-development.md"
    echo "  5. Re-read current plan step file from plan/ directory"
    if [ -n "$specific_action" ]; then
        echo "  6. $specific_action"
    else
        echo "  6. Update tracking files and continue development"
    fi
    echo "  7. Run validation again: ./scripts/validate-dev.sh"
    echo ""
}

# Check if we're on the development branch
if [ -d ".git" ]; then
    current_branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "unknown")
    if [ "$current_branch" != "development" ]; then
        echo "Warning: Not on 'development' branch (currently on '$current_branch')"
        echo "  Consider: git checkout -b development"
        echo ""
    fi
fi

# Layer 1: Progress Tracking - Check DEV-BACKLOG.md
if [ ! -f "DEV-BACKLOG.md" ]; then
    echo "Error: DEV-BACKLOG.md not found"
    print_validation_failed "Create DEV-BACKLOG.md per workflow/before-development.md instructions"
    exit 1
fi

# Layer 2: Session Notes - Check DEV-JOURNAL.md
if [ ! -f "DEV-JOURNAL.md" ]; then
    echo "Error: DEV-JOURNAL.md not found"
    print_validation_failed "Create DEV-JOURNAL.md per workflow/before-development.md instructions"
    exit 1
fi

# Check if DEV-CHANGELOG.md exists (not required initially)
if [ ! -f "DEV-CHANGELOG.md" ]; then
    echo "Warning: DEV-CHANGELOG.md not found"
    echo "  (This is OK if you haven't completed any steps yet)"
    echo "  Create DEV-CHANGELOG.md to track completed work"
    echo ""
fi

# Check if development directory exists
if [ ! -d "development" ]; then
    echo "Warning: development/ directory not found"
    echo "  (This is OK if you haven't started coding yet)"
    echo ""
fi

# Check if Dockerfile.dev exists in development directory
if [ -d "development" ] && [ ! -f "development/Dockerfile.dev" ]; then
    echo "Warning: development/Dockerfile.dev not found"
    echo "  Consider creating a development environment Dockerfile"
    echo ""
fi

# Check if DEV-BACKLOG.md has content
if ! grep -q "^\- \[" "DEV-BACKLOG.md"; then
    echo "Error: DEV-BACKLOG.md has no task items"
    print_validation_failed "Add plan steps to DEV-BACKLOG.md with [ ] checkboxes"
    exit 1
fi

# Count completed vs total tasks
total_tasks=$(grep -c "^\- \[.\]" "DEV-BACKLOG.md" || true)
completed_tasks=$(grep -c "^\- \[x\]" "DEV-BACKLOG.md" || true)

# Count tasks from DEV-CHANGELOG.md if it exists (these are completed)
changelog_tasks=0
if [ -f "DEV-CHANGELOG.md" ]; then
    changelog_tasks=$(grep -c "^\- \[x\]" "DEV-CHANGELOG.md" || true)
fi

# Total completed includes both backlog [x] and changelog tasks
total_completed=$((completed_tasks + changelog_tasks))

# Total tasks includes both backlog and changelog
all_tasks=$((total_tasks + changelog_tasks))

if [ "$all_tasks" -eq 0 ]; then
    echo "Error: No tasks found in DEV-BACKLOG.md or DEV-CHANGELOG.md"
    print_validation_failed "Add tasks to DEV-BACKLOG.md"
    exit 1
fi

# Check if there's a current step marker (← CURRENT)
has_current=false
if grep -q "← CURRENT" "DEV-BACKLOG.md"; then
    has_current=true
    echo "✓ Found ← CURRENT marker in DEV-BACKLOG.md"
else
    echo "Warning: No '← CURRENT' marker found in DEV-BACKLOG.md"
    echo "  Consider marking your current step with: ← CURRENT"
fi

# Check if there's a current task marker (← NOW)
if grep -q "← NOW" "DEV-BACKLOG.md"; then
    echo "✓ Found ← NOW marker in DEV-BACKLOG.md"
else
    if [ "$has_current" = true ]; then
        echo "Warning: No '← NOW' marker found in DEV-BACKLOG.md"
        echo "  Consider marking your current subtask with: ← NOW"
    fi
fi

# Check if DEV-JOURNAL.md has properly formatted entries
if ! grep -qE "^## [0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}" "DEV-JOURNAL.md"; then
    echo "Error: DEV-JOURNAL.md has no properly dated entries"
    print_validation_failed "Add journal entries with format: ## YYYY-MM-DD HH:MM"
    exit 1
fi

# Get the most recent journal entry date
latest_entry=$(grep -oE "^## [0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}" "DEV-JOURNAL.md" | head -1 | sed 's/## //')

if [ -n "$latest_entry" ]; then
    echo "✓ Latest journal entry: $latest_entry"
else
    echo "Warning: Could not parse latest journal entry date"
fi

# Layer 3: Version History - Check git commits if we're in a git repository
if [ -d ".git" ]; then
    # Check if there are any development commits with proper format
    dev_commits=$(git log --oneline --grep="^dev(" 2>/dev/null | wc -l | tr -d ' ')
    
    if [ "$dev_commits" -gt 0 ]; then
        echo "✓ Found $dev_commits 'dev(step-X)' commit(s)"
        
        # Show last few dev commits
        last_commits=$(git log --oneline --grep="^dev(" -5 2>/dev/null | head -3)
        if [ -n "$last_commits" ]; then
            echo ""
            echo "Recent dev commits:"
            echo "$last_commits" | sed 's/^/  /'
            echo ""
        fi
    else
        echo "Warning: No 'dev(step-X):' commits found in git history"
        echo "  Remember to commit after each subtask: git commit -m 'dev(step-X): description'"
        echo ""
    fi
    
    # Check if there are uncommitted changes in development/
    if [ -d "development" ]; then
        uncommitted=$(git status --porcelain development/ 2>/dev/null | wc -l | tr -d ' ')
        if [ "$uncommitted" -gt 0 ]; then
            echo "⚠️  $uncommitted uncommitted change(s) in development/"
            echo "  Consider committing your work incrementally"
            echo ""
        fi
    fi
fi

# Display progress summary
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ DEVELOPMENT VALIDATION PASSED"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Three-Layer Context Tracking Status:"
echo ""

# Layer 1: Progress Tracking
echo "Layer 1 - Progress Tracking:"
if [ "$changelog_tasks" -gt 0 ]; then
    echo "  • CHANGELOG: $changelog_tasks completed"
fi
echo "  • BACKLOG: $completed_tasks completed, $((total_tasks - completed_tasks)) pending"
echo "  • Total: $total_completed / $all_tasks tasks"

# Show completion percentage and progress bar
if [ "$all_tasks" -gt 0 ]; then
    completion_pct=$((total_completed * 100 / all_tasks))
    echo "  • Completion: $completion_pct%"
    
    # Show progress bar
    echo -n "  "
    echo -n "["
    for i in $(seq 1 20); do
        if [ $((i * 5)) -le "$completion_pct" ]; then
            echo -n "█"
        else
            echo -n "░"
        fi
    done
    echo "]"
fi

echo ""

# Layer 2: Session Notes
echo "Layer 2 - Session Notes:"
if [ -n "$latest_entry" ]; then
    echo "  • DEV-JOURNAL: Latest entry at $latest_entry"
else
    echo "  • DEV-JOURNAL: Present but date format unclear"
fi

echo ""

# Layer 3: Version History
echo "Layer 3 - Version History:"
if [ -d ".git" ]; then
    if [ "$dev_commits" -gt 0 ]; then
        echo "  • Git: $dev_commits development commits"
    else
        echo "  • Git: No 'dev(step-X)' commits yet"
    fi
else
    echo "  • Git: Not a git repository"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Keep all three layers updated as you work:"
echo "  1. DEV-BACKLOG.md & DEV-CHANGELOG.md (Progress)"
echo "  2. DEV-JOURNAL.md (Session notes & decisions)"
echo "  3. Git commits (Version history: dev(step-X): ...)"
echo ""
echo "Move completed steps to DEV-CHANGELOG.md to keep BACKLOG lean."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

