ARG BASE_IMAGE=gemini-sandbox-base
# JavaScript Sandbox for Gemini CLI
FROM ${BASE_IMAGE}

# Install NVM and TypeScript
ENV NVM_DIR="/home/gemini/.nvm"
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

COPY --chown=gemini:gemini scripts/setup.sh /home/gemini/setup.sh
RUN chmod +x /home/gemini/setup.sh && /home/gemini/setup.sh && rm /home/gemini/setup.sh

# Update Gemini configuration file
COPY --chown=gemini:gemini templates/GEMINI.md /home/gemini/.gemini/GEMINI.md

CMD ["/bin/bash"]
