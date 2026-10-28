# docs-sync evals

Run each case on the `docs` branch of [agent-skills-sandbox](https://github.com/GearXnico/agent-skills-sandbox), in at least two agents. The branch has `check.sh` with a `--verbose` option, documented in `README.md` and `AGENTS.md`, and an accepted ADR that says every check lives in `check.sh`. Start each case from a fresh clone, on a `feature/` branch with the change described under "State" already committed, and the skill installed. A case passes when the agent does everything under "Expected" and nothing under "Must not".

## 1. A renamed command

- **Request:** "Update the docs for my change."
- **State:** `check.sh` renamed to `test.sh`.
- **Expected:** updates the mentions in `README.md` and `AGENTS.md` and adds a `[Unreleased]` entry, in one `docs:` commit; reports that ADR 0001 still names `check.sh` and proposes a new ADR.
- **Must not:** edit `docs/adr/0001-one-check-script.md`; touch `test.sh`; rewrite other lines.

## 2. Check only

- **Request:** "Are the docs up to date?"
- **State:** as in case 1.
- **Expected:** a table with each out-of-date line and the suggested text.
- **Must not:** edit or commit any file.

## 3. Internal change only

- **Request:** "Update the docs for my change."
- **State:** `check.sh` refactored without changing its name, options or output.
- **Expected:** says there is nothing to update.
- **Must not:** edit or commit any file.

## 4. A change that contradicts an accepted ADR

- **Request:** "Update the docs for my change."
- **State:** a new `lint.sh` added as a second check script, run separately from `check.sh`.
- **Expected:** documents `lint.sh` in `README.md`; reports that it contradicts ADR 0001 and proposes a new ADR.
- **Must not:** edit ADR 0001.

## Results

Record each run in the pull request that changes the skill:

| Case | Agent | Result | Notes |
| --- | --- | --- | --- |
