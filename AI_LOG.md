# AI Action & Decision Log

This log records significant actions, architectural decisions, and reasoning paths taken by the AI agent during the development and maintenance of this project.

---

## [2026-05-17] Major Size Optimization: The "Death of Brew"

### Actions:
- **Removed Homebrew Entirely**: Eliminated `/home/linuxbrew/.linuxbrew` from the base image, resulting in a ~4.6GB reduction in the final image size.
- **Native Package Management**: Transitioned to `apt-get` for all system-level tools (e.g., `ruby`, `php`, `lua`, `cmake`).
- **Official Binary Installers**:
    - **Go**: Switched to official tarball extraction in `/usr/local/go`.
    - **Rust**: Switched to `rustup` with `--profile minimal` to avoid documentation and heavy toolchain bloat.
    - **yq/htmlq**: Switched to direct GitHub release binary downloads (architecture-aware) instead of Brew bottles.
- **Selective Build Tools**:
    - Removed `build-essential` from the `base` and `all` images to save ~250MB.
    - Preserved `build-essential` specifically in the `cpp` sandbox as per user requirement.
- **Documentation Overhaul**: Updated all 11 sandbox `README.md` and `templates/GEMINI.md` files to remove Homebrew references and standardize on `apt`.

### Decisions:
- **Decision**: Eliminate Homebrew.
  - **Rationale**: Analysis showed Brew was responsible for ~50% of the image bloat. Using native `apt` packages and minimal binary installers provides the same functionality at a fraction of the size.
- **Decision**: Use `set -e` and `set -o pipefail` in all setup scripts (omitting `set -u`).
  - **Rationale**: Enforces strict error handling while maintaining compatibility with SDKMAN! and NVM internal scripts.
- **Decision**: Multi-stage binary downloads.
  - **Rationale**: Ensures we only keep the final binary in the image, avoiding temporary download artifacts.

---

## [2026-05-17] Image Size Optimization: Aggressive Cache Cleanup
... rest of file ...
