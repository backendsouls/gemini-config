ARG BASE_IMAGE=gemini-sandbox-base
# Java Sandbox for Gemini CLI
FROM ${BASE_IMAGE}

# Install SDKMAN, Maven, and Gradle
RUN curl -s "https://get.sdkman.io" | bash && \
    bash -c "source /home/gemini/.sdkman/bin/sdkman-init.sh && \
    sdk install java 17.0.10-tem && \
    sdk install maven && \
    sdk install gradle"

# Set up environment for SDKMAN
ENV SDKMAN_DIR="/home/gemini/.sdkman"

# Update Gemini configuration file
RUN printf '# Gemini CLI Sandbox Environment\n\
You are running inside a specialized Gemini CLI sandbox.\n\
\n\
## Environment Capabilities\n\
- **OS**: Ubuntu 22.04\n\
- **User**: gemini (with passwordless sudo)\n\
- **Package Manager**: Homebrew (brew) is available, SDKMAN is used for Java versions.\n\
- **Extensions**: Pre-installed Gemini extensions include \`context7\`, \`superpowers\`, \`conductor\`, \`open-aware\`, \`code-review\`, \`security\`, and \`co-researcher\`.\n\
- **Core Tools**: Gemini CLI, jq, yq, htmlq, fzf, ripgrep (rg), fd, bat, tree, htop, vim, git, sed, wc, shellcheck, tldr, wget, curl, dig, zip, unzip.\n\
- **Scripting**: Python 3.11 is available.\n\
\n\
## Language Specifics\n\
- This sandbox includes: Gemini CLI, Java (via SDKMAN), Maven, Gradle\n\
\n\
- **SDKMAN Usage**: Run `source "$SDKMAN_DIR/bin/sdkman-init.sh"` to initialize SDKMAN in a shell.\n\
\n\
## Security & Isolation\n\
- **Strict Boundaries**: You MUST NOT attempt to access or read any host directories directly using absolute paths. \n\
- **Shared Workspace**: You are strictly confined to the currently shared directory.\n\
- **Volume Guidance**: If you need more data, provide the user with an \`export SANDBOX_MOUNTS\` example. Do not ask for direct access.\n\
- **WORKSPACE Variable**: Respect the \`WORKSPACE\` environment variable if set by the user for shared project roots.\n\
\n\
## Instructions\n\
1. Use '\''gemini extensions list'\'' to see available extensions and their skills.\n\
2. Use '\''sdk install java <version>'\'' to switch Java versions.\n\
3. Use '\''brew install <package>'\'' for other tools.\n\
4. Prefer Python 3.11 for automation scripts.\n' > /home/gemini/.gemini/GEMINI.md

CMD ["/bin/bash"]
