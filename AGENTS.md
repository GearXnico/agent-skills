# AGENTS.md

Guidance for coding agents working in this repository.

This repository publishes portable skills for coding agents, following the [Agent Skills specification](https://agentskills.io/specification). Each skill lives in `skills/<skill-name>/`.

## Rules for skills

- Only the specification's frontmatter fields: `name`, `description`, `license`, `metadata` (and `compatibility` when truly needed). No agent-specific fields.
- A skill names no project, language or command. It reads them from the repository it runs in and asks when a rule is missing.
- `SKILL.md` stays under 500 lines; detail goes in `references/`.
- Every skill has `evals/` with 3 to 5 cases.
- A skill never merges, approves, tags or pushes to a protected branch.
- Follow the design principles in `CONTRIBUTING.md`: spend few tokens and leave good code behind.

## Commands

```bash
pip install skills-ref==0.1.1
agentskills validate skills/<skill-name>
```

## Workflow

- Branch from `dev`: `feature/`, `fix/`, `docs/`, `chore/`, 2 to 4 lowercase words.
- Pull requests target `dev`; `main` only receives releases.
- Conventional Commits, one change per commit; merges use rebase & merge.
- Every change adds an entry under `## [Unreleased]` in `CHANGELOG.md`.
- Never push to, merge into or force-push `dev` or `main`.
- Everything in English.
