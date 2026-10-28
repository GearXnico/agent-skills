# agent-skills

Portable skills for coding agents, written to the open [Agent Skills](https://agentskills.io/specification) standard. Each skill is a folder with a `SKILL.md` that any compatible agent can load: Claude Code, Codex, Cursor, Gemini CLI and others.

The skills hold no project names, languages or commands. They read the rules of the repository they run in (`AGENTS.md`, `CLAUDE.md`, `CONTRIBUTING.md`, the pull request template, the CI workflows) and ask when a rule is missing.

## Skills

No skills published yet. The first ones are on their way:

| Skill | What it does |
| --- | --- |
| `task-flow` | Branch, commits, checks, changelog and pull request, following the repository's own rules |
| `fix-with-test` | Reproduces a bug with a failing test before fixing it |
| `docs-sync` | Finds the docs a change left out of date and updates them |
| `new-adr` | Records a technical decision as a numbered ADR |
| `security-pass` | Reviews the diff for security issues before asking for review |
| `release` | Prepares a release: changelog, release branch and pull request |

## Install

Copy a skill folder to where your agent looks for skills.

| Agent | Project | User (all projects) |
| --- | --- | --- |
| Claude Code | `.claude/skills/` | `~/.claude/skills/` |
| Codex, Gemini CLI and other agents that read `.agents/` | `.agents/skills/` | `~/.agents/skills/` |

For example, to add `task-flow` to a project:

```bash
git clone --depth 1 https://github.com/GearXnico/agent-skills.git /tmp/agent-skills
mkdir -p .agents/skills
cp -r /tmp/agent-skills/skills/task-flow .agents/skills/
```

Install from `main`, which only holds released versions.

## How the skills are built

- Short and cheap to run: brief instructions, detail loaded only when needed, scripts for repeatable steps.
- They steer the agent to good practices (small changes, tests with every change, no skipped tests, simple and secure code) unless the repository sets its own.
- Only fields from the standard: `name`, `description`, `license` and `metadata`. No agent-specific fields, so every agent reads the same file.
- Every skill ships with `evals/`: the request, the repository state and the expected behaviour. They are run by hand in two different agents before a release.
- CI validates every skill with the reference validator on each pull request.
- A skill never merges, approves, tags or pushes to a protected branch.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). Changes are listed in [CHANGELOG.md](CHANGELOG.md).

## License

[MIT](LICENSE)
