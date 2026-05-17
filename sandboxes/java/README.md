# Java Sandbox

A specialized environment for Java development, built on **Debian (Stable Slim)** and inheriting from the `base` sandbox. It uses SDKMAN! for managing JDKs and build tools.

## Included Tools
- **Java Development**: Java (OpenJDK via SDKMAN!), Maven, Gradle
- **Base Utilities**: Includes all core and CLI utilities from the `base` sandbox (e.g., `ripgrep`, `fd`, `jq`, `bat`).
- **Package Managers**: Homebrew (`brew`), SDKMAN!

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
docker build -t gemini-sandbox-java .
```

Run the container:
```bash
docker run -it gemini-sandbox-java
```

## Note for Runtimes
- **SDKMAN!**: To use Java, Maven, or Gradle, you may need to initialize SDKMAN in your shell: `source $SDKMAN_DIR/bin/sdkman-init.sh`.
