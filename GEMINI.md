# Gemini CLI Sandbox Environment Instructions

This workspace is designed to manage and build various Docker-based sandbox environments. 

## Sandbox Architecture
- **Location**: All sandboxes are located in the `sandboxes/` directory.
- **Architecture**: A hierarchical Docker structure is used. All language sandboxes inherit from `sandboxes/base`.
- **Base Image**: The `base` sandbox is built on Debian (Stable Slim).
- **Package Managers**: 
  - **APT (`apt-get`)**: Primary manager for system tools and libraries.
  - **SDKMAN!**: Used in Java sandboxes for JDKs, Maven, and Gradle.
  - **NVM**: Used in JavaScript sandboxes for Node.js versions.
- **User**: The default user in all sandboxes is `gemini` with `sudo` access.

## Available Tools (Pre-installed via Apt/Native)
When working within these sandboxes, you have access to:
- **Compilers**: `build-essential` (gcc, g++, make), `cmake`, `gdb`
- **Text Processing**: `jq`, `yq`, `htmlq`, `sed`, `wc`, `zip`, `unzip`
- **Quality & Docs**: `shellcheck`, `tldr`
- **Fuzzy Finding**: `fzf`
- **Searching**: `ripgrep` (`rg`), `fd`
- **Viewing**: `bat`, `tree`
- **Networking**: `curl`, `wget`, `dig`
- **Monitoring**: `htop`
- **Editing**: `vim`
- **Scripting**: **Python 3.11** is guaranteed to be available in all language-specific sandboxes to support your automation tasks.

## Pre-installed Extensions
The following Gemini CLI extensions are pre-installed and pre-built in all sandboxes:
- **context7**: Enhanced context management (Upstash).
- **superpowers**: Advanced utility tools (Obra).
- **conductor**: Workflow orchestration.
- **open-aware**: Code awareness and symbol understanding.
- **code-review**: Automated code quality analysis.
- **gemini-cli-security**: Vulnerability identification and secure coding.
- **co-researcher**: Deep research and synthesis assistant.

Extensions are located in `/home/gemini/.gemini/extensions` and are automatically recognized by the CLI.

## Build System
A `Makefile` is available in the root directory to manage builds:
- `make build-all`: Builds all sandbox images.
- `make <language>`: Builds a specific language sandbox (e.g., `make rust`, `make python`).
- `make all-in-one`: Builds the comprehensive `gemini-sandbox-all` image.

## Usage with Gemini CLI
To use these sandboxes with the `gemini -s` command, set the following environment variables:
```bash
export GEMINI_SANDBOX=docker
export GEMINI_SANDBOX_IMAGE=gemini-sandbox-all
# Optional: Set a dedicated workspace directory to share with the sandbox
export WORKSPACE=/path/to/your/projects
```

## Security & Isolation Mandates
- **Host Independence**: You MUST NOT attempt to access or read any files or directories on the host machine using absolute paths (e.g., `/home/backendsouls/...`).
- **Workspace Boundary**: You are strictly confined to the currently shared directory (typically mounted at `/home/gemini/workspace` or similar inside the sandbox).
- **Access Requests**: You MUST NOT ask the user for permission to access host directories directly. 
- **Volume Guidance**: If you identify that additional data or directories are required for a task, you must explicitly show the user how to share those directories as Docker volumes (e.g., using `export SANDBOX_MOUNTS`).
- **WORKSPACE Environment Variable**: If the `WORKSPACE` environment variable is set, it indicates the root of shared repositories. Use this as your primary context for multi-project tasks.

## Reasoning Framework
- **Methodology**: Use **Tree of Thoughts (ToT)** as the primary framework for all cognitive tasks.
- **Application**: When studying the codebase, generating new features, writing tests, or debugging issues, explicitly explore multiple reasoning paths. Evaluate each path for technical viability, security, and performance before deciding on the final implementation.

## Operational Audit
- **AI Log**: Maintain a file named `AI_LOG.md` in the workspace root. Log significant architectural decisions, tool choices, and the rationale behind complex implementations. This log serves as a chronological record of the agent's actions and decisions for transparency and review.

## Instructions for Gemini
1. **Strict Isolation**: Never attempt to access paths outside the sandbox. If you need more data, provide the user with a `docker run` or `export SANDBOX_MOUNTS` command example.
2. **Tool Discovery**: If you need a tool that isn't installed, check if it's available via `apt`.
3. **Scripting**: Prefer Python 3.11 for complex logic or automation tasks within the sandboxes.
4. **Environment**: Global Node.js packages are located in `/home/gemini/.npm-global/bin`.
5. **Context**: Each sandbox directory contains a `README.md` with specific details about that environment's language and configuration.
