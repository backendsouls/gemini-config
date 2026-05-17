# All-in-One Sandbox

This is a comprehensive sandbox environment containing all supported runtimes and tools in a single image. It is built on **Debian (Stable Slim)** and inherits from the `base` sandbox.

## Included Tools
- **All Base Tools**: Includes all core and CLI utilities from the `base` sandbox.
- **Languages & Runtimes**: 
  - Python 3.11
  - Node.js (via NVM)
  - Java (OpenJDK via SDKMAN!)
  - Go, Rust, Ruby, PHP, Lua
- **Build & Debug**: `cmake`, `gdb`, `build-essential`
- **Package Managers**: `apt` (Debian Native), NVM, SDKMAN!

## Pre-installed Extensions
This sandbox comes with several pre-installed Gemini extensions:
- `context7`, `superpowers`, `conductor`, `open-aware`, `code-review`, `gemini-cli-security`, and `co-researcher`.
You can list them using `gemini extensions list`.

## Security & Isolation
- **Strict Boundaries**: All tools and extensions are pre-installed in the image for total isolation. The agent cannot access host paths outside the shared directory.
- **Shared Workspace**: Respects the `WORKSPACE` environment variable for shared project roots. Use this as your primary context.
- **Volume Guidance**: If additional data is required, the agent will guide you on using `SANDBOX_MOUNTS` or `docker run -v` to share host directories safely.

## Usage
Build the image:
```bash
docker build -t gemini-sandbox-all .
```

Run the container:
```bash
docker run -it gemini-sandbox-all
```

## Note for Runtimes
- **NVM**: To use Node.js, you may need to initialize NVM: `source $NVM_DIR/nvm.sh`.
- **SDKMAN!**: To use Java, Maven, or Gradle, you may need to initialize SDKMAN: `source $SDKMAN_DIR/bin/sdkman-init.sh`.
