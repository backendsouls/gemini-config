# Base Sandbox for Gemini CLI
FROM ubuntu:22.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Disable telemetry and analytical tracking for various tools
ENV HOMEBREW_NO_ANALYTICS=1 \
    GOTELEMETRY=off \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    GEMINI_TELEMETRY_ENABLED=false \
    HOME=/home/gemini \
    GEMINI_API_KEY=dummy

# Install essential dependencies for Homebrew and general use
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    sudo \
    procps \
    file \
    wget \
    dnsutils \
    zip \
    unzip \
    sed \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user for Homebrew
RUN useradd -m -s /bin/bash gemini && \
    echo "gemini ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER gemini
WORKDIR /home/gemini

# Install Homebrew
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add Homebrew and Python to PATH
ENV PATH="/home/linuxbrew/.linuxbrew/opt/python@3.11/bin:/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:${PATH}"

# Install common tools via Homebrew
RUN brew install \
    python@3.11 \
    node \
    jq \
    yq \
    htmlq \
    shellcheck \
    tldr \
    fzf \
    ripgrep \
    fd \
    bat \
    tree \
    vim \
    htop

RUN npm install -g @google/gemini-cli@latest pnpm

# Create a helper script for easy updates inside the sandbox
RUN echo '#!/bin/bash\nsudo npm install -g @google/gemini-cli@latest pnpm && sudo ln -sf /home/linuxbrew/.linuxbrew/bin/gemini /usr/bin/gemini' > /home/gemini/update-gemini.sh && \
    chmod +x /home/gemini/update-gemini.sh

# Symlink binaries to /usr/bin to ensure they are always in PATH
RUN sudo ln -s /home/linuxbrew/.linuxbrew/bin/node /usr/bin/node && \
    sudo ln -s /home/linuxbrew/.linuxbrew/bin/npm /usr/bin/npm && \
    sudo ln -s /home/linuxbrew/.linuxbrew/bin/npx /usr/bin/npx && \
    sudo ln -s /home/linuxbrew/.linuxbrew/bin/pnpm /usr/bin/pnpm && \
    sudo ln -s /home/linuxbrew/.linuxbrew/bin/gemini /usr/bin/gemini

# Pre-install Gemini extensions manually via git clone and install dependencies
RUN mkdir -p /home/gemini/.gemini/extensions && \
    git clone https://github.com/upstash/context7 /home/gemini/.gemini/extensions/context7 && \
    git clone https://github.com/obra/superpowers /home/gemini/.gemini/extensions/superpowers && \
    git clone https://github.com/gemini-cli-extensions/conductor /home/gemini/.gemini/extensions/conductor && \
    git clone https://github.com/qodo-ai/open-aware /home/gemini/.gemini/extensions/open-aware && \
    git clone https://github.com/gemini-cli-extensions/code-review /home/gemini/.gemini/extensions/code-review && \
    git clone https://github.com/gemini-cli-extensions/security /home/gemini/.gemini/extensions/gemini-cli-security && \
    git clone https://github.com/poemswe/co-researcher /home/gemini/.gemini/extensions/co-researcher && \
    mkdir -p /home/gemini/.npm && \
    export CI=true && \
    find /home/gemini/.gemini/extensions -maxdepth 3 -name package.json | while read pkg; do \
        dir=$(dirname "$pkg"); \
        echo "Processing dependencies for $dir..."; \
        cd "$dir" && \
        if [ -f "pnpm-lock.yaml" ] || grep -q "workspace:" package.json; then \
            pnpm install --no-frozen-lockfile && (pnpm run build || true) && pnpm prune --prod --config.confirmModulesPurge=false; \
        else \
            npm install --no-audit --no-fund && (npm run build || true) && npm prune --production; \
        fi && \
        cd - > /dev/null; \
    done

# Verify extensions are present and loadable
RUN gemini --debug --list-extensions

RUN tldr --update

# Create Gemini configuration directory and file
RUN mkdir -p /home/gemini/.gemini && \
    printf '# Gemini CLI Sandbox Environment\n\
You are running inside a specialized Gemini CLI sandbox.\n\
\n\
## Environment Capabilities\n\
- **OS**: Ubuntu 22.04\n\
- **User**: gemini (with passwordless sudo)\n\
- **Package Manager**: Homebrew (brew) is available and preferred.\n\
- **Extensions**: Pre-installed Gemini extensions include `context7`, `superpowers`, `conductor`, `open-aware`, `code-review`, `security`, and `co-researcher`.\n\
- **Core Tools**: Gemini CLI, jq, yq, htmlq, fzf, ripgrep (rg), fd, bat, tree, htop, vim, git, sed, wc, shellcheck, tldr, wget, curl, dig, zip, unzip.\n\
- **Scripting**: Python 3.11 is available.\n\
\n\
## Language Specifics\n\
- This sandbox includes: Gemini CLI, Base Tools\n\
\n\
## Security & Isolation\n\
- **Strict Boundaries**: You MUST NOT attempt to access or read any host directories directly using absolute paths.\n\
- **Shared Workspace**: You are strictly confined to the currently shared directory.\n\
- **Volume Guidance**: If you need more data, provide the user with an `export SANDBOX_MOUNTS` example. Do not ask for direct access.\n\
- **WORKSPACE Variable**: Respect the `WORKSPACE` environment variable if set by the user for shared project roots.\n\
\n\
## Instructions\n\
1. Use '\''gemini extensions list'\'' to see available extensions and their skills.\n\
2. Use '\''brew install <package>'\'' if you need more tools.\n\
3. Prefer Python 3.11 for automation scripts.\n' > /home/gemini/.gemini/GEMINI.md

RUN git config --global user.name "Gemini CLI" && \
    git config --global user.email "gemini@local.sandbox"

# Disable Gemini CLI usage statistics by default
RUN mkdir -p /home/gemini/.gemini && \
    echo '{"privacy": {"usageStatisticsEnabled": false}}' > /home/gemini/.gemini/settings.json

CMD ["/bin/bash"]
