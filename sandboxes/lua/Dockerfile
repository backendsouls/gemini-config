ARG BASE_IMAGE=gemini-sandbox-base
# Lua Sandbox for Gemini CLI
FROM ${BASE_IMAGE}

USER root
# Install Lua (Native)
RUN apt-get update && apt-get install -y --no-install-recommends \
    lua5.4 liblua5.4-dev \
    && rm -rf /var/lib/apt/lists/*

USER gemini
# Update Gemini configuration file
COPY --chown=gemini:gemini templates/GEMINI.md /home/gemini/.gemini/GEMINI.md

CMD ["/bin/bash"]
