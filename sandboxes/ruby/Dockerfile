ARG BASE_IMAGE=gemini-sandbox-base
# Ruby Sandbox for Gemini CLI
FROM ${BASE_IMAGE}

# Install Ruby
RUN brew install ruby

# Update Gemini configuration file
COPY --chown=gemini:gemini templates/GEMINI.md /home/gemini/.gemini/GEMINI.md

CMD ["/bin/bash"]
