# package-manager evals

Run each case on the branch named in it, from [agent-skills-sandbox](https://github.com/GearXnico/agent-skills-sandbox), in at least two agents. Start from a fresh clone on a `chore/` branch, with the skill installed. A case passes when the agent does everything under "Expected" and nothing under "Must not".

## 1. Migrate Poetry to uv

- **Branch:** `python-poetry` (Poetry project with a lockfile, CI, a Dockerfile, README and `AGENTS.md` that name Poetry commands).
- **Request:** "Move this project from Poetry to uv."
- **Expected:** lists the files to change and asks before changing them; after approval, `pyproject.toml` uses `[project]` and `[dependency-groups]`, `uv.lock` exists and `poetry.lock` is gone; the resolved `click` and `pytest` versions match the old lockfile or the changes are listed; CI, Dockerfile, README and the `Checks` rule in `AGENTS.md` use `uv`; `uv run pytest -q` passes; small commits.
- **Must not:** leave `poetry.lock` or `[tool.poetry]` behind; write `uv.lock` by hand; upgrade a dependency without saying so.

## 2. Adopt a manager

- **Branch:** `python-pip` (loose `requirements.txt`, no lockfile).
- **Request:** "Set up a package manager for this project."
- **Expected:** compares two or three managers in a table against this project and recommends one with reasons; asks before changing anything; after approval, pins each package to the version currently resolved and separates `pytest` as a development dependency.
- **Must not:** pick a manager and apply it without asking; upgrade packages while adopting.

## 3. Migrate npm to pnpm

- **Branch:** `deps` (npm with `package-lock.json`).
- **Request:** "Switch us to pnpm."
- **Expected:** builds `pnpm-lock.yaml` from the existing lockfile (`pnpm import`) so versions are kept; sets `packageManager` in `package.json`; removes `package-lock.json`; updates the `Checks` rule if it named npm; `pnpm test` passes.
- **Must not:** keep both lockfiles; upgrade `lodash` or `chalk` as part of the switch.

## 4. Unsupported ecosystem

- **Request:** "Move this Go project from vendoring to modules" in any repository.
- **Expected:** says the ecosystem is not covered yet and points to the to-do list.
- **Must not:** attempt the migration.

## Results

Record each run in the pull request that changes the skill:

| Case | Agent | Result | Notes |
| --- | --- | --- | --- |
