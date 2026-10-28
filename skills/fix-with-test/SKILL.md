---
name: fix-with-test
description: Fixes a bug test-first - writes a test that reproduces it and fails, then makes the smallest change that turns it green. Use when the user reports a bug, a wrong result, a crash or a regression.
license: MIT
metadata:
  version: "0.1.0"
---

# fix-with-test

Fix a bug in two steps: first a test that reproduces it and fails, then the smallest change that makes it pass. The history then shows the test failing before the fix, and the bug cannot come back unnoticed.

If `task-flow` is installed, it creates the branch and opens the pull request; this skill does the work in between.

## 1. Read what you need

| Need | Where to look | If missing |
| --- | --- | --- |
| Test command | `Checks` in the `## Git workflow` section of `AGENTS.md`, then `package.json`, `Makefile`, `pyproject.toml`, the CI workflows | Ask |
| Where tests go and how they are named | The existing tests closest to the code of the bug | Copy the closest neighbouring test |
| Commit format | `Commits` in `## Git workflow` | Copy the last commit messages |

Read only the code of the bug, its nearest tests and the test command, not the whole repository.

## 2. Steps

1. **Understand the bug.** Write one sentence with the input, the expected result and the actual result. If one is missing, ask once.
2. **Reproduce.** Write the smallest test that shows the bug, next to the existing tests and in their style. Run only that test and confirm it **fails for the right reason**: the wrong result, not a syntax error, a missing import or a typo in the test.
3. **Commit the test**, in the repository's format: for example `test: reproduce <bug>`.
4. **Fix.** Make the smallest change that turns the test green. No refactors or improvements on the way.
5. **Verify.** Run the new test, then every check of the repository.
6. **Commit the fix**: for example `fix: <bug>`.
7. **Report** in three lines: the root cause, the test and the change. If `task-flow` is installed, continue with its finish step.

If you cannot reproduce the bug with a test, stop and say so, with what you tried. Do not "fix" something you have not proven.

If the fix makes an existing test fail, stop and show it: either the fix is wrong or that test encodes the bug. Change that test only after the user confirms it is wrong.

## Never

- Change the code before there is a failing test.
- Edit or delete an existing test to get green without the user's confirmation.
- Skip, disable or mark a test as expected to fail.
- Mix the fix with refactors or features nobody asked for.
