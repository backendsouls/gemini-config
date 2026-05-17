# PHP Sandbox

A specialized environment for PHP development, built on **Debian (Stable Slim)** and inheriting from the `base` sandbox.

## Included Tools
- **PHP Development**: `php`
- **Base Utilities**: Includes all core and CLI utilities from the `base` sandbox (e.g., `ripgrep`, `fd`, `jq`, `bat`).
- **Package Managers**: Homebrew (`brew`)

## Pre-installed Extensions
This sandbox comes with several pre-installed Gemini extensions:
- `context7`, `superpowers`, `conductor`, `open-aware`, `code-review`, `gemini-cli-security`, and `co-researcher`.
You can list them using `gemini extensions list`.

## Security & Isolation
- **Strict Boundaries**: All tools and extensions are pre-installed in the image for total isolation. The agent cannot access host paths outside the shared directory.
- **Shared Workspace**: Respects the `WORKSPACE` environment variable for shared project roots. Use this as your primary context.
- **Volume Guidance**: If additional data is required, the agent will guide you on using `SANDBOX_MOUNTS` or `docker run -v` to share host directories safely.

## Usage
Build the image:
```bash
docker build -t gemini-sandbox-php .
```

Run the container:
```bash
docker run -it gemini-sandbox-php
```
