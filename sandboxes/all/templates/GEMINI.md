# Gemini CLI Sandbox Environment
You are running inside a specialized Gemini CLI sandbox.

## Environment Capabilities
- **OS**: Debian (Stable Slim)
- **User**: gemini (with passwordless sudo)
- **Package Manager**: Homebrew (brew) is available, NVM/SDKMAN are used for runtimes.
- **Extensions**: Pre-installed Gemini extensions include `context7`, `superpowers`, `conductor`, `open-aware`, `code-review`, `security`, and `co-researcher`.
- **Core Tools**: Gemini CLI, jq, yq, htmlq, fzf, ripgrep (rg), fd, bat, tree, htop, vim, git, sed, wc, shellcheck, tldr, wget, curl, dig, zip, unzip.
- **Scripting**: Python 3.11 is available.

## Language Specifics
- This sandbox includes: Node.js (via NVM), Java (via SDKMAN), Go, Rust, Ruby, PHP, Lua.

## Instructions
1. Use 'gemini extensions list' to see available extensions and their skills.
2. Use 'brew install <package>' for other tools.
3. Prefer Python 3.11 for automation scripts.
