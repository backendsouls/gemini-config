ARG BASE_IMAGE=gemini-sandbox-base
# C++ Sandbox for Gemini CLI
FROM ${BASE_IMAGE}

USER root
# In the C++ sandbox, we MUST have build-essential
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential cmake gdb \
    && rm -rf /var/lib/apt/lists/*

USER gemini
# Update Gemini configuration file
COPY --chown=gemini:gemini templates/GEMINI.md /home/gemini/.gemini/GEMINI.md

CMD ["/bin/bash"]
