# AI Action & Decision Log

This log records significant actions, architectural decisions, and reasoning paths taken by the AI agent during the development and maintenance of this project.

---

## [2026-05-17] Image Size Optimization: Aggressive Cache Cleanup

### Actions:
- **Extension Pruning**: Added a step to the `extension-builder` stage in `sandboxes/base/Dockerfile` to recursively remove all `.git` directories from cloned extensions, saving significant space.
- **NVM/SDKMAN Optimization**: Updated setup scripts for `all`, `javascript`, and `java` sandboxes to include `nvm cache clear` and `sdk flush archives && sdk flush temp`.
- **NPM Optimization**: Implemented `npm cache clean --force` after all global package installations and extension builds.
- **Homebrew Cleanup**: Added manual removal of `/home/gemini/.cache/Homebrew` in the base image to eliminate downloaded binaries after core tool installation.

### Decisions:
- **Decision**: Focus on aggressive cleanup over base migration for now.
  - **Rationale**: While Alpine Linux was considered, the user preferred to start with aggressive cleanup. This provides significant size savings (removing several hundred megabytes of git history and caches) without the compatibility risks of moving to `musl` libc.
- **Decision**: Clear Homebrew cache manually.
  - **Rationale**: `brew cleanup` removes old versions but often leaves the download cache intact. Manual removal ensures the final layer is as small as possible.

---

## [2026-05-17] Major Architectural Refactor: Modular Setup Scripts
... rest of file ...
