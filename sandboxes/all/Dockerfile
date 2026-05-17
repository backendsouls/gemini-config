ARG BASE_IMAGE=gemini-sandbox-base
FROM ${BASE_IMAGE}

LABEL description="Comprehensive sandbox image with all runtimes"

# Runtime directories
ENV NVM_DIR="/home/gemini/.nvm" SDKMAN_DIR="/home/gemini/.sdkman"

USER root
# Install native packages (replacing Brew)
RUN apt-get update && apt-get install -y --no-install-recommends \
    ruby ruby-dev php-cli php-dev lua5.4 liblua5.4-dev cmake gdb \
    && rm -rf /var/lib/apt/lists/*

# Initialize managers
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash && \
    curl -s "https://get.sdkman.io" | bash && \
    sed -i 's/sdkman_healthcheck_enable=true/sdkman_healthcheck_enable=false/' "$SDKMAN_DIR/etc/config"

USER gemini
# Execution of modular setup
COPY --chown=gemini:gemini scripts/setup.sh /home/gemini/setup.sh
RUN chmod +x /home/gemini/setup.sh && /home/gemini/setup.sh && rm /home/gemini/setup.sh

# Custom environment documentation
COPY --chown=gemini:gemini templates/GEMINI.md /home/gemini/.gemini/GEMINI.md

# Path updates (Native Go and Rust)
ENV PATH="/usr/local/go/bin:/home/gemini/.cargo/bin:${NVM_DIR}/current/bin:${SDKMAN_DIR}/candidates/java/current/bin:${PATH}"

CMD ["/bin/bash"]
