#!/bin/bash
# common.sh - Shared utilities for Gemini Sandbox builds
# Use: source /usr/local/bin/common.sh

set -e
set -o pipefail

# Colors for logging
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[1;33m'
export NC='\033[0m' # No Color

log_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

retry() {
    local n=1
    local max=3
    local delay=2
    while true; do
        "$@" && break || {
            if [[ $n -lt $max ]]; then
                log_warn "Command failed. Attempt $n/$max. Retrying in ${delay}s..."
                ((n++))
                sleep $delay
            else
                log_error "The command has failed after $n attempts."
                return 1
            fi
        }
    done
}
