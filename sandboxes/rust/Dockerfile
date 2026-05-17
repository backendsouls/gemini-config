ARG BASE_IMAGE=gemini-sandbox-base
# Rust Sandbox for Gemini CLI
FROM ${BASE_IMAGE}

# Install Rust
RUN brew install rust

# Update Gemini configuration file
COPY --chown=gemini:gemini templates/GEMINI.md /home/gemini/.gemini/GEMINI.md

CMD ["/bin/bash"]
