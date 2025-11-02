# 🏁 Roadmap Phase Guide

## Roadmap Phase Overview

Create a high-level roadmap that sequences major phases, milestones, and dependencies based on your research and design. Keep it strategic and outcome-focused; detailed steps belong to the planning phase.

## Roadmap Outputs

Create a `ROADMAP.md` with:
- Executive Summary — concise overview of goals and scope
- Phases — major phases/features with goals and deliverables
- Milestones — key checkpoints and success criteria
- Dependencies — ordering constraints and cross-phase links
- Priorities — value-driven ordering with justification

**Stable identifiers:**
- `<phase-id>` — identifies a roadmap phase used in links and references
- `<milestone-id>` — identifies a milestone within a phase

## Recommended Prompts

- "Create a high-level roadmap based on `RESEARCH.md` and `DESIGN.md`."
- "Break the project into phases with milestones and dependencies."
- "Prioritize phases for MVP; justify ordering by value and risk."
- "Define success criteria for milestone `<milestone-id>`."

## Typical LLM Output

- A roadmap document with stable identifiers: `<phase-id>`, `<milestone-id>`
- Clear phases with goals, deliverables, and dependencies
- Prioritization rationale for MVP sequencing

## Roadmap Workflow

1. Read `RESEARCH.md` and `DESIGN.md`
2. Identify major phases/features from goals and constraints
3. Define milestones and success criteria per phase
4. Map dependencies and ordering constraints
5. Prioritize for MVP and justify the order
6. Save `ROADMAP.md`; commit

## Best Practices

- Keep it high-level; defer execution details to the plan phase
- Express dependencies explicitly; avoid ambiguous ordering
- Tie priorities to value, risk, and feasibility
- Use stable identifiers for cross-referencing in plans

## Getting Started

See [templates/workflow/before-roadmap.md](templates/workflow/before-roadmap.md) for detailed kickoff instructions.

## 🔗 Related Documentation

- [README.md](README.md) — Main project documentation and workflow overview
- [PROJECT-STRUCTURE.md](PROJECT-STRUCTURE.md) — Repository layout and generated files
- [templates/workflow/before-roadmap.md](templates/workflow/before-roadmap.md) — Roadmap phase start instructions
- [templates/workflow/after-roadmap.md](templates/workflow/after-roadmap.md) — Roadmap completion checklist
