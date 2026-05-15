# Lua Sandbox for Gemini CLI
FROM gemini-sandbox-base

# Install Lua and Luarocks
RUN brew install lua luarocks

# Update Gemini configuration file
RUN printf '# Gemini CLI Sandbox Environment\n\
You are running inside a specialized Gemini CLI sandbox.\n\
\n\
## Environment Capabilities\n\
- **OS**: Ubuntu 22.04\n\
- **User**: gemini (with passwordless sudo)\n\
- **Package Manager**: Homebrew (brew) is available and preferred.\n\
- **Core Tools**: Gemini CLI, jq, yq, htmlq, fzf, ripgrep (rg), fd, bat, tree, htop, vim, git, sed, wc, shellcheck, tldr, wget, curl, dig, zip, unzip.\n\
- **Scripting**: Python 3.11 and Lua are available.\n\
\n\
## Language Specifics\n\
- This sandbox includes: Gemini CLI, Lua, Luarocks\n\
\n\
## Instructions\n\
1. Use '\''brew install <package>'\'' if you need more tools.\n\
2. Use '\''luarocks install <rock>'\'' for Lua modules.\n\
3. Prefer Lua for lightweight scripting tasks.\n' > /home/gemini/.gemini/GEMINI.md

CMD ["/bin/bash"]
