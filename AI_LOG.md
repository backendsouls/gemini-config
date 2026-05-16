# AI Action & Decision Log

This log records significant actions, architectural decisions, and reasoning paths taken by the AI agent during the development and maintenance of this project.

---

## [2026-05-15] Initial Setup and Configuration

### Actions:
- Standardized Python 3.11 availability across all sandboxes by moving installation to `sandboxes/base/Dockerfile`.
- Expanded `sandboxes/all/Dockerfile` to include Java (SDKMAN), JavaScript (NVM), Go, Rust, Ruby, PHP, Lua, and C++.
- Explicitly added `sed` to the base image.
- Disabled telemetry for Homebrew, Go, Python (Pip), and Gemini CLI.
- Pre-installed `context7`, `superpowers`, `conductor`, `open-aware`, `code-review`, `security`, and `co-researcher` Gemini extensions in the base sandbox.
- Fixed extension installation by using correct directory names (e.g., `gemini-cli-security`), manual `git clone`, and running `npm install --production` to ensure dependencies are present for loading.
- Applied architectural fixes from the Extension Discovery Report:
    - Explicitly set `HOME=/home/gemini` to prevent discovery issues when running as different host users.
    - Set a default `GEMINI_API_KEY=dummy` to ensure immediate functionality and bypass build-time auth checks.
- Created `EXTENSIONS.md` to document the pre-installed Gemini extensions and linked it from the README.

### Decisions:
- **Decision**: Move Python to base image.
  - **Rationale**: User requirement for Python presence in every sandbox; moving to base ensures inheritance and reduces redundancy.
- **Decision**: Adopt "Tree of Thoughts" (ToT) as the primary reasoning framework.
  - **Rationale**: User directive to improve cognitive depth and evaluation of reasoning paths.
- **Decision**: Implement `AI_LOG.md`.
  - **Rationale**: User directive to maintain a transparent record of agent activity.
- **Decision**: Pre-install `context7`, `superpowers`, `conductor`, `open-aware`, `code-review`, `security`, and `co-researcher` extensions.
  - **Rationale**: User request to include specific Gemini extensions in the sandbox environment to enhance capabilities, orchestration, code awareness, review, security, and research workflows.
- **Decision**: Use manual `git clone` and `npm install` for extensions in Dockerfile.
  - **Rationale**: The CLI installer (`gemini extensions install`) was unreliable in the Docker build process. Manual cloning followed by `npm install` ensures all required Node.js dependencies are present for the CLI to successfully load the extensions.
- **Decision**: Explicitly set `HOME` and pre-configure API keys.
  - **Rationale**: Addresses the discovery issue where the CLI might look for extensions in the wrong home directory depending on how the sandbox is launched.

### Reasoning Paths (ToT):
- **Path A**: Keep individual language installations separate. (Rejected: High maintenance, inconsistent Python availability).
- **Path B**: Move common dependencies (Python, core tools) to base. (Selected: Cleanest architecture, satisfies all user constraints).
