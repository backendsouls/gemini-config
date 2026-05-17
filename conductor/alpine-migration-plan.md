# Alpine Migration & Size Optimization Plan

## Objective
Drastically reduce the storage footprint of all Gemini CLI sandbox images by migrating to an Alpine Linux base, aggressively clearing caches, and omitting heavy compilation toolchains.

## Architectural Shifts

### 1. Base OS & Package Manager
- **Current:** Debian (Stable Slim) + Homebrew + APT
- **New:** Alpine Linux (3.20) + APK
- **Impact:** Homebrew is incompatible with Alpine's `musl` libc. All `brew install` commands will be replaced with `apk add --no-cache`. The root `GEMINI.md` and all READMEs must be updated to reflect this major change.

### 2. Dependency Translation (APT -> APK)
- `build-essential` -> **REMOVED** (per user request)
- `dnsutils` -> `bind-tools`
- `fd-find` -> `fd`
- `python3-pip` -> `py3-pip`
- `procps` -> `procps` (required for `ps` command)

### 3. Glibc Compatibility for Runtimes
- NVM and SDKMAN! download pre-compiled binaries that expect `glibc`.
- **Mitigation:** We must install `gcompat` and `bash` via `apk` to allow these tools and their downloaded runtimes (Node.js, Java) to function within Alpine.

## Implementation Steps

### Phase 1: Base Sandbox Refactor
1. Update `sandboxes/base/Dockerfile`:
   - Change builder to `node:20-alpine`.
   - Add `.git` cleanup to the `extension-builder` stage: `find /build -name ".git" -type d -exec rm -rf {} +`.
   - Change final stage to `alpine:3.20`.
   - Replace `apt-get` with `apk add --no-cache` using translated packages. Include `gcompat` and `bash`.
   - Replace `useradd` with Alpine's `adduser -D -s /bin/bash gemini`.
   - Remove Homebrew installation entirely.
   - Add `npm cache clean --force` after global NPM installs.
2. Update `sandboxes/base/templates/GEMINI.md` to indicate `apk` as the package manager.

### Phase 2: Setup Script Optimization
1. Update `sandboxes/all/scripts/setup.sh`:
   - Append `nvm cache clear` and `sdk flush archives && sdk flush temp`.
2. Update `sandboxes/javascript/scripts/setup.sh` and `sandboxes/java/scripts/setup.sh` with the same cache clearing commands.

### Phase 3: Leaf Sandbox Refactor
1. Update `sandboxes/all/Dockerfile`:
   - Replace `brew install go rust ruby php lua cmake gdb` with `apk add --no-cache go rust cargo ruby php lua cmake gdb`.
2. Update `sandboxes/cpp/Dockerfile`:
   - While compilation tools were requested to be removed globally, the `cpp` sandbox inherently requires them. We will use `apk add --no-cache alpine-sdk cmake gdb` specifically for this sandbox.
3. Update all other language Dockerfiles to use `apk` if they install additional system packages.

### Phase 4: Documentation Synchronization
1. Update all 11 `README.md` files:
   - Change OS reference to Alpine Linux.
   - Update tools list (remove build-essential/gcc, change package manager to APK).
2. Update all `templates/GEMINI.md` files similarly.
3. Add a log entry to `AI_LOG.md`.

## Verification
- Build the base image and verify extensions load.
- Build the all-in-one image and verify `nvm` and `sdk` binaries execute correctly under `gcompat`.