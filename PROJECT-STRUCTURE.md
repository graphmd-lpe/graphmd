# 📁 GraphMD Project Structure

This document describes the complete project structure of the GraphMD project, including both template files (tracked in git) and generated files (created when following workflow phases).

## Project Structure

```
.
├── README.md                    # Project overview and workflow guide
├── PROJECT-STRUCTURE.md         # This file - detailed project structure documentation
├── GLOSSARY.md                  # Definitions of key terms and concepts
├── ECOSYSTEM.md                 # End-to-end view of components and integrations
├── MANIFESTO.md                 # Project manifesto and principles
├── MVP-WORKFLOW.md              # Detailed workflow phase guide
├── RESEARCH-PHASE.md            # Research phase detailed guide
├── DESIGN-PHASE.md              # Design phase detailed guide
├── ROADMAP-PHASE.md             # Roadmap phase detailed guide
├── PLANNING-PHASE.md            # Planning phase detailed guide
├── DEVELOPMENT-PHASE.md         # Development phase detailed guide
├── MVP-DEVELOPMENT.md           # MVP development guide
├── TEMPLATES.md                 # Template examples for tracking files
├── CONTRIBUTING.md              # Contribution guidelines and development commands
├── AUTHORS                      # Project authors and contributors
├── COPYRIGHT                    # Copyright information
├── LICENSE                      # Project license (MIT-0 and CC0-1.0)
├── LICENSES/                    # License text files
│   ├── MIT-0.txt
│   └── CC0-1.0.txt
├── Makefile                     # Development commands
├── examples/                    # Example projects (planned)
│   ├── elixir-webservice/
│   └── rust-wasm-benchmarks/
├── templates/
│   ├── workflow/
│   │   ├── before-research.md      # Instructions for research phase
│   │   ├── after-research.md       # Research completion checklist
│   │   ├── before-design.md        # Instructions for design phase
│   │   ├── after-design.md         # Design completion checklist
│   │   ├── before-roadmap.md       # Instructions for roadmap phase
│   │   ├── after-roadmap.md        # Roadmap completion checklist
│   │   ├── before-plan.md          # Instructions for creating plans
│   │   ├── after-plan.md           # Plan validation checklist
│   │   ├── before-development.md   # Instructions for development phase
│   │   └── after-development.md    # Post-development review instructions
│   ├── scripts/
│   │   ├── validate-plan.sh   # Plan phase validation script
│   │   ├── validate-dev.sh    # Development phase validation script
│   │   ├── pre-commit          # Git pre-commit hook
│   │   └── tests/              # Script tests
│   │       ├── README.md
│   │       ├── run-all-tests.sh
│   │       ├── test-helpers.sh
│   │       ├── test-validate-plan.sh
│   │       ├── test-validate-dev.sh
│   │       └── test-pre-commit.sh
│   ├── DEV-BACKLOG.md
│   ├── DEV-CHANGELOG.md
│   ├── PLAN-BACKLOG.md
│   ├── PLAN-CHANGELOG.md
│   └── DEV-JOURNAL.md
├── scripts/
│   └── emergency/
│       ├── restore-from-backup-mirror.sh  # Emergency restore script
│       └── RESTORE.md                      # Restore documentation
```

## File Categories

### Configuration Files

- **`.vale.ini`** - Vale prose linter configuration with custom rules
- **`.markdownlint.json`** - markdownlint style configuration
- **`.gitignore`** - Git ignore patterns for generated and temporary files
- **`Makefile`** - Development automation commands

### Documentation

#### Core Documentation
- **`README.md`** - Main project documentation and workflow guide
- **`PROJECT-STRUCTURE.md`** - This file, detailed project structure documentation
- **`GLOSSARY.md`** - Definitions of key terms and concepts used throughout the project
- **`ECOSYSTEM.md`** - End-to-end view of GraphMD components and integrations
- **`MANIFESTO.md`** - Project manifesto and guiding principles

#### Workflow Documentation
- **`MVP-WORKFLOW.md`** - Detailed workflow phase guide with recommendations and focus areas
- **`MVP-DEVELOPMENT.md`** - MVP development guide with best practices and success metrics

#### Phase-Specific Guides
- **`RESEARCH-PHASE.md`** - Research phase detailed guide with prompts and best practices
- **`DESIGN-PHASE.md`** - Design phase detailed guide with architecture and decision documentation
- **`ROADMAP-PHASE.md`** - Roadmap phase detailed guide with milestones and prioritization
- **`PLANNING-PHASE.md`** - Planning phase detailed guide with validation state machine
- **`DEVELOPMENT-PHASE.md`** - Development phase detailed guide with context tracking approach

#### Templates and Contribution
- **`TEMPLATES.md`** - Template examples for tracking files (backlogs, changelogs, plan files)
- **`CONTRIBUTING.md`** - Contribution guidelines and development commands

#### Legal and Attribution
- **`AUTHORS`** - Project authors and contributors
- **`COPYRIGHT`** - Copyright information
- **`LICENSE`** - Project license (MIT-0 and CC0-1.0)
- **`LICENSES/`** - Directory containing full license texts

### Workflow Templates

Located in `templates/workflow/`:

- **Before/After pairs** for each phase:
  - Research: `before-research.md`, `after-research.md`
  - Design: `before-design.md`, `after-design.md`
  - Roadmap: `before-roadmap.md`, `after-roadmap.md`
  - Plan: `before-plan.md`, `after-plan.md`
  - Development: `before-development.md`, `after-development.md`

### Scripts

Located in `templates/scripts/`:

- **`validate-plan.sh`** - Validates plan files and sequence markers
- **`validate-dev.sh`** - Validates development progress tracking
- **`pre-commit`** - Git pre-commit hook for plan validation

Located in `templates/scripts/tests/`:

- **`run-all-tests.sh`** - Runs all test suites
- **`test-helpers.sh`** - Test framework utilities
- **`test-validate-plan.sh`** - Tests for validate-plan.sh
- **`test-validate-dev.sh`** - Tests for validate-dev.sh
- **`test-pre-commit.sh`** - Tests for pre-commit hook
- **`README.md`** - Test documentation

### Example Templates

Located in `templates/`:

- **`DEV-BACKLOG.md`** - Development backlog template
- **`DEV-CHANGELOG.md`** - Development changelog template
- **`PLAN-BACKLOG.md`** - Plan backlog template
- **`PLAN-CHANGELOG.md`** - Plan changelog template
- **`DEV-JOURNAL.md`** - Development journal template

### Emergency Scripts

Located in `scripts/emergency/`:

- **`restore-from-backup-mirror.sh`** - Emergency repository restore script
- **`RESTORE.md`** - Restore documentation

## Generated Files (Created During Workflow)

These files are created when following the GraphMD workflow and should be tracked in your project's git repository:

### Research Phase
- **`RESEARCH.md`** - Primary research findings document
- **`research/`** - Optional directory for detailed research artifacts

### Design Phase
- **`DESIGN.md`** - System architecture and technical design document
- **`design/`** - Optional directory for additional design files (ADRs, diagrams, etc.)

### Roadmap Phase
- **`ROADMAP.md`** - High-level project roadmap with phases and milestones

### Planning Phase
- **`PLAN-BACKLOG.md`** - Current and pending plan work
- **`PLAN-CHANGELOG.md`** - Historical record of validated plan steps
- **`plan/`** - Directory containing numbered plan files (e.g., `01-setup.md`, `02-configure.md`)

### Development Phase
- **`DEV-BACKLOG.md`** - Current and future development work
- **`DEV-CHANGELOG.md`** - Historical record of completed development steps
- **`DEV-JOURNAL.md`** - Session notes, decisions, and context
- **`development/`** - Directory containing all implementation files
- **`development/Dockerfile.dev`** - Development environment container
- **`PLAN-VS-IMPLEMENTATION.md`** - Retrospective comparing plan to actual implementation

## Usage Notes

### For Template Users

1. Clone the repository to get all templates and scripts
2. Follow the workflow by copying before/after phase documents
3. Generated files (research, plan, development, etc.) stay in your project

### For Contributors

If you modify template files in `templates/`:
1. Test scripts before committing with `make test`
2. Run linters with `make lint`
3. Update this file when adding new template files
4. Keep example files in sync with actual usage

## See Also

### Core Documentation
- [README.md](README.md) - Main project documentation
- [GLOSSARY.md](GLOSSARY.md) - Key terms and definitions
- [ECOSYSTEM.md](ECOSYSTEM.md) - Components and integrations

### Phase Guides
- [RESEARCH-PHASE.md](RESEARCH-PHASE.md) - Research phase guide
- [DESIGN-PHASE.md](DESIGN-PHASE.md) - Design phase guide
- [ROADMAP-PHASE.md](ROADMAP-PHASE.md) - Roadmap phase guide
- [PLANNING-PHASE.md](PLANNING-PHASE.md) - Planning phase guide
- [DEVELOPMENT-PHASE.md](DEVELOPMENT-PHASE.md) - Development phase guide

### Development
- [templates/scripts/tests/README.md](templates/scripts/tests/README.md) - Test documentation
- [CONTRIBUTING.md](CONTRIBUTING.md) - Contribution guidelines
