# All-in-One Sandbox for Gemini CLI
FROM gemini-sandbox-base

# Install all languages and tools
RUN brew install \
    python@3.11 \
    node \
    go \
    rust \
    ruby \
    openjdk \
    php \
    cmake \
    gdb

# Set up environment
ENV PATH="/home/linuxbrew/.linuxbrew/opt/python@3.11/bin:${PATH}"
ENV JAVA_HOME="/home/linuxbrew/.linuxbrew/opt/openjdk"
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# Update Gemini configuration file
RUN printf '# Gemini CLI Sandbox Environment\n\
You are running inside a specialized Gemini CLI sandbox.\n\
\n\
## Environment Capabilities\n\
- **OS**: Ubuntu 22.04\n\
- **User**: gemini (with passwordless sudo)\n\
- **Package Manager**: Homebrew (brew) is available and preferred.\n\
- **Core Tools**: jq, yq, htmlq, fzf, ripgrep (rg), fd, bat, tree, htop, vim, git, sed, wc, shellcheck, tldr, wget, curl, dig.\n\
- **Scripting**: Python 3.11 is available.\n\
\n\
## Language Specifics\n\
- This sandbox includes: Python 3.11, Node.js, Go, Rust, Ruby, OpenJDK, PHP, C/C++ (CMake, GDB)\n\
\n\
## Instructions\n\
1. Use '\''brew install <package>'\'' if you need more tools.\n\
2. Prefer Python 3.11 for automation scripts.\n' > /home/gemini/.gemini/GEMINI.md

CMD ["/bin/bash"]
