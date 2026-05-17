# Gemini CLI Sandbox Environment
**Opinionated unofficial Gemini CLI sandbox**
You are running inside a specialized Gemini CLI sandbox.

## Environment Capabilities
- **OS**: Debian (Stable Slim)
- **User**: gemini (with passwordless sudo)
- **Package Manager**: `apt` (Debian Native) is available, NVM/SDKMAN are used for runtimes.
- **Core Tools**: Gemini CLI, jq, yq, htmlq, fzf, ripgrep (rg), fd, bat, tree, htop, vim, git, sed, wc, shellcheck, tldr, wget, curl, dig, zip, unzip.
- **Scripting**: Python 3.11 is available.

## Language Specifics
- This sandbox includes: Node.js (via NVM), Java (via SDKMAN), Go, Rust, Ruby, PHP, Lua.

## Pre-installed Extensions
- `context7`: Enhanced context management (Upstash).
- `superpowers`: Advanced utility tools.
- `conductor`: Workflow orchestration.
- `open-aware`: Code awareness and symbol understanding.
- `code-review`: Automated code quality analysis.
- `gemini-cli-security`: Vulnerability identification.
- `co-researcher`: Deep research assistant.

## Best Practices
- Use the `WORKSPACE` variable for project context.
- Use `sudo apt-get install` for on-demand tools.
- Use the `retry` utility for resilient scripts.
- Run `gemini extensions list` to explore capabilities.
