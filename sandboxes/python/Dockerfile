ARG BASE_IMAGE=gemini-sandbox-base
# Python Sandbox for Gemini CLI
FROM ${BASE_IMAGE}

# Update Gemini configuration file
COPY --chown=gemini:gemini templates/GEMINI.md /home/gemini/.gemini/GEMINI.md

CMD ["/bin/bash"]
