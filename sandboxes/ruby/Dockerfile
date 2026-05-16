ARG BASE_IMAGE=gemini-sandbox-base
# Ruby Sandbox for Gemini CLI
FROM ${BASE_IMAGE}

# Install Ruby
RUN brew install ruby

# Update Gemini configuration file
RUN printf '# Gemini CLI Sandbox Environment\n\
You are running inside a specialized Gemini CLI sandbox.\n\
\n\
## Environment Capabilities\n\
- **OS**: Ubuntu 22.04\n\
- **User**: gemini (with passwordless sudo)\n\
- **Package Manager**: Homebrew (brew) is available and preferred.\n\
- **Extensions**: Pre-installed Gemini extensions include \`context7\`, \`superpowers\`, \`conductor\`, \`open-aware\`, \`code-review\`, \`security\`, and \`co-researcher\`.\n\
- **Core Tools**: Gemini CLI, jq, yq, htmlq, fzf, ripgrep (rg), fd, bat, tree, htop, vim, git, sed, wc, shellcheck, tldr, wget, curl, dig, zip, unzip.\n\
- **Scripting**: Python 3.11 is available.\n\
\n\
## Language Specifics\n\
- This sandbox includes: Gemini CLI, Ruby\n\
\n\
## Security & Isolation\n\
- **Strict Boundaries**: You MUST NOT attempt to access or read any host directories directly using absolute paths. \n\
- **Shared Workspace**: You are strictly confined to the currently shared directory.\n\
- **Volume Guidance**: If you need more data, provide the user with an \`export SANDBOX_MOUNTS\` example. Do not ask for direct access.\n\
- **WORKSPACE Variable**: Respect the \`WORKSPACE\` environment variable if set by the user for shared project roots.\n\
\n\
## Instructions\n\
1. Use '\''gemini extensions list'\'' to see available extensions and their skills.\n\
2. Use '\''brew install <package>'\'' if you need more tools.\n\
3. Prefer Python 3.11 for automation scripts.\n' > /home/gemini/.gemini/GEMINI.md

CMD ["/bin/bash"]
