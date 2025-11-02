# Reproducible Multi‑Step Plan Instructions

## Step 0: Create Planning Branch

Create a dedicated `planning` branch for the planning phase:

```bash
git checkout -b planning
```

All planning work will be done on this branch and merged back to main when complete.

## Step 1: Create PLAN-BACKLOG.md and PLAN-CHANGELOG.md

Create a `PLAN-BACKLOG.md` file to track current/pending plan work:

```markdown
# Plan Backlog

Track current and pending plan work. Move validated steps to PLAN-CHANGELOG.md.

## Current Work

- [ ] Step 1: [Name] - plan/01-name.md ← Current

## Upcoming Work

- [ ] Step 2: [Name] - plan/02-name.md
- [ ] Step 3: [Name] - plan/03-name.md
```

Create a `PLAN-CHANGELOG.md` file to track validated plan steps:

```markdown
# Plan Changelog

Historical record of validated plan steps. Append completed plan validations here.

## Validated Steps

(Steps will be added here as they are validated)
```

**Update these files as you progress:**
- Mark steps with `[x]` when validated in PLAN-BACKLOG.md
- Move validated steps to PLAN-CHANGELOG.md with timestamp and notes
- Remove validated steps from PLAN-BACKLOG.md
- Keep PLAN-BACKLOG.md lean with only current/upcoming work

## Step 2: Create Plan Files

### Per-Step Requirements
1. **Separate Markdown file per step**, with the **filename prefixed by the step number**, e.g. `plan/01-setup.md`, `plan/02-configure.md`, `plan/03-deploy.md`.
2. Include a **thorough description** of the step with **low-level, reproducible tasks** (checklists are fine). Tasks may include **fenced code blocks**.
3. Insert **one** global sequence marker **in the start, middle, and end of the document** on its own line, using an incrementing ID in this exact format:  
   `<!-- seq-id: 1 -->` (then `<!-- seq-id: 2 -->`, `<!-- seq-id: 3 -->`, … for each step).

> **Main requirement:** The plan must be **fully reproducible**— someone else can follow it end-to-end.

## Step 3: Validation Loop

**Before creating each new plan step file**, you must run validation:
```bash
./scripts/validate-plan.sh
```

- If validation **passes**:
  1. Mark the step as `[x]` in PLAN-BACKLOG.md
  2. Move the step to PLAN-CHANGELOG.md with timestamp and validation notes
  3. Remove the step from PLAN-BACKLOG.md
  4. Continue to create the next step
- If validation **fails**:
  1. Re-read `PLAN-BACKLOG.md` to see current/pending work
  2. Re-read `workflow/before-plan.md` (this file)
  3. Re-read `DESIGN.md` and `ROADMAP.md`
  4. **Re-read 2-3 random validated plan files from PLAN-CHANGELOG.md** (for context and examples)
  5. **Re-read all unchecked plan files from PLAN-BACKLOG.md** (the ones needing work)
  6. Fix issues
  7. Run validation again

**After completing each step**, you must append this reminder to your prompt response:

> **Next: Run `./scripts/validate-plan.sh` before creating document for the next step.**

## Artifacts

### Input Artifacts (if available)
- `DESIGN.md` file (design documentation)
- `ROADMAP.md` file (roadmap)

### Output Artifacts
- `PLAN-BACKLOG.md` file (current and pending plan work)
- `PLAN-CHANGELOG.md` file (validated plan steps)
- `plan/` directory containing numbered plan files (e.g., `01-setup.md`, `02-configure.md`)

### Working Branch
- `planning` branch (created at Step 0, merged after completion)

## Guidance
- Only modify `PLAN-BACKLOG.md`, `PLAN-CHANGELOG.md`, and files in the `plan/` directory
- Reference `DESIGN.md` and `ROADMAP.md` if available for context
- The plan must be **fully reproducible** — someone else can follow it end-to-end

Stand by for further instructions.
