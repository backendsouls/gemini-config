# Performance & Size Optimization Plan (Debian + Native Tools)

## Objective
Reduce the 'all-in-one' sandbox image from ~10GB to <2GB by eliminating Homebrew and migrating to native package management (`apt`) and official minimal installers.

## The Problem
Analysis shows that **Homebrew (`/home/linuxbrew/.linuxbrew`) consumes 4.6GB**, nearly half of the entire image. This is due to Brew's heavy dependency isolation (often building its own `gcc`, `glibc`, and core libraries) and its large internal git repository.

## Architectural Shifts

### 1. Remove Homebrew Entirely
- **Impact:** Immediate ~5GB saving.
- **Replacement:** Use `apt-get` for system tools and official minimal installers for language runtimes.

### 2. Native Tooling Replacement
- **Go:** Official tarball from `golang.org`.
- **Rust:** `rustup` (minimal profile).
- **Ruby/PHP/Lua:** Native `apt` packages.
- **CMake/GDB:** Native `apt` packages.

### 3. Build-Time Multi-Staging
- Use temporary build stages for installing runtimes and copy only the final binaries/folders to the production image.

## Implementation Steps

### Phase 1: Base Sandbox Refactor
1. **Update `sandboxes/base/Dockerfile`**:
   - **REMOVE** Homebrew installation section.
   - **ADD** `yq` and `htmlq` via direct binary downloads (GitHub releases) instead of Brew.
   - **PURGE** `apt` caches aggressively: `rm -rf /var/lib/apt/lists/*` in every `RUN` block.
   - **REMOVE** `build-essential` (gcc, g++, make) in the final stage to save ~250MB (as per previous request).

### Phase 2: Setup Script Refactor (All-in-One)
1. **Update `sandboxes/all/scripts/setup.sh`**:
   - **Go:** Download tarball, extract to `/usr/local/go`, and add to PATH.
   - **Rust:** Install via `rustup` with `--profile minimal`.
   - **Cleanup:** Ensure all temporary installers and tarballs are removed.

### Phase 3: Leaf Sandbox Updates
1. Update `sandboxes/all/Dockerfile`:
   - Replace `brew install` with `apt-get install -y go-rust-ruby-etc` or the new setup scripts.
2. Update all other language-specific Dockerfiles to use `apt-get` for any missing tools.

### Phase 4: Documentation Synchronization
1. Update `README.md` files:
   - Remove references to Homebrew.
   - Update the "Package Manager" section to prioritize `apt`.
2. Update `templates/GEMINI.md` similarly.

## Size Targets
- **Base Image:** ~800MB (down from ~2GB)
- **All-in-One Image:** ~1.5GB - 2GB (down from 10GB)
