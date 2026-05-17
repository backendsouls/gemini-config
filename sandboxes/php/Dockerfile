ARG BASE_IMAGE=gemini-sandbox-base
# PHP Sandbox for Gemini CLI
FROM ${BASE_IMAGE}

USER root
# Install PHP (Native)
RUN apt-get update && apt-get install -y --no-install-recommends \
    php-cli php-dev \
    && rm -rf /var/lib/apt/lists/*

USER gemini
# Update Gemini configuration file
COPY --chown=gemini:gemini templates/GEMINI.md /home/gemini/.gemini/GEMINI.md

CMD ["/bin/bash"]
