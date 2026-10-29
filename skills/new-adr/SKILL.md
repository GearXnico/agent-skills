---
name: new-adr
description: Records a technical decision as a numbered architecture decision record (ADR) - context, options, decision and consequences - in the repository's own format and folder, and marks the record it replaces as superseded. Use when the user asks to record, document or write up a decision or an ADR, or when another skill proposes a decision record.
license: MIT
metadata:
  version: "0.1.0"
---

# new-adr

Write down a decision so the next person knows what was chosen, what else was considered and why. A record is short, numbered, and never rewritten once accepted; a new decision replaces an old one with a new record.

## 1. Find where and how the repository records decisions

Run this skill's `scripts/find-adrs.sh` from the repository root. It prints the folder, each record's file name, title and status, and the next number.

- **Records exist:** copy their format exactly (headings, status words, date style, file naming, numbering width). Use a template file if the folder has one.
- **No records:** propose `docs/adr/` (or the `Docs:` line of `## Git workflow`, if it names a place) and [the short template](references/template.md). Ask once before creating the folder.

## 2. Read the related records

Read only the records whose titles touch the same area. If the new decision contradicts or replaces an accepted one, the new record says so (`Supersedes 0003`) and tell the user.

## 3. Gather the content

| Section | What it holds |
| --- | --- |
| Context | The problem, the forces and the constraints, in a few sentences |
| Options | Two or three real ones, including doing nothing or the simplest, each with its main pro and con |
| Decision | The option chosen and why, in the active voice |
| Consequences | What gets better, what gets worse or harder, and when to revisit |

Take the facts from the conversation, a design document or the code. If the decision itself or its reason is missing, ask in one message. Never invent a reason, a number or an option nobody considered.

## 4. Write the record

- File name and number: the next number from the script, in the repository's naming (`0007-use-postgres-for-jobs.md`).
- Status: `Proposed`, unless the user says the decision is already made; then `Accepted` with today's date.
- If the folder has an index (a README or table listing the records), add the new line.
- When it supersedes a record, change **only the status line** of the old one (`Superseded by 0007`, linking the new file). Nothing else in an accepted record changes.

Commit as one `docs:` commit (or the repository's format), and open the pull request with `task-flow` if installed. Reply with the path and the decision in one line.

## Never

- Invent reasons, numbers or options.
- Edit an accepted record beyond its status line, or renumber records.
- Mark a decision `Accepted` on the user's behalf.
- Record a decision that only the conversation suggests without the user confirming it.
