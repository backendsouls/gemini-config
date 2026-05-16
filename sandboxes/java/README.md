# Java Sandbox

This sandbox is optimized for Java development and testing across different versions.

## Included
- **Version Manager**: [SDKMAN!](https://sdkman.io/)
- **Default Language**: Java 17 (Temurin)
- **Build Tools**: Maven, Gradle
- **Scripting**: Python 3.11 (for Gemini usage)
- **Base Tools**: `jq`, `fzf`, `rg`, `fd`, `bat`

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
SDKMAN is pre-installed. To initialize it in a new shell:
```bash
source "$SDKMAN_DIR/bin/sdkman-init.sh"
```

To build:
```bash
docker build -t gemini-sandbox-java .
docker run -it gemini-sandbox-java
```
