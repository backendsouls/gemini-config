ARG BASE_IMAGE=gemini-sandbox-base
# Java Sandbox for Gemini CLI
FROM ${BASE_IMAGE}

# Install SDKMAN, Maven, and Gradle
RUN curl -s "https://get.sdkman.io" | bash && \
    sed -i 's/sdkman_healthcheck_enable=true/sdkman_healthcheck_enable=false/' /home/gemini/.sdkman/etc/config

COPY --chown=gemini:gemini scripts/setup.sh /home/gemini/setup.sh
RUN chmod +x /home/gemini/setup.sh && /home/gemini/setup.sh && rm /home/gemini/setup.sh

# Set up environment for SDKMAN
ENV SDKMAN_DIR="/home/gemini/.sdkman"

# Update Gemini configuration file
COPY --chown=gemini:gemini templates/GEMINI.md /home/gemini/.gemini/GEMINI.md

CMD ["/bin/bash"]
