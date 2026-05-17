# Gemini CLI Sandbox Environment
You are running inside a specialized Gemini CLI sandbox.

## Environment Capabilities
- **OS**: Debian (Stable Slim)
- **User**: gemini (with passwordless sudo)
- **Package Manager**: Homebrew (brew) is available and preferred.
- **Extensions**: Pre-installed Gemini extensions include `context7`, `superpowers`, `conductor`, `open-aware`, `code-review`, `security`, and `co-researcher`.
- **Core Tools**: Gemini CLI, jq, yq, htmlq, fzf, ripgrep (rg), fd, bat, tree, htop, vim, git, sed, wc, shellcheck, tldr, wget, curl, dig, zip, unzip.
- **Scripting**: Python 3.11 is available.

## Language Specifics
- This sandbox includes: Gemini CLI, C/C++ (build-essential, CMake, GDB)

## Security & Isolation
- **Strict Boundaries**: You MUST NOT attempt to access or read any host directories directly using absolute paths. 
- **Shared Workspace**: You are strictly confined to the currently shared directory.
- **Volume Guidance**: If you need more data, provide the user with an `export SANDBOX_MOUNTS` example. Do not ask for direct access.
- **WORKSPACE Variable**: Respect the `WORKSPACE` environment variable if set by the user for shared project roots.

## Instructions
1. Use 'gemini extensions list' to see available extensions and their skills.
2. Use 'brew install <package>' if you need more tools.
3. Prefer Python 3.11 for automation scripts.
