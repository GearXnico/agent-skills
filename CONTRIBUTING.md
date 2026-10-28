# Contributing

Ideas for new skills and improvements to existing ones are welcome. Open an issue first for a new skill, so its definition can be agreed before it is written.

## What makes a skill fit here

1. It automates a process that repeats across projects.
2. It names no project, language or command: it reads them from the repository it runs in, and asks when a rule is missing.
3. It uses only the fields of the [Agent Skills specification](https://agentskills.io/specification) and passes the reference validator.
4. It ships with evals that pass in at least two different agents.
5. It never merges, approves, tags or pushes to a protected branch.

## Layout of a skill

```
skills/<skill-name>/
  SKILL.md       when to use it, what it reads from the repository, the steps, what it never does
  references/    optional detail the agent reads only when needed
  evals/         3 to 5 cases: the request, the repository state and the expected behaviour
```

Keep `SKILL.md` under 500 lines. The `name` field matches the folder name.

## Workflow

- Branch from `dev` with a short lowercase name: `feature/`, `fix/`, `docs/` or `chore/`.
- Open the pull request against `dev`, not `main`. `main` is the default branch because it only holds released versions.
- Use [Conventional Commits](https://www.conventionalcommits.org/); each commit does one thing. Pull requests are merged with rebase & merge.
- Add your change under `## [Unreleased]` in `CHANGELOG.md`.
- In the pull request, say which agents you ran the evals in and the result.

## Check a skill locally

```bash
python -m venv .venv && . .venv/bin/activate
pip install skills-ref==0.1.1
agentskills validate skills/<skill-name>
```
