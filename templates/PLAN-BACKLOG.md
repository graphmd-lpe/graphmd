# Plan Backlog

Track current and pending plan creation work. Move validated steps to PLAN-CHANGELOG.md.

## Current Work

- [ ] Step 3: API Development - plan/03-api.md ← Current

## Upcoming Work

- [ ] Step 4: Frontend Integration - plan/04-frontend.md
- [ ] Step 5: Testing & Deployment - plan/05-testing.md

## Workflow

- Create/update plan step file
- Run `./scripts/validate-plan.sh` to check correctness
- Mark step with `[x]` when validation passes
- When a step is validated:
  1. Mark it `[x]` with `✓` in this file
  2. Move it to PLAN-CHANGELOG.md with validation timestamp and notes
  3. Remove it from this file
- On validation failure:
  - Re-read PLAN-BACKLOG.md, workflow/before-plan.md, DESIGN.md, ROADMAP.md
  - Read 2-3 random validated files from PLAN-CHANGELOG.md (for examples)
  - Read all unchecked files still in this backlog
  - Fix issues and retry validation

## Notes

- This file should only contain current and pending work
- Keep it lean for quick reference during planning
- Historical record lives in PLAN-CHANGELOG.md
- Unchecked items need to be re-read on validation failure
- Validated items are in PLAN-CHANGELOG.md and don't need re-reading
