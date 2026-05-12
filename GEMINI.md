# Gemini CLI Sandbox Environment Instructions

This workspace is designed to manage and build various Docker-based sandbox environments. 

## Sandbox Architecture
- **Location**: All sandboxes are located in the `sandboxes/` directory.
- **Architecture**: A hierarchical Docker structure is used. All language sandboxes inherit from `sandboxes/base`.
- **Base Image**: The `base` sandbox is built on Ubuntu 22.04.
- **Package Manager**: **Homebrew (`brew`)** is the primary package manager. 
- **User**: The default user in all sandboxes is `gemini` with `sudo` access.

## Available Tools (Pre-installed via Brew/Apt)
When working within these sandboxes, you have access to:
- **Compilers**: `build-essential` (gcc, g++, make), `cmake`, `gdb`
- **Text Processing**: `jq`, `yq`, `htmlq`, `sed`, `wc`
- **Quality & Docs**: `shellcheck`, `tldr`
- **Fuzzy Finding**: `fzf`
- **Searching**: `ripgrep` (`rg`), `fd`
- **Viewing**: `bat`, `tree`
- **Networking**: `curl`, `wget`, `dig`
- **Monitoring**: `htop`
- **Editing**: `vim`
- **Scripting**: **Python 3.11** is guaranteed to be available in all language-specific sandboxes to support your automation tasks.

## Build System
A `Makefile` is available in the root directory to manage builds:
- `make build-all`: Builds all sandbox images.
- `make <language>`: Builds a specific language sandbox (e.g., `make rust`, `make python`).
- `make all-in-one`: Builds the comprehensive `gemini-sandbox-all` image.

## Instructions for Gemini
1. **Tool Discovery**: If you need a tool that isn't installed, check if it's available via `brew`.
2. **Scripting**: Prefer Python 3.11 for complex logic or automation tasks within the sandboxes.
3. **Environment**: When executing commands, assume the paths for Homebrew (`/home/linuxbrew/.linuxbrew/bin`) are already in the `PATH`.
4. **Context**: Each sandbox directory contains a `README.md` with specific details about that environment's language and configuration.
