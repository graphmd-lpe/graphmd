# Development Phase Instructions

## Overview
Follow the detailed plan in the `plan/` directory to develop the project. Execute each step systematically and completely.

All development files should be created in the `development/` directory.

## Step 0: Create Development Branch

Create a dedicated `development` branch for the development phase:

```bash
git checkout main
git checkout -b development
```

All development work will be done on this branch and merged back to main when complete.

## Step 1: Create DEV-BACKLOG.md and DEV-CHANGELOG.md

Create a `DEV-BACKLOG.md` file to track current and future work:

```markdown
# Development Backlog

Track current and future work. Move completed steps to DEV-CHANGELOG.md.

## Current Work

- [ ] Step 1: Setup (plan/01-setup.md) ← CURRENT
  - [ ] 1.1 Task description ← NOW
  - [ ] 1.2 Task description

## Upcoming Work

- [ ] Step 2: Database (plan/02-database.md)
  - [ ] 2.1 Task description
```

Create a `DEV-CHANGELOG.md` file to track completed work:

```markdown
# Development Changelog

Historical record of completed implementation steps.

## Completed Steps

(Steps will be added here as they are completed)
```

**Update these files as you work:**
- Mark tasks with `[x]` when completed in DEV-BACKLOG.md
- Mark current step with `← CURRENT` and current subtask with `← NOW`
- When a step is fully completed:
  1. Move it to DEV-CHANGELOG.md with completion date and notes
  2. Remove it from DEV-BACKLOG.md
- Keep DEV-BACKLOG.md lean with only current/upcoming work

## Step 2: Create DEV-JOURNAL.md

Create a `DEV-JOURNAL.md` file for session notes:

```markdown
# Development Journal

## YYYY-MM-DD HH:MM
- **Working on:** Step X.Y - description
- **Decisions made:** Key technical choices
- **Next:** Immediate next tasks
```

**Add entries:**
- At the start of each session
- When making important decisions
- Before context might refresh
- Keep last 5-10 entries, archive older ones

## Step 3: Create Development Dockerfile

Create a `development/Dockerfile.dev` file for the development environment. 
It should be used to run all commands inside the development container.

## Step 4: Development Loop

### For Each Development Step:

1. **Read the plan file** for the current step
2. **Update DEV-BACKLOG.md** with subtasks for this step
3. **Add DEV-JOURNAL.md entry** noting what you're starting
4. **Develop the tasks** following the plan exactly
5. **Mark tasks as `[x]`** in DEV-BACKLOG.md as you complete them
6. **Commit incrementally:** After completing each meaningful subtask:
```bash
git add development/
git commit -m "dev(step-X): complete [subtask description]"
```
7. **Update DEV-JOURNAL.md** with decisions made and next steps
8. **Move to next step** when all subtasks are complete

### Periodic Validation:

Run validation periodically to ensure tracking is up-to-date:
```bash
./scripts/validate-dev.sh
```

This checks:
- DEV-BACKLOG.md and DEV-JOURNAL.md exist and have content
- Tasks are being tracked with checkboxes
- Journal has recent dated entries
- Git commits are being made
- Shows progress percentage

### On Context Refresh:

If your context refreshes, immediately:
1. **Run `./scripts/validate-dev.sh`** to check status
2. **Read DEV-BACKLOG.md** to see current/upcoming work
3. **Read recent DEV-CHANGELOG.md entries** for completed work context
4. **Read last 2-3 DEV-JOURNAL.md entries** for decision context
5. **Read workflow/before-development.md** (this file) for instructions
6. **Read current and next plan step files**
7. **Check git log** for recent commits
8. Continue from where you left off

## Artifacts

### Input Artifacts (if available)
- `plan/` directory (detailed implementation plan)
- `RESEARCH.md` file (research findings)
- `DESIGN.md` file (design documentation)
- `ROADMAP.md` file (roadmap)

### Output Artifacts
- `DEV-BACKLOG.md` file (current and future development work)
- `DEV-CHANGELOG.md` file (completed development steps)
- `DEV-JOURNAL.md` file (session notes and decisions)
- `development/` directory (all project implementation files)
- `development/Dockerfile.dev` file (development environment)

### Working Branch
- `development` branch (created at Step 0, merged after completion)

## Guidance
- Document issues and deviations in `DEV-JOURNAL.md`
- Maintain high code quality and follow best practices
- Test your implementation as you build
- Commit frequently with descriptive messages using format: `dev(step-X): complete [subtask description]`

Begin with Step 0: Create development branch, then proceed with Step 1: Create tracking files.

Stand by for further instructions.
