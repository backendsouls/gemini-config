#!/bin/bash
# setup.sh - All-in-one sandbox setup
source /usr/local/bin/common.sh

# Load managers
source "$NVM_DIR/nvm.sh"
source "$SDKMAN_DIR/bin/sdkman-init.sh"

log_info "Cleaning up NPM prefix conflict..."
npm config delete prefix

log_info "Installing Node.js 20 via NVM..."
retry nvm install 20
nvm alias default 20
ln -sf "$(dirname "$(dirname "$(nvm which 20)")")" "$NVM_DIR/current"

log_info "Installing Java 17 via SDKMAN..."
retry sdk install java 17.0.10-tem

log_info "Installing Go (Native)..."
GO_VERSION="1.22.3"
ARCH=$(dpkg --print-architecture)
[ "$ARCH" = "amd64" ] && GO_ARCH="amd64" || GO_ARCH="arm64"
curl -L "https://golang.org/dl/go${GO_VERSION}.linux-${GO_ARCH}.tar.gz" | sudo tar -C /usr/local -xz

log_info "Installing Rust (Minimal)..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --profile minimal

log_info "Aggressively clearing runtime caches..."
nvm cache clear
sdk flush archives
sdk flush temp
npm cache clean --force
rm -rf /home/gemini/.sdkman/archives/*
rm -rf /home/gemini/.sdkman/tmp/*
