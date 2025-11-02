# After Plan Phase - Validation Checklist

## Validation Steps

1. **Run the validation script:**
   ```bash
   ./scripts/validate-plan.sh
   ```

2. **Manual review:**
   - All steps have been validated and moved to PLAN-CHANGELOG.md
   - PLAN-BACKLOG.md is empty or only has any remaining steps marked `[x]`
   - All steps are numbered sequentially
   - Tasks are detailed and reproducible
   - Someone else could follow the plan end-to-end

If validation fails stop and review the plan files. If tasks are unclear, update the plan files. Once all checks pass, you have completed the Planning phase.

## Git Workflow

### Install Pre-commit Hook
To automatically validate plans before committing:
```bash
cp scripts/pre-commit .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
```

### Commit and Merge Planning Branch

1. **Commit all plan files:**
   ```bash
   git add PLAN-BACKLOG.md PLAN-CHANGELOG.md plan/
   git commit -m "plan: create validated implementation plan"
   ```

2. **Switch to main branch:**
   ```bash
   git checkout main
   ```

3. **Merge planning branch:**
   ```bash
   git merge planning
   ```

4. **Optional - Delete planning branch:**
   ```bash
   git branch -d planning
   ```

The pre-commit hook will automatically run `scripts/validate-plan.sh` if installed.

You have completed the Planning phase. The plan is now on the main branch.

Stand by for further instructions.
