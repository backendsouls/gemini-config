# AI Action & Decision Log

This log records significant actions, architectural decisions, and reasoning paths taken by the AI agent during the development and maintenance of this project.

---

## [2026-05-17] Enhanced Metadata & Professional Documentation

### Actions:
- **CI/CD Modernization**: Upgraded all GitHub Actions in `.github/workflows/docker-build-push.yml` to their latest versions to address Node.js 20 deprecation.
- **Rich Docker Metadata**: Integrated `docker/metadata-action@v6` to automatically generate dynamic tags (branch, sha, PR, latest) and OCI labels for all images.
- **Meaningful Documentation**:
    - Enriched all 11 sandbox `README.md` files with detailed extension descriptions and a "Best Practices" section.
    - Standardized `templates/GEMINI.md` to provide the same level of detailed guidance to agents running inside the containers.
    - Added image metadata (OS, Architecture, Repository link) to all READMEs.
- **Refined Docker Hub Descriptions**: Updated the CI/CD pipeline to push specific, informative "Short Descriptions" for each image variant.

### Decisions:
- **Decision**: Use `docker/metadata-action`.
  - **Rationale**: It's the industry standard for managing Docker tags and labels in GitHub Actions, ensuring consistent and meaningful versioning.
- **Decision**: Align internal and external documentation.
  - **Rationale**: Ensuring that both the user (reading the README) and the agent (reading `GEMINI.md`) have the same high-quality context leads to better collaboration and more efficient use of the sandbox.

---

## [2026-05-17] Major Size Optimization: The "Death of Brew"
... rest of file ...
