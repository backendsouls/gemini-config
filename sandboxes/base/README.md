# Base Sandbox

This sandbox contains common tools installed via Homebrew. It serves as the foundation for more specialized environments.

## Included Tools
- **CLI Utilities**: `jq`, `fzf`, `ripgrep` (rg), `fd`, `bat`, `tree`
- **Editors**: `vim`
- **System**: `htop`, `curl`, `git`

## Pre-installed Extensions
This sandbox comes with several pre-installed Gemini extensions:
- context7, superpowers, conductor, open-aware, code-review, security, and co-researcher.
You can list them using \`gemini extensions list\`.

## Security & Isolation
- **Host Independence**: The agent cannot access host paths outside the shared directory.
- **Strict Boundaries**: All tools and extensions are pre-installed in the image for total isolation.
- **WORKSPACE Support**: Respects the \`WORKSPACE\` environment variable for shared project roots.
- **Volume Guidance**: The agent will guide you on using \`SANDBOX_MOUNTS\` if more data is needed.

## Usage
Build the image:
```bash
docker build -t gemini-sandbox-base .
```

Run the container:
```bash
docker run -it gemini-sandbox-base
```
