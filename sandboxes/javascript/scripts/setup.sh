#!/bin/bash
# setup.sh - JavaScript sandbox setup
source /usr/local/bin/common.sh

source "$NVM_DIR/nvm.sh"

log_info "Cleaning up NPM prefix conflict..."
npm config delete prefix

log_info "Installing Node.js 24 via NVM..."
retry nvm install 24
nvm use 24

log_info "Installing TypeScript utilities..."
retry npm install -g typescript ts-node

log_info "Clearing NPM and NVM caches..."
npm cache clean --force
nvm cache clear
