# 📝 GraphMD Templates

This document describes templates for the GraphMD MVP workflow. These templates show the expected structure and format for backlogs, changelogs, and plan files.

## Workflow Prompt Templates

Located in `templates/workflow/`, these are self-contained prompts for guiding the Agent through each phase:

- **Before/After pairs**: Each phase has `before-<phase>.md` and `after-<phase>.md` templates
- **Safety mechanism**: All prompts end with **"Stand by for further instructions."** to prevent unintended actions
- **Copy/paste ready**: Designed to be copied into your Agent prompt as complete instructions

## Tracking Templates

Full template files are available in the `templates/` directory:

- `templates/PLAN-BACKLOG.md`
- `templates/PLAN-CHANGELOG.md`
- `templates/DEV-BACKLOG.md`
- `templates/DEV-CHANGELOG.md`
- `templates/DEV-JOURNAL.md`

## 🔗 Related Documentation

- [README.md](README.md) - Main project documentation
- [RESEARCH-PHASE.md](RESEARCH-PHASE.md) - Research phase detailed guide
- [DESIGN-PHASE.md](DESIGN-PHASE.md) - Design phase detailed guide
- [ROADMAP-PHASE.md](ROADMAP-PHASE.md) - Roadmap phase detailed guide
- [PLANNING-PHASE.md](PLANNING-PHASE.md) - Planning phase detailed guide
- [DEVELOPMENT-PHASE.md](DEVELOPMENT-PHASE.md) - Development phase detailed guide
- [PROJECT-STRUCTURE.md](PROJECT-STRUCTURE.md) - Project structure
