# Contributing

Ideas for new skills and improvements to existing ones are welcome. Open an issue first for a new skill, so its definition can be agreed before it is written.

## What makes a skill fit here

1. It automates a process that repeats across projects.
2. It names no project, language or command: it reads them from the repository it runs in, and asks when a rule is missing.
3. It uses only the fields of the [Agent Skills specification](https://agentskills.io/specification) and passes the reference validator.
4. It ships with evals that pass in at least two different agents.
5. It never merges, approves, tags or pushes to a protected branch.

## Design principles

**Spend few tokens.**

- Keep `SKILL.md` short (aim for under 150 lines); move detail to `references/`, which the agent reads only when needed.
- Write a `description` that says exactly when to use the skill, so agents do not load it when it does not apply.
- Put repeatable, deterministic steps in `scripts/`: running a script costs less than reasoning through it every time.
- Read only what the task needs (the rules, the diff, the files it changes), and do not reread files.
- Keep replies to the user short: the result, the link and what is needed from them.

**Leave good code behind.** When the repository defines its own practices, those win. Otherwise a skill steers the agent to:

- Make the smallest change that solves the task, with no layers or configuration "just in case".
- Pick the simpler of two secure options; never trade security away.
- Write code that reads without comments; comment only a non-obvious why.
- Ship each change with its test, and start each fix with a test that reproduces the bug.
- Never skip, disable or delete a test to get green.
- Validate external input, and never log secrets or personal data.
- Make small commits, one change each, that keep the tests green.

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
