# Gemini CLI Sandbox Environments

This repository contains various Docker-based sandbox environments for Gemini CLI tasks. Each sandbox is equipped with native package management and common development tools.

## Sandbox Variants

| Sandbox | Description | Key Tools |
|---|-|---|
| [Base](./sandboxes/base) | Essential tools only | `jq`, `fzf`, `ripgrep (rg)`, `fd`, `bat`, `vim`, `sed`, `yq`, `htmlq` |
| [Python](./sandboxes/python) | Python optimized | Python 3.13, Base Tools |
| [JavaScript](./sandboxes/javascript) | JS/TS optimized | Node.js (NVM), TypeScript, Python 3.13 |
| [Go](./sandboxes/go) | Go optimized | Go (Native), Python 3.13, Base Tools |
| [Rust](./sandboxes/rust) | Rust optimized | Rust (Minimal), Python 3.13, Base Tools |
| [Ruby](./sandboxes/ruby) | Ruby optimized | Ruby (Native), Python 3.13, Base Tools |
| [Java](./sandboxes/java) | Java optimized | Java (SDKMAN), Maven, Gradle, Python 3.13 |
| [PHP](./sandboxes/php) | PHP optimized | PHP (Native), Python 3.13, Base Tools |
| [Lua](./sandboxes/lua) | Lua optimized | Lua (Native), Python 3.13 |
| [C/C++](./sandboxes/cpp) | C/C++ optimized | build-essential, CMake, GDB, Python 3.13 |
| [All](./sandboxes/all) | Everything included | All of the above |

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/)

## Getting Started

You can build the sandboxes using the provided `Makefile` or manually via Docker.

### Using Make (Recommended)

Build a specific sandbox (default namespace: `backendsouls`):
```bash
make python
```

Build for a custom namespace:
```bash
make python NAMESPACE=my-custom-org
```

Build and push all sandboxes:
```bash
make build-all NAMESPACE=my-custom-org
make push-all NAMESPACE=my-custom-org
```

Build all sandboxes:
```bash
make build-all
```

### Manual Build
To use a sandbox, navigate to its directory and build the Docker image:

```bash
cd sandboxes/python
docker build -t backendsouls/gemini-sandbox-python .
docker run -it backendsouls/gemini-sandbox-python
```

## Package Management

All sandboxes use **APT** (`apt-get`) as the primary package manager. This allows for consistent and reliable tool installations across environments.

Example of installing a new tool inside a running container:
```bash
sudo apt-get update && sudo apt-get install <package>
```

## Image Tagging

All images on the main branch are automatically tagged with:
- `latest`: The most recent stable build.
- `backendsouls`: A stable alias for the BackendSouls team.
- `python3.13-node24`: Denotes the core runtime versions pre-installed.
- `sha-<short-sha>`: Pinned version based on the Git commit.

## Usage with Gemini CLI

You can use these sandboxes directly with the Gemini CLI by setting the following environment variables:

```bash
export GEMINI_SANDBOX=docker
export GEMINI_SANDBOX_IMAGE=backendsouls/gemini-sandbox-all

# Optional: Set a dedicated workspace directory to share with the sandbox
export WORKSPACE=/path/to/your/projects

# Optional: Share additional host directories as volumes
export SANDBOX_MOUNTS="/host/data:/container/data:ro"

gemini -s
```

Replace `backendsouls/gemini-sandbox-all` with any other specific language image (e.g., `backendsouls/gemini-sandbox-python`) as needed.

See [EXTENSIONS.md](./EXTENSIONS.md) for details on pre-installed Gemini extensions.

## Security & Isolation

1. **Host Independence**: The agent is strictly prohibited from accessing or requesting host paths outside the mounted volumes.
2. **Strict Boundaries**: All tools (Node, NPM, Python, etc.) are pre-installed in the image to ensure total isolation from host runtimes.
3. **Volume-Based Access**: If additional data is needed, the agent will guide you on how to share it using `SANDBOX_MOUNTS` instead of accessing it directly.
4. **WORKSPACE Environment Variable**: Use this to define the root of your shared projects. The agent uses this as its primary operational context.

## Network Hardening

Inspired by the [libops/cli-sandbox](https://github.com/libops/cli-sandbox) security model, these sandboxes include a modular network hardening utility to prevent data exfiltration.

### The `harden-network` Utility
You or the AI agent can toggle a strict Zero-Trust egress policy using the pre-installed `harden-network` tool.

- **Enable Hardening**: `sudo harden-network on`
  - Restricts all outbound traffic to only standard web ports (**80/443**) and **DNS (53)**.
  - Blocks all non-standard ports commonly used for data exfiltration or reverse shells.
- **Disable Hardening**: `sudo harden-network off`
  - Restores default unrestricted outbound access for complex development tasks.

### Requirements
To use this feature, the container must be started with the `NET_ADMIN` capability:

```bash
docker run --cap-add=NET_ADMIN -it backendsouls/gemini-sandbox-all
```

When using with Gemini CLI, you can add this to your environment:
```bash
export SANDBOX_FLAGS="--cap-add=NET_ADMIN"
```

## CI/CD (GitHub Actions)

A GitHub Actions workflow is provided in `.github/workflows/docker-build-push.yml` to automate Docker image builds.

### Prerequisites
To use this workflow, you must set the following secrets in your GitHub repository:
- `DOCKER_USERNAME`: Your Docker Hub username.
- `DOCKER_TOKEN`: A Docker Hub **Personal Access Token (PAT)**.

**Note**: It is highly recommended to use a PAT instead of your account password for security. You can generate one in your [Docker Hub Account Settings](https://hub.docker.com/settings/security).

### Customization
By default, images are pushed to the namespace associated with your `DOCKER_USERNAME`. You can change the target namespace (e.g., to an organization) by setting the `DOCKER_NAMESPACE` repository variable in your GitHub settings.

The workflow builds the `base` image first and then builds all language-specific images in parallel, using the freshly built base image.

## Design Philosophy

1. **Isolation**: Each environment is self-contained.
2. **Efficiency**: Native package management and minimal installers ensure small image sizes and fast build times.
3. **Gemini Ready**: Python is included in all language sandboxes to support Gemini-driven scripting and automation.
