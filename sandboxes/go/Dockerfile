ARG BASE_IMAGE=gemini-sandbox-base
# Go Sandbox for Gemini CLI
FROM ${BASE_IMAGE}

# Install Go
RUN brew install go

# Update Gemini configuration file
COPY --chown=gemini:gemini templates/GEMINI.md /home/gemini/.gemini/GEMINI.md

CMD ["/bin/bash"]
