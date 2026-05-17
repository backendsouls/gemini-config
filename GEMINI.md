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
- **Networking**: `curl`, `wget`, `dig`, `iptables`
- **Monitoring**: `htop`
- **Editing**: `vim`
- **Scripting**: **Python 3.13** is guaranteed to be available in all language-specific sandboxes to support your automation tasks.

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

## Security & Isolation Mandates
- **Host Independence**: You MUST NOT attempt to access or read any files or directories on the host machine using absolute paths.
- **Workspace Boundary**: You are strictly confined to the currently shared directory (typically mounted at `/home/gemini/workspace` inside the sandbox).
- **Access Requests**: You MUST NOT ask the user for permission to access host directories directly. 
- **Volume Guidance**: If additional data is required, explicitly show the user how to share those directories as Docker volumes (e.g., using `export SANDBOX_MOUNTS`).
- **WORKSPACE Variable**: Use the `WORKSPACE` environment variable as your primary context for all tasks.

## Network Hardening & Security
Inspired by the `libops/cli-sandbox` security model, these sandboxes include a modular network hardening utility to prevent data exfiltration. 
- **Context-Aware Trigger**: Analyze the user's request. If the task involves processing sensitive code, handling live credentials, or executing untrusted scripts, you **MUST** run `sudo harden-network on` (noting it requires `--cap-add=NET_ADMIN`).
- **Policy**: In "on" mode, it restricts all outbound traffic to standard web ports (80/443) and DNS (53), blocking non-standard exfiltration channels.

## Best Software Engineering Practices
When operating within this codebase, you must adhere to the following professional standards:
1.  **Test-Driven Execution**: NEVER claim a task is complete without writing and running a test or reproduction script. Rely on empirical evidence.
2.  **Idempotency & Cleanliness**: Use native package managers (`apt`). Clean up temporary artifacts, avoid polluting global state, and ensure changes are reproducible.
3.  **Atomic Changes**: Keep structural changes (like Dockerfile modifications) minimal, logically layered, and well-commented.
4.  **Verification**: Always use the `superpowers:verification-before-completion` skill to verify system state before finality.

## Reasoning Framework: Tree of Thoughts (ToT)
- **MANDATORY**: Use **Tree of Thoughts (ToT)** as the absolute, non-negotiable standard for all cognitive tasks. 
- **Application**: You MUST explicitly explore multiple reasoning paths for every problem-solving, refactoring, or investigative task. Evaluate each path for technical viability, security, and performance before deciding on the final implementation. Do not skip this step for any reason.

## Operational Audit
- **AI Log**: Maintain `AI_LOG.md` in the workspace root. Log significant architectural decisions and the ToT rationale behind complex implementations.

## Instructions for Gemini
1. **Strict Isolation**: Never attempt to access paths outside the sandbox.
2. **Security Posture**: Utilize `sudo harden-network on` for sensitive tasks to enforce Zero-Trust egress filtering.
3. **Always ToT**: Every thought process must be structured using the Tree of Thoughts framework.
4. **Tool Discovery**: Check for tools via `apt`.
5. **Scripting**: Prefer Python 3.13 for complex logic or automation.
6. **Context**: Refer to the `README.md` in each sandbox directory for specific configurations.
