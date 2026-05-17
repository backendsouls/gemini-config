# Refactor Base Sandbox Dockerfile Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Refactor `sandboxes/base/Dockerfile` to use a multi-stage build with Debian Slim, pre-installing extensions and core tools for a lightweight yet powerful sandbox environment.

**Architecture:** Multi-stage Docker build. Stage 1 (extension-builder) clones and builds Gemini extensions. Stage 2 (final image) uses `debian:stable-slim`, installs system dependencies, Homebrew, Gemini CLI, and copies built extensions.

**Tech Stack:** Docker, Debian, Node.js, Homebrew, Bash, Git.

---

### Task 1: Backup and Refactor Dockerfile

**Files:**
- Modify: `sandboxes/base/Dockerfile`
- Create: `sandboxes/base/Dockerfile.bak`

- [ ] **Step 1: Backup the existing Dockerfile**

Run: `cp sandboxes/base/Dockerfile sandboxes/base/Dockerfile.bak`

- [ ] **Step 2: Rewrite sandboxes/base/Dockerfile with the new multi-stage build**

```dockerfile
# Stage 1: Build Extensions
FROM node:20-bookworm AS extension-builder
RUN apt-get update && apt-get install -y git
WORKDIR /build
RUN git clone https://github.com/upstash/context7 /build/context7 && \
    git clone https://github.com/obra/superpowers /build/superpowers && \
    git clone https://github.com/gemini-cli-extensions/conductor /build/conductor && \
    git clone https://github.com/qodo-ai/open-aware /build/open-aware && \
    git clone https://github.com/gemini-cli-extensions/code-review /build/code-review && \
    git clone https://github.com/gemini-cli-extensions/security /build/gemini-cli-security && \
    git clone https://github.com/poemswe/co-researcher /build/co-researcher
RUN npm install -g pnpm
RUN find /build -maxdepth 2 -name package.json | while read pkg; do \
    dir=$(dirname "$pkg"); cd "$dir" && \
    if [ -f "pnpm-lock.yaml" ] || grep -q "workspace:" package.json; then \
        pnpm install --no-frozen-lockfile && (pnpm run build || true) && pnpm prune --prod --config.confirmModulesPurge=false; \
    else \
        npm install --no-audit --no-fund && (npm run build || true) && npm prune --production; \
    fi && \
    cd - > /dev/null; \
    done

# Stage 2: Final Image
FROM debian:stable-slim
ENV DEBIAN_FRONTEND=noninteractive \
    HOMEBREW_NO_ANALYTICS=1 \
    HOMEBREW_INSTALL_FROM_API=1 \
    PATH="/home/linuxbrew/.linuxbrew/bin:/home/gemini/.npm-global/bin:${PATH}"

RUN apt-get update && apt-get install -y \
    build-essential curl git sudo procps file wget dnsutils zip unzip sed \
    ripgrep fd-find jq bat fzf vim htop tree tldr shellcheck \
    python3.11 python3-pip nodejs npm \
    && rm -rf /var/lib/apt/lists/*

# Fix Debian binary naming for compatibility
RUN ln -s /usr/bin/batcat /usr/bin/bat && \
    ln -s /usr/bin/fdfind /usr/bin/fd

RUN useradd -m -s /bin/bash gemini && echo "gemini ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER gemini
WORKDIR /home/gemini

# Install Homebrew (Minimal)
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" \
    && brew cleanup

# Install Gemini CLI & pnpm
RUN mkdir -p /home/gemini/.npm-global && \
    npm config set prefix '/home/gemini/.npm-global' && \
    npm install -g @google/gemini-cli@latest pnpm

# Install yq and htmlq via Brew (to ensure we have latest versions)
RUN brew install yq htmlq && brew cleanup

COPY --from=extension-builder /build /home/gemini/.gemini/extensions

# Restore Gemini configuration
RUN mkdir -p /home/gemini/.gemini && \
    printf '# Gemini CLI Sandbox Environment\n\
You are running inside a specialized Gemini CLI sandbox.\n\
\n\
## Environment Capabilities\n\
- **OS**: Debian (Stable Slim)\n\
- **User**: gemini (with passwordless sudo)\n\
- **Package Manager**: Homebrew (brew) is available and preferred.\n\
- **Extensions**: Pre-installed Gemini extensions include `context7`, `superpowers`, `conductor`, `open-aware`, `code-review`, `security`, and `co-researcher`.\n\
- **Core Tools**: Gemini CLI, jq, yq, htmlq, fzf, ripgrep (rg), fd, bat, tree, htop, vim, git, sed, wc, shellcheck, tldr, wget, curl, dig, zip, unzip.\n\
- **Scripting**: Python 3.11 is available.\n\
\n\
## Instructions\n\
1. Use '\''gemini extensions list'\'' to see available extensions and their skills.\n\
2. Use '\''brew install <package>'\'' if you need more tools.\n\
3. Prefer Python 3.11 for automation scripts.\n' > /home/gemini/.gemini/GEMINI.md

RUN git config --global user.name "Gemini CLI" && \
    git config --global user.email "gemini@local.sandbox" && \
    echo '{"privacy": {"usageStatisticsEnabled": false}}' > /home/gemini/.gemini/settings.json

CMD ["/bin/bash"]
```

- [ ] **Step 3: Verify Dockerfile syntax**

Run: `docker build --dry-run sandboxes/base`
Expected: Success or validation of syntax (if `--dry-run` is supported by the environment's docker version).
Alternative: `docker buildx build --dry-run sandboxes/base` or `hadolint sandboxes/base/Dockerfile`.
Given the user instruction, I will use `docker build --dry-run sandboxes/base`.
