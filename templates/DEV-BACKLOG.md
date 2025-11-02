# Development Backlog

Track current and future implementation work. Move completed steps to DEV-CHANGELOG.md.

## Current Work

- [ ] Step 3: API Development (plan/03-api.md) ← CURRENT
  - [x] 3.1 Setup Express server
  - [x] 3.2 Create authentication endpoints
  - [ ] 3.3 Implement user CRUD ← NOW
  - [ ] 3.4 Add validation middleware
  - [ ] 3.5 Write API tests

## Upcoming Work

- [ ] Step 4: Frontend Integration (plan/04-frontend.md)
  - [ ] 4.1 Setup React app
  - [ ] 4.2 Create components
  - [ ] 4.3 Connect to API
  - [ ] 4.4 Add error handling

- [ ] Step 5: Testing & Deployment (plan/05-testing.md)
  - [ ] 5.1 Integration tests
  - [ ] 5.2 E2E tests
  - [ ] 5.3 Configure CI/CD
  - [ ] 5.4 Deploy to staging

## Workflow

- Mark subtasks with `[x]` when completed
- Mark active step with `← CURRENT` and active subtask with `← NOW`
- Commit after each completed subtask: `dev(step-X): description`
- Update DEV-JOURNAL.md with important decisions
- When a step is fully completed:
  1. Mark it `[x]` with `✓` in this file
  2. Move it to DEV-CHANGELOG.md with completion date and notes
  3. Remove it from this file

## Notes

- This file should only contain current and future work
- Keep it lean for quick reference
- Historical record lives in DEV-CHANGELOG.md

