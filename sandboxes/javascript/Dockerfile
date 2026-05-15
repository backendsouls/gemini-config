# JavaScript Sandbox for Gemini CLI
FROM gemini-sandbox-base

# Install NVM and TypeScript
ENV NVM_DIR="/home/gemini/.nvm"
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash && \
    bash -c "source $NVM_DIR/nvm.sh && \
    nvm install 20 && \
    nvm use 20 && \
    npm install -g typescript ts-node"

# Update Gemini configuration file
RUN printf '# Gemini CLI Sandbox Environment\n\
You are running inside a specialized Gemini CLI sandbox.\n\
\n\
## Environment Capabilities\n\
- **OS**: Ubuntu 22.04\n\
- **User**: gemini (with passwordless sudo)\n\
- **Package Manager**: Homebrew (brew) is available, NVM is used for Node.js versions.\n\
- **Core Tools**: Gemini CLI, jq, yq, htmlq, fzf, ripgrep (rg), fd, bat, tree, htop, vim, git, sed, wc, shellcheck, tldr, wget, curl, dig, zip, unzip.\n\
- **Scripting**: Python 3.11 is available.\n\
\n\
## Language Specifics\n\
- This sandbox includes: Gemini CLI, Node.js (via NVM), TypeScript, npm\n\

- **NVM Usage**: Run `source "$NVM_DIR/nvm.sh"` to initialize NVM in a shell.\n\
\n\
## Instructions\n\
1. Use '\''nvm install <version>'\'' to switch Node.js versions.\n\
2. Use '\''brew install <package>'\'' for other tools.\n\
3. Prefer Python 3.11 for automation scripts.\n' > /home/gemini/.gemini/GEMINI.md

CMD ["/bin/bash"]
