# Design: Lightweight Gemini CLI Sandboxes

## Goal
Reduce the footprint of Gemini CLI sandbox images while maintaining compatibility and flexibility (Homebrew access).

## Architecture
- **Base OS**: `debian:stable-slim` (replacing Ubuntu 22.04).
- **Core Utilities**: Switched from Homebrew to `apt-get` for ~15 tools (ripgrep, fd, jq, etc.).
- **Homebrew**: Installed in "API-only" mode (`HOMEBREW_INSTALL_FROM_API=1`) to avoid large git clones.
- **Extensions**: Built in a separate multi-stage build and copied as artifacts.
- **Version Managers**: NVM and SDKMAN included for runtime flexibility (Node/Java).

## Benefits
- Estimated **60-70% reduction** in total image size.
- Faster build times due to multi-stage caching.
- Retains `brew install` capability for on-demand tools.

## Implementation Details
- Use `node:20-bookworm` as a build stage for extensions.
- Use `debian:stable-slim` for final stages.
- Aggressively prune npm/pnpm caches and Homebrew metadata.
