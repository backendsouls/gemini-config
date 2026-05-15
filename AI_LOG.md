# AI Action & Decision Log

This log records significant actions, architectural decisions, and reasoning paths taken by the AI agent during the development and maintenance of this project.

---

## [2026-05-15] Initial Setup and Configuration

### Actions:
- Standardized Python 3.11 availability across all sandboxes by moving installation to `sandboxes/base/Dockerfile`.
- Expanded `sandboxes/all/Dockerfile` to include Java (SDKMAN), JavaScript (NVM), Go, Rust, Ruby, PHP, Lua, and C++.
- Explicitly added `sed` to the base image.
- Disabled telemetry for Homebrew, Go, Python (Pip), and Gemini CLI.
- Pre-installed `context7`, `superpowers`, `conductor`, `open-aware`, `code-review`, and `security` Gemini extensions in the base sandbox.
- Created `EXTENSIONS.md` to document the pre-installed Gemini extensions and linked it from the README.

### Decisions:
- **Decision**: Move Python to base image.
  - **Rationale**: User requirement for Python presence in every sandbox; moving to base ensures inheritance and reduces redundancy.
- **Decision**: Adopt "Tree of Thoughts" (ToT) as the primary reasoning framework.
  - **Rationale**: User directive to improve cognitive depth and evaluation of reasoning paths.
- **Decision**: Implement `AI_LOG.md`.
  - **Rationale**: User directive to maintain a transparent record of agent activity.
- **Decision**: Pre-install `context7`, `superpowers`, `conductor`, `open-aware`, `code-review`, and `security` extensions.
  - **Rationale**: User request to include specific Gemini extensions in the sandbox environment to enhance capabilities, orchestration, code awareness, review, and security workflows.
- **Decision**: Create `EXTENSIONS.md`.
  - **Rationale**: Documentation requirement to clarify which extensions are available and what they do.

### Reasoning Paths (ToT):
- **Path A**: Keep individual language installations separate. (Rejected: High maintenance, inconsistent Python availability).
- **Path B**: Move common dependencies (Python, core tools) to base. (Selected: Cleanest architecture, satisfies all user constraints).
