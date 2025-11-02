# 🏗️ Design Phase Guide

## Design Phase Overview

Based on your research findings, produce a comprehensive system design: architecture, data models, interfaces, and key technical decisions. Use Architecture Decision Records (ADRs) for important choices and keep stable identifiers for cross-referencing.

## Design Outputs

Create a `DESIGN.md` with the following sections:
- Architecture Overview — components and interactions
- Technology Stack — choices and rationale
- Data Models — entities, relationships, schema
- Interfaces & Contracts — APIs, endpoints, schemas
- Key Decisions & ADRs — rationale and trade-offs
- Diagrams — mermaid/ASCII/system views
- Non-Functional Requirements — performance, security, reliability, scalability, observability
- Risks, Constraints, Assumptions — with mitigations
- Open Questions — follow-ups for later phases

Optional directory structure:

```
design/
  adr/
    0001-use-postgres.md
  diagrams/
    architecture.mmd
DESIGN.md
```

**Stable identifiers:**
- `<design-id>` — identifies a design element or section used across documents

## Recommended Prompts

- "Design `<scope>` based on the research in `RESEARCH.md`."
- "Create an Architecture Decision Record for `<decision-topic>`."
- "Propose a data model for `<use-case>` with entities and relationships."
- "Define the API contract for `<service>` including endpoints and schemas."
- "List non-functional requirements and risks for `<system>` with rationale."

## Typical LLM Output

- A design with stable identifiers: `<design-id>`
- ADRs capturing key decisions with rationale and alternatives
- Diagrams (mermaid/ASCII) for architecture and data flows
- API definitions with request/response schemas

## Design Workflow

1. Read `RESEARCH.md` and optional `research/` artifacts
2. Draft architecture overview and system boundaries
3. Select technology stack; write ADRs for important choices
4. Model data: entities, relationships, schema evolution considerations
5. Define interfaces and API contracts (schemas, errors, versioning)
6. Specify non-functional requirements and constraints
7. Identify risks, assumptions, and mitigations; note open questions
8. Add diagrams (mermaid/ASCII) to illustrate components and flows
9. Save `DESIGN.md` and optional `design/` files; commit

## Best Practices

- Use ADRs to document decisions, alternatives, and consequences
- Keep artifacts concise and focused; link back to `RESEARCH.md`
- Prefer mermaid diagrams for reproducible visuals
- Maintain stable identifiers for cross-referencing in later phases
- Capture trade-offs and assumptions explicitly

## Getting Started

See [templates/workflow/before-design.md](templates/workflow/before-design.md) for detailed instructions to kick off the design phase.

## 🔗 Related Documentation

- [README.md](README.md) — Main project documentation and workflow overview
- [PROJECT-STRUCTURE.md](PROJECT-STRUCTURE.md) — Repository layout and generated files
- [templates/workflow/before-design.md](templates/workflow/before-design.md) — Design phase start instructions
- [templates/workflow/after-design.md](templates/workflow/after-design.md) — Design completion checklist
