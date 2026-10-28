---
name: dependency-update
description: Updates a project's dependencies safely - security fixes first, then patch and minor updates in small groups, and each major update on its own after reading its breaking changes - running the checks after every step and reverting what breaks. Use when the user asks to update, upgrade or bump dependencies, fix vulnerable packages or audit findings, or handle automated dependency pull requests.
license: MIT
metadata:
  version: "0.1.0"
---

# dependency-update

Bring dependencies up to date without breaking the project. Small steps, one commit each, checks after every step, and nothing that cannot be traced back to a reason.

## 1. Read what you need

| Need | Where to look | If missing |
| --- | --- | --- |
| Package managers in use | Lockfiles and manifests at the root and in each package | Ask |
| Checks | `Checks` in the `## Git workflow` section of `AGENTS.md`, then the CI workflows | Ask |
| Commit format and changelog | `## Git workflow` | Copy the last commits |
| Update policy | A `Dependencies:` line in `## Git workflow` (for example "security only" or "no majors"), pins and ranges in the manifests, an automated-update config | Patch and minor allowed, majors one at a time with approval |

[The ecosystem table](references/ecosystems.md) lists the commands to list outdated packages, audit, and update one package for common package managers. Read only the rows for the managers this repository uses.

## 2. Plan

1. Run the audit and the outdated listing. Run the checks once on the untouched branch so you know what already fails.
2. Sort the updates:
   - **Security:** packages with a known vulnerability, smallest version that fixes it.
   - **Patch and minor:** grouped by ecosystem or by related packages (for example a framework and its plugins).
   - **Major:** one per step. Read the release notes or migration guide and list the breaking changes that touch this code (search the code for the APIs they name).
   - **Held back:** what policy, a pin or an incompatibility keeps where it is, with the reason.
3. Show the plan as a short table and wait for approval before majors, unless the user already asked for them. Apply security and patch/minor steps when the request covers them.

## 3. Apply, one step at a time

For each step:

1. Update through the package manager so the lockfile stays consistent. Never edit a lockfile by hand.
2. Run the checks.
3. Green: commit the step on its own, for example `chore(deps): bump <package> from <old> to <new>` or `fix(deps): ...` for a security fix, in the repository's format.
4. Red: if the fix is a small change required by the update's documented breaking changes, make it in the same commit. Otherwise revert the step, keep the error output, and move on.

Add one changelog entry for the whole update if the repository keeps a changelog.

## 4. Report

A table of what was updated, held back or reverted, with the reason for each; the audit before and after; and anything that needs the user (a major to approve, a vulnerability with no fix).

## Never

- Use force flags that apply breaking updates or bypass peer-dependency checks without the user's approval.
- Edit a lockfile by hand, or delete it to "start fresh".
- Add, remove or replace a dependency the user did not ask about.
- Change a pinned version without saying why.
- Skip, disable or loosen a check or a test to get green.
- Ignore or silence an audit finding without the user's approval and a recorded reason.
