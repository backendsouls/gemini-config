ARG BASE_IMAGE=gemini-sandbox-base
# Rust Sandbox for Gemini CLI
FROM ${BASE_IMAGE}

USER gemini
# Install Rust (Minimal)
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --profile minimal

# Update Gemini configuration file
COPY --chown=gemini:gemini templates/GEMINI.md /home/gemini/.gemini/GEMINI.md

ENV PATH="/home/gemini/.cargo/bin:${PATH}"

CMD ["/bin/bash"]
