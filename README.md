# Gemini CLI Sandbox Environments

This repository contains various Docker-based sandbox environments for Gemini CLI tasks. Each sandbox is equipped with Homebrew for package management and common development tools.

## Sandbox Variants

| Sandbox | Description | Key Tools |
|---|-|---|
| [Base](./sandboxes/base) | Essential tools only | `jq`, `fzf`, `ripgrep (rg)`, `fd`, `bat`, `vim`, `sed` |
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

## Usage with Gemini CLI

You can use these sandboxes directly with the Gemini CLI by setting the following environment variables:

```bash
export GEMINI_SANDBOX=docker
export GEMINI_SANDBOX_IMAGE=gemini-sandbox-all

# Optional: Set a dedicated workspace directory to share with the sandbox
export WORKSPACE=/path/to/your/projects

# Optional: Share additional host directories as volumes
export SANDBOX_MOUNTS="/host/data:/container/data:ro"

gemini -s
```

Replace `gemini-sandbox-all` with any other specific language image (e.g., `gemini-sandbox-python`) as needed.

See [EXTENSIONS.md](./EXTENSIONS.md) for details on pre-installed Gemini extensions.

## Security & Isolation

1. **Host Independence**: The agent is strictly prohibited from accessing or requesting host paths outside the mounted volumes.
2. **Strict Boundaries**: All tools (Node, NPM, Python, etc.) are pre-installed in the image to ensure total isolation from host runtimes.
3. **Volume-Based Access**: If additional data is needed, the agent will guide you on how to share it using `SANDBOX_MOUNTS` instead of accessing it directly.
4. **WORKSPACE Environment Variable**: Use this to define the root of your shared projects. The agent uses this as its primary operational context.

## CI/CD (GitHub Actions)

A GitHub Actions workflow is provided in `.github/workflows/docker-build-push.yml` to automatically build and push images to Docker Hub on every push to the `main` branch.

### Prerequisites
To use this workflow, you must set the following secrets in your GitHub repository:
- `DOCKER_USERNAME`: Your Docker Hub username.
- `DOCKER_PASSWORD`: Your Docker Hub personal access token (PAT).

The workflow builds the `base` image first and then builds all language-specific images in parallel, using the freshly built base image.

## Design Philosophy

1. **Isolation**: Each environment is self-contained.
2. **Consistency**: Homebrew ensures tools are the same across sandboxes.
3. **Gemini Ready**: Python is included in all language sandboxes to support Gemini-driven scripting and automation.
