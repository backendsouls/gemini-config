# Base Sandbox for Gemini CLI
FROM ubuntu:22.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

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
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user for Homebrew
RUN useradd -m -s /bin/bash gemini && \
    echo "gemini ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER gemini
WORKDIR /home/gemini

# Install Homebrew
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add Homebrew to PATH
ENV PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:${PATH}"

# Install common tools via Homebrew
RUN brew install \
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
- **Core Tools**: jq, yq, htmlq, fzf, ripgrep (rg), fd, bat, tree, htop, vim, git, sed, wc, shellcheck, tldr, wget, curl, dig.\n\
- **Scripting**: Python 3.11 is available.\n\
\n\
## Language Specifics\n\
- This sandbox includes: Base Tools\n\
\n\
## Instructions\n\
1. Use '\''brew install <package>'\'' if you need more tools.\n\
2. Prefer Python 3.11 for automation scripts.\n' > /home/gemini/.gemini/GEMINI.md

RUN git config --global user.name "Gemini CLI" && \
    git config --global user.email "gemini@local.sandbox"

CMD ["/bin/bash"]
