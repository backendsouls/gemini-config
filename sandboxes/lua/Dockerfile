ARG BASE_IMAGE=gemini-sandbox-base
# Lua Sandbox for Gemini CLI
FROM ${BASE_IMAGE}

# Install Lua and Luarocks
RUN brew install lua luarocks

# Update Gemini configuration file
COPY --chown=gemini:gemini templates/GEMINI.md /home/gemini/.gemini/GEMINI.md

CMD ["/bin/bash"]
