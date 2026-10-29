---
name: skill-tune
description: Records what an installed skill did wrong, sorts it into a project rule, a defect or a personal variant, fixes the local copy with an approved diff and checks the fix by repeating the case; also updates a tuned copy to a new version without losing the local changes, and drafts the issue that shares a verified defect. Use when a skill misbehaved, an eval failed, the user wants to adjust or customise a skill, or wants to update a skill they changed.
license: MIT
metadata:
  version: "0.1.0"
---

# skill-tune

Fix an installed skill where it runs, prove the fix with the case that showed the problem, and keep a record that can be shared. It changes installed copies only, never the repository the skills come from.

## 1. Find the skill

Run this skill's `scripts/tune.sh find [skill]` from the project root. It lists every installed copy (project `.agents/skills` and `.claude/skills`, user `~/.agents/skills` and `~/.claude/skills`) with its version, the findings it is tuned for, whether a base is saved, and the findings log next to each skills folder. If the skill is installed in more than one place, ask which copy to change.

## 2. Record the finding

Add an entry to `skill-findings.md` next to that skills folder (for example `~/.claude/skill-findings.md`), in the format of [findings](references/findings.md): what was asked, what the skill did, what was expected, the skill version and the agent. Give it the next id (`F1`, `F2`, …) and the status `open`. Ask once for anything missing.

## 3. Classify it

Say the class and why before changing anything:

| Class | Meaning | What to do |
| --- | --- | --- |
| Project rule | The skill works; this project works differently | Write the rule in `AGENTS.md` (with `agents-md` if installed); leave the skill alone |
| Defect | The skill breaks its own rules, or would fail in any repository | Steps 4 to 7 |
| Personal variant | The user wants other behaviour that would not suit everyone | Copy the skill under a new name (for example `release-mine`, with `name` changed to match), run `tune.sh base` on the copy, then steps 4 to 6 on it |

## 4. Write the case

Write the case that reproduces the problem in the format of the skill's `evals/` (request, state, expected, must not) and keep it in the finding.

## 5. Propose the smallest fix

- Before the first change to a copy, run `tune.sh base <copy>` so later updates can merge.
- Show the change as a diff and apply it only after the user approves it.
- Add the finding id to `tuned` under `metadata` in the copy's `SKILL.md` (for example `  tuned: "F1 F3"`), so the installer leaves the copy alone.

## 6. Verify

Tell the user how to repeat the case in a new session, with the request to type. Record the result in the finding. Mark it `verified` only when the case passes and, if a clone of the skills repository is available, the other cases in that skill's `evals/` still pass. Otherwise keep it `open` and say what failed.

## 7. Share a defect

Only defects are shared; project rules and variants stay with the user.

- For one finding, draft the issue from [findings](references/findings.md) (finding, case, diff, result, version, agent) for the skills repository, labelled `eval-finding`.
- When asked for a summary, draft one issue with every `verified` defect not yet shared.
- Publish only after the user approves; then mark each finding `shared` with the link.

## Update a tuned copy

When a new version of a tuned skill is available (the installer skips tuned copies and says so):

1. Run `tune.sh merge <copy> <new>`, where `<new>` is the skill's folder in an up-to-date clone. It merges the saved base, the copy and the new version into a staging folder: changes made on one side apply as they are, and a local fix that the new version also made merges as one change.
2. Show the diff the script prints. For each conflict, show both versions with a recommendation and resolve it the way the user chooses, in the staging folder.
3. After approval, run `tune.sh apply <copy> <new>`: it replaces the copy and makes the new version the base.
4. Repeat the cases of the copy's findings. A finding the new version fixed becomes `resolved`: remove its id from `tuned`, and drop the line once it is empty.

If the script says there is no base (a copy edited by hand), do not guess: show the differences between the copy and the new version and ask.

## Never

- Weaken or remove a rule from a skill's Never list. If asked, explain the risk and offer a personal variant under another name.
- Change a skill without showing the diff and getting approval.
- Publish an issue, push or open a pull request without approval.
- Edit the clone of the skills repository; only installed copies.
- Edit the user's project files, except `AGENTS.md` through `agents-md` with approval; this skill changes only installed copies, their state folder and the findings log.
- Mark a finding `verified` without repeating its case and, when the clone is available, the skill's other evals.
