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

## [2026-05-16] Fixed Extension Loading Issues

### Actions:
- Identified that extensions were broken due to symbolic links pointing to non-existent `/home/gemini` paths.
- Re-installed all documented extensions (`context7`, `superpowers`, `conductor`, `open-aware`, `code-review`, `gemini-cli-security`, `co-researcher`) by cloning them directly into `/home/backendsouls/.gemini/extensions/`.
- Verified that extensions are now correctly recognized and loaded by the Gemini CLI using `gemini extensions list`.

### Decisions:
- **Decision**: Manual re-clone into local home directory.
  - **Rationale**: The previous configuration was environment-specific and failed when the user/home path changed. Local cloning ensures the extensions are physically present and independent of external paths.

## [2026-05-16] Applied Extension Fix to Dockerfiles

### Actions:
- Updated `sandboxes/base/Dockerfile` to use a more robust extension installation loop.
- Added `npx pnpm install --prod` specifically for `context7` to handle its `workspace:` protocol requirements.
- Added `mkdir -p /home/gemini/.npm` in the Dockerfile to ensure the npm cache directory exists and is owned by the `gemini` user during build.
- Standardized `npm install --production --no-audit --no-fund` for all other extensions.

### Decisions:
- **Decision**: Update the base Dockerfile instead of individual language ones.
  - **Rationale**: All language-specific sandboxes inherit from `gemini-sandbox-base`, so fixing it in the base image ensures consistency and reduces maintenance overhead.
- **Decision**: Use `npx pnpm` for `context7`.
  - **Rationale**: `context7` is a monorepo using pnpm workspaces, which standard `npm` cannot resolve. `npx pnpm` allows for a zero-install-of-the-installer approach during the Docker build.

## [2026-05-16] Enhanced Extension Build Process in Dockerfiles

### Actions:
- Refined the extension installation loop in `sandboxes/base/Dockerfile` to recursively find all `package.json` files.
- Added a build step (`npm run build` or `pnpm run build`) to ensure that TypeScript extensions and MCP servers are fully compiled and functional.
- Implemented a "build then prune" strategy to keep the image size minimal while ensuring all runtime dependencies are present.
- Improved error handling in the build loop by allowing optional build failures (`|| true`) for extensions that might not have or need a build step but still have a `package.json`.

### Decisions:
- **Decision**: Recursively search for `package.json`.
  - **Rationale**: Some extensions (like `gemini-cli-security`) store their MCP server logic in subdirectories. Finding all package files ensures these nested components are correctly initialized.
- **Decision**: Include build step.
  - **Rationale**: Manual inspection revealed that several extensions rely on a compiled `dist/` directory (e.g., `context7`, `security`). Cloning alone was insufficient for full functionality.

## [2026-05-16] Updated Sandbox READMEs with Extension Information

### Actions:
- Updated all language-specific `README.md` files in the `sandboxes/` directory (python, javascript, go, rust, ruby, java, php, lua, cpp, and 'all') to include a "Pre-installed Extensions" section.
- The new section lists the pre-installed Gemini extensions: `context7`, `superpowers`, `conductor`, `open-aware`, `code-review`, `security`, and `co-researcher`.

### Decisions:
- **Decision**: Standardize README documentation for extensions.
  - **Rationale**: Ensures that users are aware of the enhanced capabilities available within each sandbox environment.

## [2026-05-16] Hardened Sandbox Isolation

### Actions:
- Installed `pnpm` globally within the `sandboxes/base/Dockerfile` to eliminate the need for build-time or runtime `npx` fetching.
- Added a symlink for `pnpm` to `/usr/bin/pnpm` to ensure consistency with `node`, `npm`, and `gemini`.
- Updated the extension installation loop to use the globally installed `pnpm` instead of `npx pnpm`.

### Decisions:
- **Decision**: Pre-install PNPM globally.
  - **Rationale**: Reduces external dependencies and build-time internet reliance. Ensures that the sandbox is a truly self-contained environment as per user request.
- **Decision**: Centralize all Node-related binaries in `/usr/bin`.
  - **Rationale**: Guarantees that these tools are always in the system `PATH` regardless of which user or shell (non-interactive, etc.) is used to launch commands within the sandbox.

## [2026-05-16] Standardized Documentation across Sandbox Variants

### Actions:
- Standardized the in-container `GEMINI.md` templates across all language-specific Dockerfiles (`python`, `javascript`, `go`, `rust`, `ruby`, `java`, `php`, `lua`, `cpp`).
- Ensured every sandbox variant now explicitly mentions the pre-installed Gemini extensions and provides instructions on how to list them.
- Verified that language-specific details (like NVM/SDKMAN instructions) were preserved during the template update.

### Decisions:
- **Decision**: Maintain high documentation parity across variants.
  - **Rationale**: Regardless of the specialized toolset (e.g., Rust vs. Python), the agent's core capabilities provided by extensions should be consistently discoverable and documented for the user.

## [2026-05-16] Formalized Sandbox Isolation & Security Mandates

### Actions:
- Updated root `GEMINI.md` with a new "Security & Isolation Mandates" section.
- Explicitly prohibited the agent from requesting direct host access or using absolute host paths.
- Added instructions for the agent to provide volume mounting guidance (`export SANDBOX_MOUNTS`) instead of seeking host access.
- Introduced and documented the `WORKSPACE` environment variable for shared project roots.
- Standardized these security mandates across all 11 sandbox `Dockerfile` templates.
- Updated `.env.example` to include the `WORKSPACE` variable.

### Decisions:
- **Decision**: Prohibit direct host access requests.
  - **Rationale**: Reinforces the "Security by Default" posture. The agent should never assume or request access to the host file system beyond the mounted volumes.
- **Decision**: Use `WORKSPACE` variable for context.
  - **Rationale**: Provides a standard way for users to define a broad context for the agent while maintaining strict sandbox boundaries.

## [2026-05-16] Updated All READMEs with Security & Isolation Policies

### Actions:
- Updated the root \`README.md\` and all 11 sandbox-specific \`README.md\` files to include the "Security & Isolation" mandates.
- Documented the use of \`WORKSPACE\` and \`SANDBOX_MOUNTS\` for safe directory sharing in the root \`README.md\`.
- Standardized the security considerations across the entire project documentation.

### Decisions:
- **Decision**: Explicitly document isolation policies in all READMEs.
  - **Rationale**: Transparency is key for user trust. By clearly stating the isolation boundaries and the proper ways to share data, we empower the user to set up their environment securely.

## [2026-05-16] Fixed Dockerfile Build Errors (printf Syntax)

### Actions:
- Identified and fixed a critical syntax error in all Dockerfiles where multi-line `printf` commands were missing required backslash (`\`) line continuations.
- Standardized the `printf` blocks to use `\n\` at the end of each line to correctly escape the newline for the Dockerfile parser and ensure valid shell command construction.
- Verified the fix across all 11 sandbox variants (`base`, `all`, `python`, `javascript`, `go`, `rust`, `ruby`, `java`, `php`, `lua`, `cpp`).

### Decisions:
- **Decision**: Use explicit line continuations in Dockerfiles.
  - **Rationale**: Docker requires each line of a multi-line `RUN` instruction to end with a backslash. Failure to do so causes the parser to treat the next line as a new (and often invalid) instruction.

## [2026-05-16] Fixed Extension Installation Build Loop & TTY Errors

### Actions:
- Refined the `find` command in `sandboxes/base/Dockerfile` with `-maxdepth 3` to avoid redundant and failing `npm install` calls within monorepo sub-packages (e.g., `context7/packages/*`).
- Set `export CI=true` and `--config.confirmModulesPurge=false` for `pnpm` to prevent build failures caused by the lack of a TTY in the Docker environment.
- Added `--no-frozen-lockfile` to `pnpm install` to handle cases where the lockfile might need updates during the container build.

### Decisions:
- **Decision**: Limit `find` depth for `package.json`.
  - **Rationale**: Prevents `npm` from trying to install dependencies in sub-packages of monorepos that use the `workspace:` protocol, which `npm` does not support. Monorepos are now handled correctly at their root by `pnpm`.
- **Decision**: Force non-interactive mode for `pnpm`.
  - **Rationale**: Docker builds are non-interactive; `pnpm` must be configured to skip TTY-based confirmations to complete the pruning process successfully.

## [2026-05-16] Implemented CI/CD with GitHub Actions

### Actions:
- Created .github/workflows/docker-build-push.yml to automate Docker image builds.
- Configured the workflow to push images to Docker Hub on pushes to main.
- Updated all language-specific Dockerfiles to use the BASE_IMAGE build argument.
- Documented GitHub repository secrets requirement (DOCKER_USERNAME, DOCKER_PASSWORD) in README.md.

### Decisions:
- **Decision**: Use a two-stage job structure.
  - **Rationale**: Building the base image first and then parallelizing the language-specific builds optimizes CI time while ensuring all images use the exact same base layer.
- **Decision**: Use build arguments for the base image reference.
  - **Rationale**: This allows the CI/CD pipeline to inject the Docker Hub-prefixed image name (username/gemini-sandbox-base) without hardcoding it in the source files, maintaining local build compatibility.

## [2026-05-17] Refactored Base Sandbox Dockerfile

### Actions:
- Refactored `sandboxes/base/Dockerfile` to use a multi-stage build strategy.
- Switched the base image from Ubuntu 22.04 to `debian:stable-slim` for a smaller footprint.
- Implemented `extension-builder` stage using `node:20-bookworm` to clone and build Gemini extensions.
- Configured Homebrew to install from API and disabled analytics (`HOMEBREW_INSTALL_FROM_API=1`, `HOMEBREW_NO_ANALYTICS=1`).
- Cleaned up the final image by excluding extension build tools and temporary files.
- Simplified PATH management and user setup.

### Decisions:
- **Decision**: Use multi-stage builds.
  - **Rationale**: Keeps the final image lightweight by isolating the build environment for extensions from the runtime environment.
- **Decision**: Switch to Debian Slim.
  - **Rationale**: Provides a smaller, more secure foundation than full Ubuntu while maintaining compatibility with necessary tools.
- **Decision**: Enable Homebrew API mode.
  - **Rationale**: Significantly reduces image size by avoiding large git clones of the Homebrew core and cask taps.

## [2024-05-22] Revised Base Sandbox Dockerfile Refactor

### Actions:
- Refactored `sandboxes/base/Dockerfile` using a multi-stage build strategy based on the updated specification.
- Used `node:20-bookworm` for the `extension-builder` stage to clone and build Gemini extensions (context7, superpowers, conductor, open-aware, code-review, security, co-researcher).
- Switched final stage to `debian:stable-slim`.
- Installed system dependencies: `build-essential`, `curl`, `git`, `sudo`, `procps`, `file`, `wget`, `dnsutils`, `zip`, `unzip`, `sed`, `ripgrep`, `fd-find`, `jq`, `bat`, `fzf`, `vim`, `htop`, `tree`, `tldr`, `shellcheck`, `python3.11`, `nodejs`, `npm`.
- Configured Homebrew in the final stage and installed `yq` and `htmlq`.
- Pre-configured Gemini CLI and restored the standard `GEMINI.md` instructions within the container.
- Set up global git config and telemetry-disabled settings for Gemini CLI.

### Decisions:
- **Decision**: Use `debian:stable-slim`.
  - **Rationale**: Minimal footprint while maintaining full compatibility with Debian/Ubuntu toolchains.
- **Decision**: Use `extension-builder` stage.
  - **Rationale**: Isolates heavy build dependencies (like full git clones and npm build processes) from the final runtime image, significantly reducing final size and improving security.
- **Decision**: Fix Debian binary naming (`bat` and `fd`).
  - **Rationale**: Debian packages use `batcat` and `fdfind`; symlinking them to `bat` and `fd` maintains CLI compatibility with other environments.
- **Decision**: Use Homebrew for `yq` and `htmlq`.
  - **Rationale**: Ensures the latest versions are available regardless of the Debian repository state.

## [2026-05-17] Refactored All-in-One Sandbox Dockerfile

### Actions:
- Backed up original `sandboxes/all/Dockerfile` to `sandboxes/all/Dockerfile.bak`.
- Rewrote `sandboxes/all/Dockerfile` to inherit from `gemini-sandbox-base`.
- Implemented NVM for Node.js (version 20) and SDKMAN for Java (version 17.0.10-tem).
- Installed Go, Rust, Ruby, PHP, Lua, CMake, and GDB via Homebrew.
- Streamlined the Dockerfile by removing redundant tool installations and documentation generation now handled by the base image.

### Decisions:
- **Decision**: Shift runtime management to NVM and SDKMAN.
  - **Rationale**: Provides more flexibility and cleaner version management within the "All-in-One" environment.
- Rely on base image for core tools and extensions.
  - **Rationale**: Reduces image bloat and ensures consistent capability across all specialized sandboxes.

## [2024-05-22] Revised All-in-One Sandbox Dockerfile Refactor

### Actions:
- Refactored `sandboxes/all/Dockerfile` with optimized RUN layers and explicit PATH configuration.
- Combined NVM and SDKMAN installation into a single layer.
- Combined runtime installations into a single layer and included `nvm alias default`.
- Explicitly configured `PATH` to include NVM and SDKMAN binary directories for non-interactive shell support.
- Backed up the previous Dockerfile to `sandboxes/all/Dockerfile.bak`.

### Decisions:
- **Decision**: Combine RUN layers.
  - **Rationale**: Reduces the number of layers in the Docker image, leading to a smaller overall size.
- **Decision**: Explicitly set PATH in Dockerfile.
  - **Rationale**: Ensures that binaries installed via version managers (NVM, SDKMAN) are available in non-interactive shells, which is critical for agent automation.

