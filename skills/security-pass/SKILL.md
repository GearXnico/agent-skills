---
name: security-pass
description: Reviews the current change for security issues before asking for review - secrets, injection, missing authorization, leaked error details, unsafe configuration, risky new dependencies - running the scanners the repository already has, following each new input to where it is used, and reporting verified findings with a concrete fix. Use when the user asks for a security review, a security pass or check of a branch, diff or pull request, or before opening a pull request that touches input, authentication, data or dependencies.
license: MIT
metadata:
  version: "0.1.0"
---

# security-pass

A focused security review of one change. `pr-review` covers security as one layer among many and `architecture-review` looks at the whole system; this skill goes deeper, but only on security and only on what the diff touches.

It reads, runs local checks and reports. It changes code only when the user asks for a fix.

## 1. Scope

Take the diff against the base branch (from the pull request, or `Base branch` in the `## Git workflow` section of `AGENTS.md`), or the branch or pull request the user names. List the files and what kind of change each is: input handling, authentication, data access, configuration, dependencies, file handling, output.

## 2. Run the scanners the repository has

Run this skill's `scripts/find-scanners.sh` from the repository root. It lists the security tools declared in CI, pre-commit hooks, package scripts and build files, and which common ones are installed.

- **Declared:** run them on the change, with the repository's own configuration. Report their findings with the rest; a finding they report and you cannot confirm is listed as "scanner only".
- **None declared:** propose a temporary run of one or two tools that fit the stack (see [scanners](references/scanners.md)), without installing them in the project. Run only if the user accepts. Either way, continue with the manual review.

## 3. Review by category

Read [the checklist](references/checklist.md), only the sections the change touches. For each new or changed input (request field, header, file, environment variable, message), follow it to where it is used (query, command, file path, template, response, log), even outside the diff. A finding needs that path from input to use.

## 4. Verify and rank

For each finding, give:

- **Severity:** critical (exploitable now, exposes data or money), high (exploitable with a common condition), medium (needs an unlikely condition or limits damage), low (hardening).
- **Where:** `file:line`.
- **How it is abused,** in one sentence.
- **The fix,** concrete and small.

Reproduce it locally when that is safe (a test, a crafted input against a local run). Drop what does not hold. Without evidence it is a question, not a finding. Mask any secret you report (first four characters, then `…`) and say it must be rotated, because it is already in the history.

## 5. Report

A three-line summary, then the findings table, then what you checked and what you did not (categories, scanners, files). Never call the change "secure"; say what was reviewed.

Offer to fix the blocking findings with `fix-with-test` if installed (a test that proves the flaw first). If no scanner was declared, end with a suggestion to integrate the one that fit, with the exact change already prepared (a pre-commit hook or a CI step from [scanners](references/scanners.md)), to apply in one step when the user approves.

## Never

- Probe, scan or attack a deployed system, production data or a third-party service.
- Copy a full secret into the report, a commit or a message.
- Disable a scanner rule, add an ignore entry or weaken a check to make the result pass.
- Install a tool in the project, or add it to CI, without approval.
- Report a finding without a path from input to use, or pad the list with generic advice.
