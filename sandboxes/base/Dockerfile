# Stage 1: Build Extensions
FROM node:24-bookworm AS extension-builder
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
FROM python:3.13-slim

# Build-time metadata
LABEL maintainer="Gemini CLI Team"
LABEL description="Opinionated unofficial base sandbox image for Gemini CLI"

# Environment configuration
ENV DEBIAN_FRONTEND=noninteractive \
    HOME=/home/gemini \
    PATH="/home/gemini/.npm-global/bin:${PATH}"

# Install core system dependencies (minimal)
# Note: build-essential is NOT installed here to save space
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl git sudo procps file wget dnsutils zip unzip sed \
    ripgrep fd-find jq bat fzf vim htop tree shellcheck \
    nodejs npm \
    && rm -rf /var/lib/apt/lists/*

# Binary compatibility links
RUN ln -s /usr/bin/batcat /usr/bin/bat && \
    ln -s /usr/bin/fdfind /usr/bin/fd && \
    ln -s /usr/bin/python3 /usr/bin/python

# Install yq and htmlq via direct binary download (Architecture-aware)
RUN ARCH=$(dpkg --print-architecture) && \
    if [ "$ARCH" = "amd64" ]; then YQ_ARCH="linux_amd64"; HTMLQ_ARCH="x86_64-linux"; \
    elif [ "$ARCH" = "arm64" ]; then YQ_ARCH="linux_arm64"; HTMLQ_ARCH="arm64-linux"; \
    else echo "Unsupported architecture: $ARCH" && exit 1; fi && \
    curl -L "https://github.com/mikefarah/yq/releases/latest/download/yq_${YQ_ARCH}" -o /usr/local/bin/yq && \
    chmod +x /usr/local/bin/yq && \
    HTMLQ_VERSION=$(curl -s "https://api.github.com/repos/mgdm/htmlq/releases/latest" | jq -r .tag_name) && \
    curl -L "https://github.com/mgdm/htmlq/releases/download/${HTMLQ_VERSION}/htmlq-${HTMLQ_ARCH}.tar.gz" | tar xz -C /usr/local/bin && \
    chmod +x /usr/local/bin/htmlq

# User and shared utilities setup
RUN useradd -m -s /bin/bash gemini && \
    echo "gemini ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
COPY scripts/common.sh /usr/local/bin/common.sh
COPY scripts/retry.sh /usr/local/bin/retry.sh

USER gemini
WORKDIR /home/gemini

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
