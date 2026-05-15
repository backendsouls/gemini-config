# Gemini CLI Extensions

The following Gemini CLI extensions are pre-installed in all sandbox environments to enhance the agent's capabilities in reasoning, orchestration, and code quality.

| Extension | Source | Description |
|-----------|--------|-------------|
| **context7** | [upstash/context7](https://github.com/upstash/context7) | Enhances context management and long-term memory awareness. |
| **superpowers** | [obra/superpowers](https://github.com/obra/superpowers) | Provides a suite of powerful utility tools for advanced agent actions. |
| **conductor** | [gemini-cli-extensions/conductor](https://github.com/gemini-cli-extensions/conductor) | Orchestrates complex workflows and manages sub-task delegation. |
| **open-aware** | [qodo-ai/open-aware](https://github.com/qodo-ai/open-aware) | Improves code awareness and understanding of project-wide symbols. |
| **code-review** | [gemini-cli-extensions/code-review](https://github.com/gemini-cli-extensions/code-review) | Specialized tools for automated code quality analysis and reviews. |

## Usage

These extensions are automatically loaded when you start Gemini in a sandbox. You can list them and see their available tools using:

```bash
gemini extensions list
```
