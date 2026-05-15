# All-in-One Sandbox for Gemini CLI
FROM gemini-sandbox-base

# Install SDKMAN, Maven, and Gradle
ENV SDKMAN_DIR="/home/gemini/.sdkman"
RUN curl -s "https://get.sdkman.io" | bash && \
    bash -c "source $SDKMAN_DIR/bin/sdkman-init.sh && \
    sdk install java 17.0.10-tem && \
    sdk install maven && \
    sdk install gradle"

# Install NVM and TypeScript
ENV NVM_DIR="/home/gemini/.nvm"
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash && \
    bash -c "source $NVM_DIR/nvm.sh && \
    nvm install 20 && \
    nvm use 20 && \
    npm install -g typescript ts-node"

# Install other languages via Homebrew
RUN brew install \
    go \
    rust \
    ruby \
    php \
    lua \
    luarocks \
    cmake \
    gdb

# Update Gemini configuration file
RUN printf '# Gemini CLI Sandbox Environment\n\
You are running inside a specialized Gemini CLI sandbox.\n\
\n\
## Environment Capabilities\n\
- **OS**: Ubuntu 22.04\n\
- **User**: gemini (with passwordless sudo)\n\
- **Package Manager**: Homebrew (brew), SDKMAN (Java), NVM (Node.js).\n\
- **Core Tools**: Gemini CLI, jq, yq, htmlq, fzf, ripgrep (rg), fd, bat, tree, htop, vim, git, sed, wc, shellcheck, tldr, wget, curl, dig, zip, unzip.\n\
- **Scripting**: Python 3.11 and Lua are available.\n\
\n\
## Language Specifics\n\
- This sandbox includes: Gemini CLI, Python, Node.js (via NVM), TypeScript, Go, Rust, Ruby, Java (via SDKMAN), PHP, Lua, Luarocks, C/C++ (build-essential, CMake, GDB)\n\

- **Usage**: Run `source "$SDKMAN_DIR/bin/sdkman-init.sh"` or `source "$NVM_DIR/nvm.sh"` to initialize managers.\n\
\n\
## Instructions\n\
1. Use version managers (sdk/nvm) to switch runtime versions.\n\
2. Use '\''brew install <package>'\'' for other tools.\n\
3. Prefer Python 3.11 for automation scripts.\n' > /home/gemini/.gemini/GEMINI.md

CMD ["/bin/bash"]
