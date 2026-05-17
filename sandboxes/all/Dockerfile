ARG BASE_IMAGE=gemini-sandbox-base
FROM ${BASE_IMAGE}

LABEL description="Comprehensive sandbox image with all runtimes"

# Runtime directories
ENV NVM_DIR="/home/gemini/.nvm" SDKMAN_DIR="/home/gemini/.sdkman"

# Initialize managers
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash && \
    curl -s "https://get.sdkman.io" | bash && \
    sed -i 's/sdkman_healthcheck_enable=true/sdkman_healthcheck_enable=false/' "$SDKMAN_DIR/etc/config"

# Execution of modular setup
COPY --chown=gemini:gemini scripts/setup.sh /home/gemini/setup.sh
RUN chmod +x /home/gemini/setup.sh && /home/gemini/setup.sh && rm /home/gemini/setup.sh

# Install other languages via Brew
RUN brew install go rust ruby php lua cmake gdb && brew cleanup

# Custom environment documentation
COPY --chown=gemini:gemini templates/GEMINI.md /home/gemini/.gemini/GEMINI.md

# Path updates
ENV PATH="${NVM_DIR}/current/bin:${SDKMAN_DIR}/candidates/java/current/bin:${PATH}"

CMD ["/bin/bash"]
