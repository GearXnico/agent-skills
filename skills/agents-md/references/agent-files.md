# Agent instruction files

Which file each agent reads, and what to offer when it is not `AGENTS.md`. Agents change quickly: check the agent's own documentation before offering a bridge, and drop a row once the agent reads `AGENTS.md` directly.

| Agent | Reads | Bridge to offer |
| --- | --- | --- |
| Codex, Cursor, and other agents that follow the AGENTS.md convention | `AGENTS.md` | None |
| Claude Code | `CLAUDE.md` | `CLAUDE.md` containing only `@AGENTS.md`, which imports it |
| Gemini CLI | `GEMINI.md` by default | Set the context file name to `AGENTS.md` in the project's Gemini settings, or a `GEMINI.md` that points to `AGENTS.md` |
| GitHub Copilot | `.github/copilot-instructions.md`, and `AGENTS.md` in newer versions | A short `.github/copilot-instructions.md` that points to `AGENTS.md`, only if the team's version does not read it |

When you offer a bridge, say in one or two sentences:

- Which agent needs it and why: without it, that agent starts without the project's rules.
- Why a bridge and not a copy: one source of truth, so the rules cannot drift apart between agents.
