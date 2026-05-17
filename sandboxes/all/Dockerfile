ARG BASE_IMAGE=gemini-sandbox-base
FROM ${BASE_IMAGE}

# Install NVM & SDKMAN
ENV NVM_DIR="/home/gemini/.nvm" SDKMAN_DIR="/home/gemini/.sdkman"
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash && \
    curl -s "https://get.sdkman.io" | bash

# Install Runtimes (minimal) and update PATH
RUN bash -c "source $NVM_DIR/nvm.sh && nvm install 20 && nvm alias default 20" && \
    bash -c "source $SDKMAN_DIR/bin/sdkman-init.sh && sdk install java 17.0.10-tem"

# Other languages via Brew (API mode ensures this is relatively light)
RUN brew install go rust ruby php lua cmake gdb && brew cleanup

# Set PATH for NVM and SDKMAN binaries to be available in non-interactive shells
ENV PATH="${NVM_DIR}/versions/node/v20.11.1/bin:${SDKMAN_DIR}/candidates/java/current/bin:${PATH}"

CMD ["/bin/bash"]
