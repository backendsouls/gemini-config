# Refactor All-in-One Sandbox Dockerfile Implementation Plan (REVISED)

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Refactor `sandboxes/all/Dockerfile` to use a lightweight, version-manager-based approach inheriting from the new base image, with optimized RUN layers and explicit PATH configuration.

**Architecture:** Hierarchical Docker structure inheriting from `gemini-sandbox-base`. Uses NVM and SDKMAN for Node and Java, and Homebrew for other language runtimes.

**Tech Stack:** Docker, Bash, NVM, SDKMAN, Homebrew.

---

### Task 1: Refactor Dockerfile

**Files:**
- Modify: `sandboxes/all/Dockerfile`
- Create: `sandboxes/all/Dockerfile.bak`

- [ ] **Step 1: Backup existing Dockerfile**

Run:
```bash
cp sandboxes/all/Dockerfile sandboxes/all/Dockerfile.bak
```

- [ ] **Step 2: Rewrite sandboxes/all/Dockerfile**

Update `sandboxes/all/Dockerfile` with the following content:

```dockerfile
ARG BASE_IMAGE=gemini-sandbox-base
FROM ${BASE_IMAGE}

# Install NVM & SDKMAN
ENV NVM_DIR="/home/gemini/.nvm" SDKMAN_DIR="/home/gemini/.sdkman"
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash && \
    curl -s "https://get.sdkman.io" | bash

# Install Runtimes (minimal) and update PATH
RUN bash -c "source $NVM_DIR/nvm.sh && nvm install 20 && nvm alias default 20" && \
    bash -c "source $SDKMAN_DIR/bin/sdkman-init.sh && sdk install java 17.0.10-tem"

# Other languages via Brew (API mode ensures this is relatively light)
RUN brew install go rust ruby php lua cmake gdb && brew cleanup

# Set PATH for NVM and SDKMAN binaries to be available in non-interactive shells
ENV PATH="${NVM_DIR}/versions/node/v20.11.1/bin:${SDKMAN_DIR}/candidates/java/current/bin:${PATH}"

CMD ["/bin/bash"]
```

- [ ] **Step 3: Update AI_LOG.md**

Log the refactoring of the all-in-one sandbox Dockerfile with revised optimizations.

- [ ] **Step 4: Commit changes (DO NOT PUSH)**

```bash
git add sandboxes/all/Dockerfile AI_LOG.md
git commit -m "feat: refactor all-in-one sandbox Dockerfile (revised)"
```
