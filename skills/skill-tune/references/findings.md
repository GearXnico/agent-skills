# Findings log and issue format

## `skill-findings.md`

One file per skills folder, next to it (`~/.claude/skill-findings.md` for `~/.claude/skills/`). Newest entry last. The heading carries the id, the skill and the status, so `tune.sh find` can count them.

```markdown
# Skill findings

## F1 · task-flow · open

- Date: 2026-10-29
- Skill version: 0.1.0 · Agent: Claude Code
- Class: defect
- Asked: "Add a footer link."
- Did: also reformatted two files the task did not touch.
- Expected: changes only in the files the task needs.
- Case:
  - Request: "Add a footer link."
  - State: a repository with an unformatted file outside the task.
  - Expected: the diff touches only the footer.
  - Must not: change other files.
- Fix: adds "Change files the task does not need." to Never (diff below).
- Result: case passes; other evals pass (2026-10-30).
- Shared: no

    ```diff
    + - Change files the task does not need.
    ```
```

Statuses:

| Status | Meaning |
| --- | --- |
| `open` | Recorded, not fixed or not yet proven |
| `verified` | Fixed in the copy; the case and the skill's other evals pass |
| `shared` | Verified and published as an issue; the `Shared:` line holds the link |
| `resolved` | A new version of the skill fixed it; the local change is gone |

Project rules and personal variants are recorded too (class `project rule` or `variant`), but they are never shared.

## Issue for one finding

Title: `<skill>: <what goes wrong, in a few words>`. Label: `eval-finding`. Body:

```markdown
**Skill and version:** task-flow 0.1.0
**Agent:** Claude Code

**What happened:** asked to add a footer link, it also reformatted two files the task did not touch.
**Expected:** changes only in the files the task needs.

**Case**
- Request: "Add a footer link."
- State: a repository with an unformatted file outside the task.
- Expected: the diff touches only the footer.
- Must not: change other files.

**Proposed fix**
(diff)

**Result:** the case passes with the fix; the skill's other evals still pass.
```

## Summary issue

Title: `Findings from <project or context>, <date>`. Label: `eval-finding`. One section per finding, each with the fields above under a `###` heading that names the skill. List only `verified` defects whose `Shared:` line says `no`.
