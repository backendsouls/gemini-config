# Base Sandbox

This is the foundation for all Gemini CLI specialized sandboxes. It is built on **Debian (Stable Slim)** and includes a comprehensive suite of essential development and diagnostic tools.

## Included Tools
- **Core Utilities**: `curl`, `git`, `sudo`, `procps`, `file`, `wget`, `dnsutils`, `zip`, `unzip`, `sed`
- **CLI Utilities**: `ripgrep` (rg), `fd`, `jq`, `yq`, `htmlq`, `bat`, `fzf`, `vim`, `htop`, `tree`, `shellcheck`, `tldr`
- **Runtimes**: Python 3.11, Node.js, npm, pnpm
- **Package Managers**: `apt` (Debian Native)

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

## Security & Isolation
- **Strict Boundaries**: All tools and extensions are pre-installed in the image for total isolation. The agent cannot access host paths outside the shared directory.
- **Shared Workspace**: Respects the `WORKSPACE` environment variable for shared project roots. Use this as your primary context.
- **Volume Guidance**: If additional data is required, the agent will guide you on using `SANDBOX_MOUNTS` or `docker run -v` to share host directories safely.

## Usage
Build the image:
```bash
docker build -t gemini-sandbox-base .
```

Run the container:
```bash
docker run -it gemini-sandbox-base
```

## Note for Runtimes
This base image sets a global npm prefix in `~/.npmrc` to allow the `gemini` user to install global packages. If you inherit from this image and plan to use `nvm`, you MUST run `npm config delete prefix` before installing Node.js versions via `nvm`.

## Image Metadata
- **Base OS**: Debian (Stable Slim)
- **Architecture**: amd64, arm64
- **Repository**: [github.com/backendsouls/gemini-config](https://github.com/backendsouls/gemini-config)
