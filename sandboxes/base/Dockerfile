# Stage 1: Build Extensions
FROM node:20-bookworm AS extension-builder
RUN apt-get update && apt-get install -y git
WORKDIR /build

# Clone extensions
RUN git clone --depth 1 https://github.com/upstash/context7 /build/context7 && \
    git clone --depth 1 https://github.com/obra/superpowers /build/superpowers && \
    git clone --depth 1 https://github.com/gemini-cli-extensions/conductor /build/conductor && \
    git clone --depth 1 https://github.com/qodo-ai/open-aware /build/open-aware && \
    git clone --depth 1 https://github.com/gemini-cli-extensions/code-review /build/code-review && \
    git clone --depth 1 https://github.com/gemini-cli-extensions/security /build/gemini-cli-security && \
    git clone --depth 1 https://github.com/poemswe/co-researcher /build/co-researcher

# Build extensions
RUN npm install -g pnpm && \
    find /build -maxdepth 2 -name package.json | while read pkg; do \
    dir=$(dirname "$pkg"); cd "$dir" && \
    if [ -f "pnpm-lock.yaml" ] || grep -q "workspace:" package.json; then \
        pnpm install --no-frozen-lockfile && (pnpm run build || true) && pnpm prune --prod --config.confirmModulesPurge=false; \
    else \
        npm install --no-audit --no-fund && (npm run build || true) && npm prune --production; \
    fi && \
    cd - > /dev/null; \
    done && \
    find /build -name ".git" -type d -exec rm -rf {} + && \
    npm cache clean --force

# Stage 2: Final Image
FROM debian:stable-slim

# Build-time metadata
LABEL maintainer="Gemini CLI Team"
LABEL description="Base sandbox image for Gemini CLI"

# Environment configuration
ENV DEBIAN_FRONTEND=noninteractive \
    HOMEBREW_NO_ANALYTICS=1 \
    HOMEBREW_INSTALL_FROM_API=1 \
    HOME=/home/gemini \
    PATH="/home/linuxbrew/.linuxbrew/bin:/home/gemini/.npm-global/bin:${PATH}"

# Install core system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential curl git sudo procps file wget dnsutils zip unzip sed \
    ripgrep fd-find jq bat fzf vim htop tree shellcheck \
    python3 python3-pip nodejs npm \
    && rm -rf /var/lib/apt/lists/*

# Binary compatibility links
RUN ln -s /usr/bin/batcat /usr/bin/bat && \
    ln -s /usr/bin/fdfind /usr/bin/fd && \
    ln -s /usr/bin/python3 /usr/bin/python

# User and shared utilities setup
RUN useradd -m -s /bin/bash gemini && \
    echo "gemini ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
COPY scripts/common.sh /usr/local/bin/common.sh

USER gemini
WORKDIR /home/gemini

# Install Homebrew
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && \
    brew install yq htmlq && \
    brew cleanup && \
    rm -rf /home/gemini/.cache/Homebrew

# Install Gemini CLI and package managers
RUN mkdir -p /home/gemini/.npm-global && \
    npm config set prefix '/home/gemini/.npm-global' && \
    npm install -g @google/gemini-cli@latest pnpm tldr && \
    npm cache clean --force

# Install Extensions
COPY --chown=gemini:gemini --from=extension-builder /build /home/gemini/.gemini/extensions

# Configuration templates
COPY --chown=gemini:gemini templates/GEMINI.md /home/gemini/.gemini/GEMINI.md
RUN mkdir -p /home/gemini/.gemini && \
    git config --global user.name "Gemini CLI" && \
    git config --global user.email "gemini@local.sandbox" && \
    echo '{"privacy": {"usageStatisticsEnabled": false}}' > /home/gemini/.gemini/settings.json

CMD ["/bin/bash"]
