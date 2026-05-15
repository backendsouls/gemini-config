# Base Sandbox for Gemini CLI
FROM ubuntu:22.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Disable telemetry and analytical tracking for various tools
ENV HOMEBREW_NO_ANALYTICS=1 \
    GOTELEMETRY=off \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    GEMINI_TELEMETRY_ENABLED=false

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

# Add Homebrew to PATH
ENV PATH="/home/linuxbrew/.linuxbrew/opt/python@3.11/bin:/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:${PATH}"

RUN npm install -g @google/gemini-cli@latest

# Create a helper script for easy updates inside the sandbox
RUN echo '#!/bin/bash\nsudo npm install -g @google/gemini-cli@latest && sudo ln -sf /home/linuxbrew/.linuxbrew/bin/gemini /usr/bin/gemini' > /home/gemini/update-gemini.sh && \
    chmod +x /home/gemini/update-gemini.sh

# Symlink binaries to /usr/bin to ensure they are always in PATH
RUN sudo ln -s /home/linuxbrew/.linuxbrew/bin/node /usr/bin/node && \
    sudo ln -s /home/linuxbrew/.linuxbrew/bin/npm /usr/bin/npm && \
    sudo ln -s /home/linuxbrew/.linuxbrew/bin/gemini /usr/bin/gemini

# Pre-install Gemini extensions
RUN gemini extensions install https://github.com/upstash/context7 && \
    gemini extensions install https://github.com/obra/superpowers && \
    gemini extensions install https://github.com/gemini-cli-extensions/conductor && \
    gemini extensions install https://github.com/qodo-ai/open-aware && \
    gemini extensions install https://github.com/gemini-cli-extensions/code-review && \
    gemini extensions install https://github.com/gemini-cli-extensions/security

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
- **Core Tools**: Gemini CLI, jq, yq, htmlq, fzf, ripgrep (rg), fd, bat, tree, htop, vim, git, sed, wc, shellcheck, tldr, wget, curl, dig, zip, unzip.\n\
- **Scripting**: Python 3.11 is available.\n\
\n\
## Language Specifics\n\
- This sandbox includes: Gemini CLI, Base Tools\n\
\n\
## Instructions\n\
1. Use '\''brew install <package>'\'' if you need more tools.\n\
2. Prefer Python 3.11 for automation scripts.\n' > /home/gemini/.gemini/GEMINI.md

RUN git config --global user.name "Gemini CLI" && \
    git config --global user.email "gemini@local.sandbox"

# Disable Gemini CLI usage statistics by default
RUN mkdir -p /home/gemini/.gemini && \
    echo '{"privacy": {"usageStatisticsEnabled": false}}' > /home/gemini/.gemini/settings.json

CMD ["/bin/bash"]
