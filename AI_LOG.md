# AI Action & Decision Log

This log records significant actions, architectural decisions, and reasoning paths taken by the AI agent during the development and maintenance of this project.

---

## [2026-05-17] Major Architectural Refactor: Modular Setup Scripts

### Actions:
- **Modular Build System**: Transitioned from inline Dockerfile logic to a modular script-based system.
- **Shared Utilities**: Created `/usr/local/bin/common.sh` in the base image, containing robust `retry()` logic with backoff and standardized logging helpers (`log_info`, `log_error`).
- **Standardized Setups**: Moved language-specific runtime installations into standalone `scripts/setup.sh` files for every sandbox (`all`, `javascript`, `java`).
- **Template-based Documentation**: Extracted large `printf` blocks from Dockerfiles into standalone `templates/GEMINI.md` files, which are now copied into the containers.
- **Fixed Permission Issues**: Moved the installation of system utilities (like `retry.sh`) before the `USER gemini` instruction in `sandboxes/base/Dockerfile` to ensure root permissions for setup.
- **Shell Function Compatibility**: Converted the `retry` utility from a binary script to a sourceable bash function library to support shell-native commands like `nvm` and `sdk`.

### Decisions:
- **Decision**: Adopt the "Modular Pattern" via Tree of Thoughts (ToT).
  - **Rationale**: Standardizing `scripts/` and `templates/` across all sandboxes results in minimal, declarative Dockerfiles that are easier to audit and maintain.
- **Decision**: Use `set -e` and `set -o pipefail` in all setup scripts (omitting `set -u`).
  - **Rationale**: Enforces strict error handling and pipe safety. `set -u` (nounset) was explicitly removed as it causes deep failures within third-party shell managers like SDKMAN! and NVM which rely on optional unbound variables.
- **Decision**: Source `common.sh` instead of executing a binary.
  - **Rationale**: Tool managers like NVM and SDKMAN! are implemented as shell functions, not binaries. Sourcing the retry logic into the same shell context is required for it to correctly recognize and execute these functions.

### Reasoning Paths (ToT):
- **Path A: Monolithic Setup Script**: (Rejected: Too complex, violates modularity).
- **Path B: Modular Pattern (Selected)**: standardizes assets across sandboxes, minimal Dockerfiles.
- **Path C: Pure Dockerfile (Zero-Script)**: (Rejected: Hard to maintain, poor readability).

### Final Status:
- **STABLE & MODULAR** (All 11 sandboxes now use a consistent, script-driven build architecture).

---

## [2026-05-15] Initial Setup and Configuration
... rest of file ...
