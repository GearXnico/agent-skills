# agent-skills

Portable skills for coding agents, written to the open [Agent Skills](https://agentskills.io/specification) standard. Each skill is a folder with a `SKILL.md` that any compatible agent can load: Claude Code, Codex, Cursor, Gemini CLI and others.

The skills hold no project names, languages or commands. They read the rules of the repository they run in (`AGENTS.md`, `CLAUDE.md`, `CONTRIBUTING.md`, the pull request template, the CI workflows) and ask when a rule is missing.

## Skills

| Skill | What it does | Status |
| --- | --- | --- |
| [`task-flow`](skills/task-flow/SKILL.md) | Branch, commits, checks, changelog and pull request, following the repository's own rules | Available |
| [`fix-with-test`](skills/fix-with-test/SKILL.md) | Reproduces a bug with a failing test before fixing it | Available |
| [`docs-sync`](skills/docs-sync/SKILL.md) | Finds the docs a change left out of date and updates them | Available |
| [`new-adr`](skills/new-adr/SKILL.md) | Records a technical decision as a numbered ADR in the repository's own format, and marks the one it replaces as superseded | Available |
| [`security-pass`](skills/security-pass/SKILL.md) | Reviews a change for security issues before review, following each new input to where it is used, with the repository's scanners or a temporary run | Available |
| `release` | Prepares a release: changelog, release branch and pull request | Planned |
| [`architecture-review`](skills/architecture-review/SKILL.md) | Maps a system or a proposal and reports ranked risks, with evidence and the smallest fix | Available |
| [`design-doc`](skills/design-doc/SKILL.md) | Turns a request into a short technical design and a plan of small pull requests | Available |
| [`agents-md`](skills/agents-md/SKILL.md) | Creates or updates AGENTS.md from verified facts, including the git workflow the other skills read | Available |
| [`dependency-update`](skills/dependency-update/SKILL.md) | Updates dependencies in small, checked steps: security first, majors one at a time | Available |
| [`package-manager`](skills/package-manager/SKILL.md) | Switches or adopts a package manager, keeping every dependency version | Available |
| [`pr-review`](skills/pr-review/SKILL.md) | Reviews a pull request against the repository's rules, including code outside the diff it can break | Available |
| [`incident-postmortem`](skills/incident-postmortem/SKILL.md) | Writes a blameless postmortem: sourced timeline, trigger and latent causes, impact, and a fix recommendation per finding | Available |

## Install

Clone this repository once, then run the installer from the root of your project:

```bash
git clone --depth 1 https://github.com/GearXnico/agent-skills.git ~/agent-skills
cd your-project
~/agent-skills/install.sh                        # every skill, into .agents/skills/
~/agent-skills/install.sh task-flow pr-review    # only these skills
~/agent-skills/install.sh --claude               # into .claude/skills/ for Claude Code
~/agent-skills/install.sh --update task-flow     # replace an installed skill with the new version
```

The installer only copies folders: it skips skills that are already installed unless you pass `--update`, and it never runs the skills or edits other files. Then ask your agent to run `agents-md`, which writes the rules the installed skills read into `AGENTS.md`.

To install by hand, copy a skill folder to where your agent looks for skills:

| Agent | Project | User (all projects) |
| --- | --- | --- |
| Claude Code | `.claude/skills/` | `~/.claude/skills/` |
| Codex, Gemini CLI and other agents that read `.agents/` | `.agents/skills/` | `~/.agents/skills/` |

Install from `main`, which only holds released versions.

## Configure

The skills read your workflow from a `## Git workflow` section in `AGENTS.md`: base branch, branch names, commit format, checks, changelog, how to update branches after a merge, and whether to ask before pushing. Copy [the template](skills/task-flow/references/workflow-section.md) and fill it in. If a rule is missing, the skill asks once and offers to write it down.

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
