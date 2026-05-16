# JavaScript Sandbox

This sandbox is optimized for JavaScript and TypeScript development across different Node.js versions.

## Included
- **Version Manager**: [NVM](https://github.com/nvm-sh/nvm)
- **Default Language**: Node.js 20 (LTS)
- **Languages**: TypeScript (global)
- **Scripting**: Python 3.11 (for Gemini usage)
- **Base Tools**: `jq`, `fzf`, `rg`, `fd`, `bat`

## Pre-installed Extensions
This sandbox comes with several pre-installed Gemini extensions:
- context7, superpowers, conductor, open-aware, code-review, security, and co-researcher.
You can list them using `gemini extensions list`.

## Security & Isolation
- **Host Independence**: The agent cannot access host paths outside the shared directory.
- **Strict Boundaries**: All tools and extensions are pre-installed in the image for total isolation.
- **WORKSPACE Support**: Respects the `WORKSPACE` environment variable for shared project roots.
- **Volume Guidance**: The agent will guide you on using `SANDBOX_MOUNTS` if more data is needed.

## Usage
NVM is pre-installed. To initialize it in a new shell:
```bash
source "$NVM_DIR/nvm.sh"
```

To build:
```bash
docker build -t gemini-sandbox-js .
docker run -it gemini-sandbox-js
```
