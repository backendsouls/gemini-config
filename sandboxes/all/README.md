# All-in-One Sandbox
**Opinionated unofficial Gemini CLI sandbox**

This is a comprehensive sandbox environment containing all supported runtimes and tools in a single image. It is built on **Debian (Stable Slim)** and inherits from the `base` sandbox.

## Included Tools
- **All Base Tools**: Includes all core and CLI utilities from the `base` sandbox.
- **Languages & Runtimes**: 
  - Python 3.13
  - Node.js (via NVM)
  - Java (OpenJDK via SDKMAN!)
  - Go, Rust, Ruby, PHP, Lua
- **Build & Debug**: `cmake`, `gdb`
- **Package Managers**: `apt` (Debian Native), NVM, SDKMAN!

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
docker build -t backendsouls/gemini-sandbox-all .
```

Run the container:
```bash
docker run -it backendsouls/gemini-sandbox-all
```

## Available Tags
- `latest`: Latest stable build.
- `backendsouls`: Team-verified alias.
- `python3.13-node24`: Runtime-versioned tag.

## Usage Notes
- **NVM**: To use Node.js, you may need to initialize NVM: `source $NVM_DIR/nvm.sh`.
- **SDKMAN!**: To use Java, Maven, or Gradle, you may need to initialize SDKMAN: `source $SDKMAN_DIR/bin/sdkman-init.sh`.

## Image Metadata
- **Base OS**: Debian (Stable Slim)
- **Architecture**: amd64, arm64
- **Repository**: [github.com/backendsouls/gemini-config](https://github.com/backendsouls/gemini-config)
