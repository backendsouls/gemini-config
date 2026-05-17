# Rust Sandbox

This sandbox provides a specialized environment for Rust development within the Gemini CLI. It inherits from the Debian-based `gemini-sandbox-base`.

## Included Tools
- **Runtimes**: Rust, Cargo (latest via Brew)
- **Base Utilities**: `jq`, `fzf`, `ripgrep` (rg), `fd`, `bat`, `tree`, `vim`, `htop`, `curl`, `git`

## Security & Isolation
- **Strict Boundaries**: You MUST NOT attempt to access or read any host directories directly using absolute paths. 
- **Shared Workspace**: You are strictly confined to the currently shared directory (typically mounted at `/home/gemini/workspace`).
- **Volume Guidance**: If you need more data, provide the user with an `export SANDBOX_MOUNTS` example. Do not ask for direct access.
- **WORKSPACE Variable**: Respect the `WORKSPACE` environment variable if set by the user for shared project roots.

## Usage
Build the image:
```bash
make rust
```

Run the container:
```bash
docker run -it gemini-sandbox-rust
```

## Instructions for Gemini
1. Use 'gemini extensions list' to see available extensions and their skills.
2. Use 'cargo install <crate>' or 'sudo apt-get install <package>' for additional tools.
3. Prefer Python 3.11 for automation scripts even within this Rust environment.
