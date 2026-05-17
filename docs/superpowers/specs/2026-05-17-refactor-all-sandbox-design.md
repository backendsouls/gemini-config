# Design Doc: Refactor All-in-One Sandbox Dockerfile

**Status:** Draft
**Author:** BackendSouls
**Date:** 2026-05-17

## 1. Goal
Refactor `sandboxes/all/Dockerfile` to be more lightweight and maintainable by inheriting from the newly refactored `gemini-sandbox-base` and utilizing Homebrew, NVM, and SDKMAN for runtime installations.

## 2. Context
The current `sandboxes/all/Dockerfile` is large, contains redundant tool installations (many of which are now in the base image), and manually generates a `GEMINI.md` file that partially overlaps with the one in the base image. The new design simplifies the installation process and focuses on adding language runtimes to the established base.

## 3. Proposed Changes
- **Inheritance:** Inherit from `gemini-sandbox-base`.
- **Version Managers:** Install NVM for Node.js and SDKMAN for Java.
- **Language Runtimes:**
  - Node.js (via NVM)
  - Java (via SDKMAN)
  - Go, Rust, Ruby, PHP, Lua (via Homebrew)
- **Development Tools:** Install `cmake` and `gdb` via Homebrew.
- **Cleanup:** Utilize `brew cleanup` to keep the image size minimal.

### 3.1 Dockerfile Structure
```dockerfile
ARG BASE_IMAGE=gemini-sandbox-base
FROM ${BASE_IMAGE}

# Install NVM & SDKMAN
ENV NVM_DIR="/home/gemini/.nvm" SDKMAN_DIR="/home/gemini/.sdkman"
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
RUN curl -s "https://get.sdkman.io" | bash && \
    sed -i 's/sdkman_healthcheck_enable=true/sdkman_healthcheck_enable=false/' "$SDKMAN_DIR/etc/config"

# Install Runtimes (minimal)
RUN bash -c "source $NVM_DIR/nvm.sh && npm config delete prefix && nvm install 20"
RUN bash -c "source $SDKMAN_DIR/bin/sdkman-init.sh && sdk install java 17.0.10-tem"

# Other languages via Brew (API mode ensures this is relatively light)
RUN brew install go rust ruby php lua cmake gdb && brew cleanup

CMD ["/bin/bash"]
```

## 4. Trade-offs and Alternatives
- **Approach 1: Manual installation (Current):** Installing everything via `apt` or manual `curl | bash` for each tool. (Rejected: Hard to maintain, leads to large images).
- **Approach 2: Version managers (Recommended):** Using NVM and SDKMAN allows for flexible versioning, while Homebrew provides a consistent interface for other tools. (Selected: Modern, clean, and flexible).

## 5. Verification Plan
- **Build Check:** Run `make all-in-one` (if available) or `docker build -t gemini-sandbox-all sandboxes/all/`.
- **Runtime Check:** Verify `java`, `node`, `go`, `rustc`, `ruby`, `php`, `lua`, `cmake`, and `gdb` are available and functional in the built image.
- **Base Integrity:** Ensure the tools and extensions from the base image are still functional.
