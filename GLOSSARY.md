# GraphMD Glossary

## Core Concepts

### GraphMD
A Literate Programming Environment (LPE) where Markdown documents serve as the primary artifact for executable knowledge graphs. It enables bidirectional integration between AI Agents and the environment, transforming Markdown into executable specifications.

### LPE (Literate Programming Environment)
An environment that treats programs as literature for humans, interleaving narrative and code. In GraphMD, the Markdown document is the primary artifact, and execution is driven from within the prose.

### MBEKG (Markdown-Based Executable Knowledge Graphs)
Knowledge graphs whose canonical source is human-readable Markdown that's also machine-executable. Documents and sections encode entities and relations; fenced fenced code blocks and commands define executable behaviors.

### Knowledge Loop
The collaborative intelligence model: **Humans** write prompts → **AI Agents** perform actions → **GraphMD** orchestrates → **Knowledge** emerges.

### Agent
An AI coding assistant that reads prompts and Markdown documents, performs actions (extract knowledge, generate documents, execute fenced code blocks), and interprets results.

## Tracking Documents

### Backlog
A document tracking current and pending work items. Used in both Planning (`PLAN-BACKLOG.md`) and Development (`DEV-BACKLOG.md`) phases. Contains checkboxes for tasks and is kept lean with only active/upcoming work.

### Changelog
A historical record of completed work. Used in both Planning (`PLAN-CHANGELOG.md`) and Development (`DEV-CHANGELOG.md`) phases. Completed items are moved from the Backlog to the Changelog with timestamps and notes.

### Journal
A session-based log used in Development (`DEV-JOURNAL.md`) for recording decisions, progress, and next steps. Particularly important for LLM context tracking and preventing context forgetting.

## Planning Phase Concepts

### Sequence Markers
HTML comments placed in plan files to track validation state. Format: `<!-- seq-id: N -->` where N is an incrementing integer. Each plan step must have markers at the start, middle, and end of the document.

### Validation Loop
The process of running `./scripts/validate-plan.sh` before creating each new plan step. Ensures plans are properly formatted, numbered, and contain required sequence markers.

### Plan Step
A numbered Markdown file (e.g., `plan/01-setup.md`) containing a thorough description with low-level, reproducible tasks. Must include sequence markers and be validated before proceeding to the next step.

## Development Phase Concepts

### LLM Context Tracking
A three-layer approach to prevent context forgetting:
1. **Backlog Layer** - Current/upcoming work with task checkboxes
2. **Changelog Layer** - Historical record of completed work
3. **Journal Layer** - Session notes with decisions and next steps

### Development Container
A Docker-based development environment defined in `development/Dockerfile.dev` used to run all commands inside an isolated container.

### Incremental Commits
The practice of committing after each meaningful subtask with descriptive messages following the format: `dev(step-X): complete [subtask description]`

## Git Workflow Concepts

### Planning Branch
A dedicated git branch (`planning`) created at the start of the Planning phase. All planning work happens on this branch before being merged back to `main`.

### Development Branch
A dedicated git branch (`development`) created at the start of the Development phase. All development work happens on this branch before being merged back to `main`.

### Conventional Commits
A commit message format using prefixes: `research:`, `design:`, `roadmap:`, `plan:`, `dev:` for phase commits. Development commits use the format `dev(step-X):` for tracking.

### Pre-commit Hook
A git hook (`templates/scripts/pre-commit`) that automatically validates plans before committing. Installed via `cp scripts/pre-commit .git/hooks/pre-commit`.

## Literate Programming Concepts

### Narrative-First Documents
Documents where prompts, rationale, and design live alongside executable fenced code blocks. The narrative explains the "why" and "how" together.

### Executable Code Fences
Markdown fenced code blocks that Agents can execute directly. In GraphMD, these define behaviors that can be run by agents.

### Weave and Tangle Model
- **Weave**: Generate human-friendly documentation (planned in Publisher)
- **Tangle**: Extract and execute code (planned in Sandbox)

### Provenance
The tracking of prompts, actions, results, and decisions recorded in-place for reproducibility. Ensures the evolution of the knowledge graph is traceable.

## Knowledge Graph Concepts

### Nodes
Documents or sections that represent entities, concepts, or processes in the knowledge graph.

### Edges
Markdown links, anchors, and IDs that connect entities and encode relations between nodes.

### Metadata
Front matter, inline tags, and attributes that provide typing, provenance, and policy context for nodes.

### Artifacts
First-class results (logs, tables, files, etc.) that are referenced back into the documents as part of the knowledge graph.

## Best Practices

### Prompt Safety Guard
All workflow prompts end with **"Stand by for further instructions."** to prevent the Agent from taking unintended actions beyond the prompt's scope. This ensures the Agent waits for explicit next instructions and provides clear boundaries between workflow phases.

### Fresh Agent Session
Starting a new LLM conversation context for Planning and Development phases to prevent confusion between different types of work and ensure clean context.

### Phase Separation
Using independent prompt sessions for different phases to ensure fresh LLM context and prevent mixing concerns.

### Context Refresh
When an LLM session loses context, the context tracking state machine immediately runs validation scripts, it forces the Agent to read backlog/changelog/journal files, and review workflow instructions to restore context.

## Ecosystem Components

### Publisher
A planned tool that weaves human-friendly documentation from Markdown sources.

### Sandbox
A planned safe, provenance-aware execution environment for Agent actions and Markdown fenced code blocks.

### Markdown Toolkit
Planned suite of tools for Markdown validation, generation, quality assurance, refactoring, and encyclopedia.

### Agent Orchestration Toolkit
Planned tools for managing agent workflows, crew management, and coordination.

### Knowledge Graph Toolkit
Planned tools for working with RDF, OWL, and other semantic web standards.
