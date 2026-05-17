ARG BASE_IMAGE=gemini-sandbox-base
# C++ Sandbox for Gemini CLI
FROM ${BASE_IMAGE}

# Install C++ tools
RUN brew install cmake gdb

# Update Gemini configuration file
COPY --chown=gemini:gemini templates/GEMINI.md /home/gemini/.gemini/GEMINI.md

CMD ["/bin/bash"]
