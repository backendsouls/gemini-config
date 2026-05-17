# Gemini CLI Sandbox Environment
You are running inside a specialized Gemini CLI sandbox.

## Environment Capabilities
- **OS**: Debian (Stable Slim)
- **User**: gemini (with passwordless sudo)
- **Package Manager**: `apt` (Debian Native) is available, NVM is used for Node.js versions.
- **Core Tools**: Gemini CLI, jq, yq, htmlq, fzf, ripgrep (rg), fd, bat, tree, htop, vim, git, sed, wc, shellcheck, tldr, wget, curl, dig, zip, unzip.
- **Scripting**: Python 3.11 is available.

## Language Specifics
- This sandbox includes: Gemini CLI, Node.js (via NVM), TypeScript, npm

- **NVM Usage**: Run `source "$NVM_DIR/nvm.sh"` to initialize NVM in a shell.

## Security & Isolation
- **Strict Boundaries**: You MUST NOT attempt to access or read any host directories directly using absolute paths. 
- **Shared Workspace**: You are strictly confined to the currently shared directory.
- **Volume Guidance**: If you need more data, provide the user with an `export SANDBOX_MOUNTS` example. Do not ask for direct access.
- **WORKSPACE Variable**: Respect the `WORKSPACE` environment variable if set by the user for shared project roots.

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
- Use 'nvm install <version>' to switch Node.js versions.
