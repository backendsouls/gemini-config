# Lua Sandbox

This sandbox is optimized for Lua development and includes Gemini-ready scripting capabilities.

## Included
- **Language**: Lua (via Homebrew)
- **Package Manager**: Luarocks
- **Base Tools**: `jq`, `fzf`, `rg`, `fd`, `bat`, `Gemini CLI`

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
```bash
docker build -t gemini-sandbox-lua .
docker run -it gemini-sandbox-lua
```
