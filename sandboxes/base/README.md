# Base Sandbox

This sandbox contains common tools installed via Homebrew. It serves as the foundation for more specialized environments.

## Included Tools
- **CLI Utilities**: `jq`, `fzf`, `ripgrep` (rg), `fd`, `bat`, `tree`
- **Editors**: `vim`
- **System**: `htop`, `curl`, `git`

## Usage
Build the image:
```bash
docker build -t gemini-sandbox-base .
```

Run the container:
```bash
docker run -it gemini-sandbox-base
```
