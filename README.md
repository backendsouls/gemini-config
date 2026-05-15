# Gemini CLI Sandbox Environments

This repository contains various Docker-based sandbox environments for Gemini CLI tasks. Each sandbox is equipped with Homebrew for package management and common development tools.

This project is vibe coded :)

## Sandbox Variants

| Sandbox | Description | Key Tools |
|---|-|---|
| [Base](./sandboxes/base) | Essential tools only | `jq`, `fzf`, `rg`, `fd`, `bat`, `vim` |
| [Python](./sandboxes/python) | Python optimized | Python 3.11, Base Tools |
| [JavaScript](./sandboxes/javascript) | JS/TS optimized | Node.js (NVM), TypeScript, Python 3.11 |
| [Go](./sandboxes/go) | Go optimized | Go, Python 3.11, Base Tools |
| [Rust](./sandboxes/rust) | Rust optimized | Rust, Python 3.11, Base Tools |
| [Ruby](./sandboxes/ruby) | Ruby optimized | Ruby, Python 3.11, Base Tools |
| [Java](./sandboxes/java) | Java optimized | Java (SDKMAN), Maven, Gradle, Python 3.11 |
| [PHP](./sandboxes/php) | PHP optimized | PHP, Python 3.11, Base Tools |
| [Lua](./sandboxes/lua) | Lua optimized | Lua, Luarocks, Python 3.11 |
| [C/C++](./sandboxes/cpp) | C/C++ optimized | build-essential, CMake, GDB, Python 3.11 |
| [All](./sandboxes/all) | Everything included | All of the above |

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/)

## Getting Started

You can build the sandboxes using the provided `Makefile` or manually via Docker.

### Using Make (Recommended)

Build a specific sandbox:
```bash
make python
```

Build all sandboxes:
```bash
make build-all
```

### Manual Build
To use a sandbox, navigate to its directory and build the Docker image:

```bash
cd sandboxes/python
docker build -t gemini-python .
docker run -it gemini-python
```

## Package Management

All sandboxes use **Homebrew** (`brew`) as the primary package manager. This allows for consistent and up-to-date tool installations across environments.

Example of installing a new tool inside a running container:
```bash
brew install htop
```

## Design Philosophy

1. **Isolation**: Each environment is self-contained.
2. **Consistency**: Homebrew ensures tools are the same across sandboxes.
3. **Gemini Ready**: Python is included in all language sandboxes to support Gemini-driven scripting and automation.
