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
