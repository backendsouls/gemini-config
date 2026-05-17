ARG BASE_IMAGE=gemini-sandbox-base
# PHP Sandbox for Gemini CLI
FROM ${BASE_IMAGE}

# Install PHP
RUN brew install php

# Update Gemini configuration file
COPY --chown=gemini:gemini templates/GEMINI.md /home/gemini/.gemini/GEMINI.md

CMD ["/bin/bash"]
