# 🔎 Research Phase Guide

## Research Phase Overview

The research phase develops a deep understanding of the problem domain, constraints, and feasible approaches before design and planning. Favor small, focused outputs and stable identifiers that will be reused in later phases.

## Research Outputs

Create a `RESEARCH.md` file with:
- Problem analysis
- Technology options
- Variants for promising options
- Solutions for selected variants
- Constraints and limitations
- Risks and dependencies
- Recommendations and rationale

**Optional:** Create a `research/` directory for detailed research artifacts.

**Stable identifiers:** Use and keep stable references across documents:
- `<option-id>` — identifies a candidate option
- `<variant-id>` — identifies a variant of an option
- `<solution-id>` — identifies a concrete solution proposal

Example structure for `RESEARCH.md`:

```markdown
# Research

## Problem Analysis
...

## Technology Options
...

## Constraints and Limitations
...

## Recommendations
...
```

Optional detailed layout in `research/` directory:

```
research/
  problem-analysis.md
  options.md
  variants.md
  solutions.md
  constraints.md
  risks.md
  recommendations.md
```

## Recommended Prompts

- "Research `<problem>`"
- "What are the options for `<problem>`?"
  - Short form: "offer options for `<problem>`?"
- "What are the variants for `<option-id>`?"
  - Short form: "offer variants for `<option-id>`?"
- "What are the solutions for `<variant-id>`?"
  - Short form: "offer solutions for `<variant-id>`?"

## Typical LLM Output

- A list of options, variants, or solutions with stable identifiers: `<option-id>`, `<variant-id>`, `<solution-id>`
- Focused notes and comparisons instead of long narrative
- Clear trade-offs, constraints, and risks

## Research Workflow

1. Analyze the problem statement and requirements
2. Propose options and assign `<option-id>` identifiers
3. For key options, propose variants and assign `<variant-id>` identifiers
4. For promising variants, propose solutions with `<solution-id>` identifiers
5. Compare trade-offs, constraints, and risks
6. Recommend a direction with rationale and references
7. Save artifacts under `research/` and commit

## Best Practices

- Prefer small, focused outputs over large documents
- Use slower LLM models with deliberate reasoning when depth matters
- Keep identifiers stable and reuse them in later phases
- Cite sources and link references when possible

## Getting Started

See [README.md](README.md) (Research phase in Quick Start) for step-by-step usage.

## 🔗 Related Documentation

- [README.md](README.md) — Main project documentation and workflow overview
- [PROJECT-STRUCTURE.md](PROJECT-STRUCTURE.md) — Repository layout and generated files
- [templates/workflow/before-research.md](templates/workflow/before-research.md) — Research phase start instructions
- [templates/workflow/after-research.md](templates/workflow/after-research.md) — Research completion checklist
