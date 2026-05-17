# JavaScript Sandbox
**Opinionated unofficial Gemini CLI sandbox**

A specialized environment for JavaScript and TypeScript development, built on **Debian (Stable Slim)** and inheriting from the `base` sandbox. It uses NVM for managing Node.js versions.

## Included Tools
- **JavaScript Development**: Node.js (via NVM), npm, pnpm, TypeScript
- **Base Utilities**: Includes all core and CLI utilities from the `base` sandbox (e.g., `ripgrep`, `fd`, `jq`, `bat`).
- **Package Managers**: `apt` (Debian Native), NVM

## Pre-installed Extensions
This sandbox comes with several pre-installed Gemini extensions to enhance your development workflow:
- `context7`: Enhanced context management using Upstash.
- `superpowers`: Advanced utility tools for agent efficiency.
- `conductor`: Workflow orchestration and track management.
- `open-aware`: Code awareness and symbol understanding across repositories.
- `code-review`: Automated code quality and PR analysis.
- `gemini-cli-security`: Vulnerability identification and secure coding assistant.
- `co-researcher`: Deep research and synthesis capabilities.

You can explore these capabilities using `gemini extensions list`.

## Best Practices
- **Workspace Context**: Use the `WORKSPACE` environment variable to define your project root for multi-project tasks.
- **Tool Installation**: Prefer `sudo apt-get install` for temporary tools to keep the environment clean and reproducible.
- **Resilient Scripts**: Leverage the `retry` utility (pre-installed in `scripts/`) for resilient network operations in your automation scripts.
- **Discovery**: Explore extension capabilities and documentation with `gemini extensions list`.
- **Network Security**: Secure your session by running `sudo harden-network on` to restrict outbound traffic to standard web ports (requires Docker `--cap-add=NET_ADMIN`).

## Security & Isolation
- **Strict Boundaries**: All tools and extensions are pre-installed in the image for total isolation. The agent cannot access host paths outside the shared directory.
- **Shared Workspace**: Respects the `WORKSPACE` environment variable for shared project roots. Use this as your primary context.
- **Volume Guidance**: If additional data is required, the agent will guide you on using `SANDBOX_MOUNTS` or `docker run -v` to share host directories safely.

## Usage
Build the image:
```bash
docker build -t backendsouls/gemini-sandbox-js .
```

Run the container:
```bash
docker run -it backendsouls/gemini-sandbox-js
```

## Note for Runtimes
- **NVM**: To use Node.js, you may need to initialize NVM in your shell: `source $NVM_DIR/nvm.sh`.

## Image Metadata
- **Base OS**: Debian (Stable Slim)
- **Architecture**: amd64, arm64
- **Repository**: [github.com/backendsouls/gemini-config](https://github.com/backendsouls/gemini-config)

## Available Tags
- `latest`: Latest stable build.
- `backendsouls`: Team-verified alias.
- `python3.13-node24`: Runtime-versioned tag.
