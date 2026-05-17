# AI Action & Decision Log

This log records significant actions, architectural decisions, and reasoning paths taken by the AI agent during the development and maintenance of this project.

---

## [2026-05-17] Security Hardening: Modular Egress Control

### Actions:
- **Network Hardening Utility**: Developed and implemented `harden-network` (located at `/usr/local/bin/harden-network`), a tool inspired by the `libops/cli-sandbox` security model.
- **Firewall Integration**: Pre-installed `iptables` in the `base` sandbox image to support kernel-level egress filtering.
- **Optional Security Mode**: Configured the environment to allow users/agents to toggle strict egress rules (`on`/`off`). In "on" mode, it restricts traffic to standard web ports (80/443) and DNS (53), blocking non-standard exfiltration attempts.
- **Documentation Update**: Synchronized all 11 sandbox `README.md` and `templates/GEMINI.md` files to instruct users and agents on how to leverage the new hardening utility.

### Decisions:
- **Decision**: Use "Infrastructure-only" hardening by default.
  - **Rationale**: While strict security is a priority, forced `iptables` at build time would break the polyglot development experience (NPM/Maven installs). Providing the utility and documentation enables "Enterprise Security" on-demand without sacrificing utility.
- **Decision**: Require `--cap-add=NET_ADMIN`.
  - **Rationale**: This is a standard Docker requirement for container-level firewall management. We prioritize kernel-level protection over user-space shims (like proxies) which are easier to bypass.

---

## [2026-05-17] Python 3.13 Upgrade & Registry Parameterization
... rest of file ...
