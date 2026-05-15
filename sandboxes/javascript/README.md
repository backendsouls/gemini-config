# JavaScript Sandbox

This sandbox is optimized for JavaScript and TypeScript development across different Node.js versions.

## Included
- **Version Manager**: [NVM](https://github.com/nvm-sh/nvm)
- **Default Language**: Node.js 20 (LTS)
- **Languages**: TypeScript (global)
- **Scripting**: Python 3.11 (for Gemini usage)
- **Base Tools**: `jq`, `fzf`, `rg`, `fd`, `bat`

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
