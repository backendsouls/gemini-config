#!/bin/bash
# setup.sh - Java sandbox setup
source /usr/local/bin/common.sh

source /home/gemini/.sdkman/bin/sdkman-init.sh

log_info "Installing Java 17 via SDKMAN..."
retry sdk install java 17.0.10-tem

log_info "Installing Maven and Gradle..."
retry sdk install maven
retry sdk install gradle

log_info "Clearing SDKMAN! caches..."
sdk flush archives
sdk flush temp
rm -rf /home/gemini/.sdkman/archives/*
rm -rf /home/gemini/.sdkman/tmp/*
