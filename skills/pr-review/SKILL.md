---
name: pr-review
description: Reviews a pull request or the current branch against the repository's own rules - correctness, security, tests, scope, conventions - including code outside the diff that the change can break, and reports verified findings ranked by severity. Use when the user asks to review a pull request, a branch or a diff, or wants a check before asking others for review.
license: MIT
metadata:
  version: "0.1.0"
---

# pr-review

Review a change the way a careful teammate would: against the repository's own rules, with evidence for every finding, and without noise. Works on your own branch before asking for review, and on someone else's pull request.

## 1. Read the rules

Read `AGENTS.md` (or `CLAUDE.md`), `CONTRIBUTING.md`, the pull request template and description, and the decision records the change touches. These rules decide what counts as a finding; general taste does not.

## 2. Read the change

1. Get the diff against the base branch (from the pull request, or `Base branch` in the `## Git workflow` section of `AGENTS.md`).
2. For each changed file, read the diff and just enough around it to understand it. Do not read the whole repository.
3. **Outside the diff.** List what the change alters for other code: a function signature, an endpoint, a schema, a configuration key, an environment variable, a file name or path. Run this skill's `scripts/find-usages.sh <base> <name>...` from the repository root; it prints the places outside the diff that mention each name, and adds deleted or renamed files on its own. Read those places: a caller still using the old form is a finding even though its file is not in the diff.

## 3. Review, most important first

1. **Correctness:** wrong results, edge cases (empty, large, concurrent, failure paths), broken callers.
2. **Security:** unvalidated input, secrets or tokens in code, missing authorization, personal data in logs.
3. **Tests:** does the change ship with a test that would fail without it? Was a test skipped, weakened or deleted?
4. **Scope:** does the change do more than the pull request says? Unrelated refactors belong elsewhere.
5. **Repository rules:** conventions the repository writes down.
6. **Readability:** only when it hides a bug or breaks a written rule.

## 4. Verify before reporting

Run the repository's checks. For each finding you are not certain of, try to reproduce it (a quick command or test). Drop what does not hold. A finding needs evidence: `file:line` and why it fails.

## 5. Report

Reply with three lines of summary (what the change does, whether it is ready, the main issue) and a table:

| Severity | Where | Finding | Suggestion |
| --- | --- | --- | --- |
| Blocking / Should fix / Optional | `file:line` (mark "outside the diff" when it applies) | What goes wrong and when | The concrete change |

If nothing holds up, say the change looks ready and why. Do not invent findings to fill the table.

Post comments on the pull request only when the user asks; otherwise reply in the conversation.

## Never

- Approve, merge, or request changes on the user's behalf.
- Rewrite or push to the pull request's branch.
- Report style preferences the repository does not write down.
- Print secret values you find: name the file and line only.
