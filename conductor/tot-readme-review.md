# ToT Documentation Review Plan

## Objective
Systematically review and refine all 12 `README.md` files (1 root, 11 sandboxes) to ensure absolute alignment with the recent architectural refactoring.

## Tree of Thoughts Framework

### Dimension 1: Technical Accuracy (The "Truth" Check)
- **Hypothesis:** Does the documentation perfectly reflect the code?
- **Checks:**
  - Are we still mentioning Python 3.11 anywhere? It must be Python 3.13.
  - Are we mentioning Node.js 20? It must be Node.js 24.
  - Are there any lingering references to Homebrew (`brew`)?
  - Does the root README accurately describe the new `NAMESPACE` Makefile parameters?
  - Do the `Usage` commands reflect the parameterized `$(NAMESPACE)/$(IMAGE_PREFIX)-*` structure, or do they hardcode `gemini-python` vs `backendsouls/gemini-sandbox-python`?

### Dimension 2: Branding & Identity (The "Tone" Check)
- **Hypothesis:** Is the project identity clear and consistent?
- **Checks:**
  - Do all files correctly state "**Opinionated unofficial Gemini CLI sandbox**"?
  - Is the authorship/metadata pointing to "BackendSouls" rather than "Gemini CLI Team"?
  - Are the new tags (`backendsouls`, `python3.13-node24`) documented in the READMEs?

### Dimension 3: User Utility (The "Helpfulness" Check)
- **Hypothesis:** Can a new user immediately understand how to use the sandbox?
- **Checks:**
  - Are the extension descriptions clear?
  - Is the "Security & Isolation" section intact?
  - Is the new custom namespace (`DOCKER_NAMESPACE`) clearly explained for GitHub Actions?

## Execution Strategy
1. **Automated Discovery**: Use `grep_search` to hunt for known anti-patterns across all `README.md` files (e.g., "Python 3.11", "Node.js 20", "brew").
2. **Deep Reading**: Manually read the root `README.md` and a sample leaf `README.md` (like `sandboxes/all/README.md`) to evaluate layout and tone.
3. **Drafting Updates**: Apply fixes to any files failing the Dimension checks.
4. **Final Polish**: Ensure consistency across all 11 leaf sandboxes.