# Java Sandbox

This sandbox is optimized for Java development and testing across different versions.

## Included
- **Version Manager**: [SDKMAN!](https://sdkman.io/)
- **Default Language**: Java 17 (Temurin)
- **Build Tools**: Maven, Gradle
- **Scripting**: Python 3.11 (for Gemini usage)
- **Base Tools**: `jq`, `fzf`, `rg`, `fd`, `bat`

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
