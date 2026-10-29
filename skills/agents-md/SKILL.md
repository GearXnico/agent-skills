---
name: agents-md
description: Creates or updates a repository's AGENTS.md - the instructions every coding agent reads - from facts found in the repository (what it is, layout, verified commands, conventions, git workflow, security rules and what to ask before). Use when setting up a repository for coding agents, when AGENTS.md is missing, out of date or too long, or when another skill reports a missing "## Git workflow" section.
license: MIT
metadata:
  version: "0.1.0"
---

# agents-md

Give every coding agent the same short, correct briefing about a repository. A good `AGENTS.md` saves each agent from exploring the repository on every task, and it is where the other skills read their rules.

## 1. Gather the facts

Run this skill's `scripts/detect-project.sh` from the repository root. It prints the existing agent instruction files and their headings, the manifests and build files, the declared commands (package scripts, make targets), the CI steps, the installed skills and the git habits (default branch, branch names, recent commit messages, changelog, pull request template).

Then read only what fills the gaps: the README, `CONTRIBUTING.md`, the existing `AGENTS.md` or `CLAUDE.md`, and the CI workflow that runs the tests.

## 2. Verify the commands

A wrong command is worse than none. For each command you plan to write (install, run, test, lint, build):

- It must appear in a manifest, a build file, the CI or the docs. Never invent one.
- Run the read-only and quick ones (lint, type check, unit tests) to confirm they work. Ask before running anything slow, anything that needs services or credentials, or anything that writes outside the repository.
- If a command cannot be confirmed, write it with "(not verified)" or leave it out.

## 3. Write or update

Use [the template](references/template.md) and keep only the sections that have facts. Aim for under 100 lines: an agent reads the whole file on every task.

- **New file:** write `AGENTS.md` at the root.
- **Other agents:** some agents read their own file instead of `AGENTS.md`. For each agent the team uses that does, offer (never create on your own) the small bridge file [the agent files table](references/agent-files.md) lists, and explain why: without it, that agent starts without the project's rules, and the bridge keeps a single source instead of copies that drift apart.
- **Existing file:** keep the owner's text and structure. Add missing sections, correct facts that are wrong, and point out (do not delete) lines that look stale. Show the diff before writing.
- **Git workflow:** always include the `## Git workflow` section in the format the other skills read. Fill each rule from the git habits; for `Update method` and `task-flow mode`, never guess: ask.
- **Installed skills:** the script lists the skills installed in `.agents/skills/` and `.claude/skills/`, with the lines where each one mentions the workflow section. Add the optional rules those skills read (for example `Docs:`, `Dependencies:`, `Tracker:`, `Release:`) when the repository shows a value, and include them in the one message of questions otherwise. Add no rule that no installed skill reads. If no skills are installed, mention they can be added with the installer or by hand, as the README of the repository they come from explains.
- **Monorepos:** keep shared rules at the root and offer a short `AGENTS.md` per package only where its commands or conventions differ.

Ask once, in one message, for everything the repository does not show: the rules nobody wrote down, what an agent must ask before doing, and what is off limits.

## 4. Finish

Reply with what was added or changed and what you could not verify. Commit as `docs:` (or the repository's format) only if the user asks; with `task-flow` installed, hand over to it.

## Never

- Invent commands, rules or conventions that the repository does not show and the user did not state.
- Delete or rewrite the owner's existing instructions without asking.
- Write secrets, tokens, internal hostnames or personal data into the file.
- Copy whole documents into it; link to them instead.
