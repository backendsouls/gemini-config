# Ruby Sandbox
**Opinionated unofficial Gemini CLI sandbox**

This sandbox provides a specialized environment for Ruby development within the Gemini CLI. It inherits from the **Debian (Stable Slim)** based `gemini-sandbox-base`.

## Included Tools
- **Runtimes**: Ruby (Native via apt)
- **Package Manager**: Bundler, RubyGems
- **Base Utilities**: `jq`, `fzf`, `ripgrep` (rg), `fd`, `bat`, `tree`, `vim`, `htop`, `curl`, `git`

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
- **Ruby specifics**: Use `gem install <gem>` for additional Ruby-based tools.

## Security & Isolation
- **Strict Boundaries**: You MUST NOT attempt to access or read any host directories directly using absolute paths. 
- **Shared Workspace**: You are strictly confined to the currently shared directory (typically mounted at `/home/gemini/workspace`).
- **Volume Guidance**: If you need more data, provide the user with an `export SANDBOX_MOUNTS` example. Do not ask for direct access.
- **WORKSPACE Variable**: Respect the `WORKSPACE` environment variable if set by the user for shared project roots.

## Usage
Build the image:
```bash
docker build -t backendsouls/gemini-sandbox-ruby .
```

Run the container:
```bash
docker run -it backendsouls/gemini-sandbox-ruby
```

## Available Tags
- `latest`: Latest stable build.
- `backendsouls`: Team-verified alias.
- `python3.13-node24`: Runtime-versioned tag.

## Image Metadata
- **Base OS**: Debian (Stable Slim)
- **Architecture**: amd64, arm64
- **Repository**: [github.com/backendsouls/gemini-config](https://github.com/backendsouls/gemini-config)
