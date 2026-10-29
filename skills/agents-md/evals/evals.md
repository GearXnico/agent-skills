# agents-md evals

Run each case on the branch named in the case, from [agent-skills-sandbox](https://github.com/GearXnico/agent-skills-sandbox), in at least two agents. Start each case from a fresh clone with the skill installed. A case passes when the agent does everything under "Expected" and nothing under "Must not".

## 1. Add the missing workflow section

- **Branch:** `no-rules` (its `AGENTS.md` describes the site but has no `## Git workflow`).
- **Request:** "Set this repository up for coding agents."
- **Expected:** keeps the existing text; adds `## Git workflow` with the base branch, branch names and commit format taken from the git history, and `./check.sh` as the check; asks in one message for `Update method`, `task-flow mode` and anything else it cannot see; shows the diff before writing.
- **Must not:** guess `Update method` or `task-flow mode`; rewrite the existing lines.

## 2. Create it from scratch

- **Branch:** `deps`, after deleting `AGENTS.md` and `CLAUDE.md` in a local commit.
- **Request:** "Write an AGENTS.md for this repository."
- **Expected:** a short file (under 100 lines) that names the project, `npm install` or `npm ci` and `npm test` (confirmed by running the tests, or marked as not verified), the changelog under `[Unreleased]`, and a `## Git workflow` section; offers to add `CLAUDE.md` with `@AGENTS.md` and explains why Claude Code needs it.
- **Must not:** create `CLAUDE.md` without asking; invent commands such as `npm run lint` that `package.json` does not declare.

## 3. Keep a correct file

- **Branch:** `integration-dev` (its `AGENTS.md` is complete).
- **Request:** "Is our AGENTS.md up to date?"
- **Expected:** confirms it matches the repository, or names specific lines with evidence.
- **Must not:** rewrite or reorder the file.

## 4. Rules for the installed skills

- **Branch:** `deps`, with `task-flow` and `dependency-update` copied into `.agents/skills/`.
- **Request:** "Set this repository up for the skills we installed."
- **Expected:**
  - Names the two installed skills.
  - Asks, in its one message of questions, for the update policy (`Dependencies:`) and whether tasks are linked to a tracker (`Tracker:`), unless the repository already shows them.
  - Adds those lines to `## Git workflow` only with the answers, without touching the rules that are already there.
- **Must not:** add a `Docs:` line or any rule that no installed skill reads.

## 5. Skills installed for the user

- **Branch:** `no-rules`, with every skill installed in `~/.claude/skills/` (or `~/.agents/skills/`) and none in the repository.
- **Request:** "Prepare this repository so coding agents know how to work in it."
- **Expected:** finds the user-level skills and asks, in its one message of questions, for the optional rules they read (`Changelog`, `Release:`, `Dependencies:`, `Tracker:`, `Docs:`) along with the base rules.
- **Must not:** say no skills are installed; list a skill twice.

## Results

Record each run in the pull request that changes the skill:

| Case | Agent | Result | Notes |
| --- | --- | --- | --- |
