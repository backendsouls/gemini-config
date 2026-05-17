#!/bin/bash
# setup.sh - JavaScript sandbox setup
source /usr/local/bin/common.sh

source "$NVM_DIR/nvm.sh"

log_info "Cleaning up NPM prefix conflict..."
npm config delete prefix

log_info "Installing Node.js 20 via NVM..."
retry nvm install 20
nvm use 20

log_info "Installing TypeScript utilities..."
retry npm install -g typescript ts-node
