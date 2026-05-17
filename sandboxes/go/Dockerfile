ARG BASE_IMAGE=gemini-sandbox-base
# Go Sandbox for Gemini CLI
FROM ${BASE_IMAGE}

USER root
# Install Go (Native)
RUN GO_VERSION="1.22.3" && \
    ARCH=$(dpkg --print-architecture) && \
    [ "$ARCH" = "amd64" ] && GO_ARCH="amd64" || GO_ARCH="arm64" && \
    curl -L "https://golang.org/dl/go${GO_VERSION}.linux-${GO_ARCH}.tar.gz" | tar -C /usr/local -xz

USER gemini
# Update Gemini configuration file
COPY --chown=gemini:gemini templates/GEMINI.md /home/gemini/.gemini/GEMINI.md

ENV PATH="/usr/local/go/bin:${PATH}"

CMD ["/bin/bash"]
