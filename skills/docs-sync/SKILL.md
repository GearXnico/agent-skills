---
name: docs-sync
description: Finds the documentation a change left out of date (README, docs, ADRs, API references, changelog) and updates it, or only reports it when asked to check. Use before opening a pull request, after changing behaviour, commands, configuration or an API, or when the user asks whether the docs are up to date.
license: MIT
metadata:
  version: "0.1.0"
---

# docs-sync

Keep the documentation in step with the code. Start from the diff, find only the documents that mention what changed, and fix the affected lines.

Two modes:

- **Update** (default): edits the affected lines and commits them.
- **Check only**, when the user asks "are the docs up to date?" or says not to edit: reports what is out of date and changes nothing.

## 1. Read what you need

| Need | Where to look |
| --- | --- |
| What changed | `git diff origin/<base>...HEAD`, with the base branch from the `## Git workflow` section of `AGENTS.md` (ask if there is none) |
| Where the docs are | Every tracked Markdown, reStructuredText, AsciiDoc or text file, and `docs/`. A `Docs:` line in `## Git workflow` adds more paths |
| Language and style | The document being edited |

Do not read every document. The script below finds the lines to look at.

## 2. Steps

1. **List what changed for a reader.** From the diff, keep only what someone reading the docs sees: commands, flags, environment variables, configuration keys, file paths, endpoints, public functions, user-visible behaviour. Ignore internal refactors. If nothing is left, say there is nothing to update and stop.
2. **Find mentions.** Run this skill's `scripts/find-mentions.sh <old name> <new name>...` from the repository root, with the old and new form of each changed item. Pass extra doc paths with `DOCS_PATHS="path1 path2"`. It prints `file:line:text` for each match.
3. **Decide per document:** out of date, missing something new, or fine. A new command or option that users need and no document mentions counts as missing.
4. **Act by mode.**
   - Update: change only the affected lines, in the document's own language and style. Add the changelog entry if the repository keeps one. Commit everything as one `docs:` commit (or the repository's format).
   - Check only: reply with a table of document, line, what is wrong and the suggested text.
5. **Report** what you updated, and what you could not decide alone, such as an accepted ADR the change contradicts.

## Accepted decisions

An accepted ADR is a record of a past decision: never edit it. If the change makes it out of date or contradicts it, say so and propose a new ADR that supersedes it (with `new-adr` if installed).

## Never

- Rewrite whole documents or change their tone; touch only the affected lines.
- Edit an accepted ADR.
- Document something that is not in the code.
- Change code.
