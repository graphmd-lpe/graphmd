# 💻 Development Phase Guide

This document provides detailed guidance for the GraphMD development phase, including LLM context forgetting prevention strategies and the three-layer tracking approach.

## Development Phase Overview

The development phase implements your project based on the validated plan. This phase uses a **three-layer approach** to maintain LLM context across long sessions and prevent information loss when context windows refresh.

## Three-Layer Context Tracking

Uses **three-layer approach** to maintain context across long sessions:

```mermaid
graph TB
    subgraph "Layer 1: Progress Tracking"
        A[DEV-BACKLOG.md]
        A1[Current/upcoming work<br/>← Current task]
        A2[DEV-CHANGELOG.md]
        A3[Completed history<br/>✓ With notes]
    end
    
    subgraph "Layer 2: Session Notes"
        B[DEV-JOURNAL.md]
        B1[Timestamped entries<br/>Decisions & context<br/>Why, not just what]
    end
    
    subgraph "Layer 3: Version History"
        C[Git Commits]
        C1["dev(step-X): ...<br/>Execution trail<br/>Diff verification"]
    end
    
    D[Context Refresh?] --> E[Read DEV-BACKLOG.md]
    E --> F[Read recent DEV-CHANGELOG.md entries]
    F --> G[Read last 2-3 DEV-JOURNAL.md entries]
    G --> H[Check git log]
    H --> I[Read current plan step]
    I --> J[Continue development]
    
    A --> A1
    A --> A2
    A2 --> A3
    B --> B1
    C --> C1
    
    style A fill:#e1ffe1
    style A2 fill:#d0ffd0
    style B fill:#fff4e1
    style C fill:#e1f5ff
    style D fill:#ffe1e1
```

## Layer 1: DEV-BACKLOG.md & DEV-CHANGELOG.md (Progress Tracking)

- **DEV-BACKLOG.md**: Current and upcoming work only
  - Mark `← CURRENT` for active step, `← NOW` for active subtask
  - Keep lean for quick reference
  - Move completed steps to DEV-CHANGELOG.md
- **DEV-CHANGELOG.md**: Historical record of completed work
  - Reverse chronological order (newest first)
  - Include completion date and notes
  - Provides context on what's been done
- First files to read on context refresh

## Layer 2: DEV-JOURNAL.md (Session Notes)

- Timestamped entries with decisions and context
- Why choices were made, not just what was done
- Last 2-3 entries provide narrative context
- Acts as handoff document between sessions

## Layer 3: Git Commits (Version History)

- Incremental commits after each subtask: `dev(step-X): description`
- Git log shows execution trail
- Diffs show what actually changed
- Provides verification of progress

## Validation

- Run `./templates/scripts/validate-dev.sh` periodically to check tracking status
- Shows completion percentage and progress bar
- Warns about missing commits or stale journal entries

## On Context Refresh

1. Run `./templates/scripts/validate-dev.sh` to check status
2. Read DEV-BACKLOG.md (current/upcoming work)
3. Read recent DEV-CHANGELOG.md entries (completed work context)
4. Read last 2-3 DEV-JOURNAL.md entries (decision context)
5. Read current plan step file
6. Check `git log --oneline -10` (recent work)

## Important Notes

**Note:** Ignore `<!-- seq-id: N -->` markers in plan files - they're planning phase artifacts only

## Getting Started

See [README.md](README.md#5-development-phase) for instructions on starting the development phase.

## 🔗 Related Documentation

- [README.md](README.md) - Main project documentation
- [PROJECT-STRUCTURE.md](PROJECT-STRUCTURE.md) - Project structure
- [templates/workflow/before-development.md](templates/workflow/before-development.md) - Development phase start instructions
- [templates/workflow/after-development.md](templates/workflow/after-development.md) - Development phase completion checklist
- [templates/scripts/validate-dev.sh](templates/scripts/validate-dev.sh) - Development validation script
