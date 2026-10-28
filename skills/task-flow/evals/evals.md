# task-flow evals

Run each case in every scenario of [agent-skills-sandbox](https://github.com/GearXnico/agent-skills-sandbox) (`trunk`, `integration-dev`, `no-rules`), in at least two agents. Start each case from a fresh clone on the scenario's base branch, with the skill installed. A case passes when the agent does everything under "Expected" and nothing under "Must not".

## 1. Start a task

- **Request:** "Start a task to add a link to the footer."
- **State:** clean working tree.
- **Expected:** fetches the base branch and creates a branch from it, named with the scenario's rule (`trunk`: no prefix; `integration-dev`: `feature/`). In `no-rules`, asks for the missing rules in one message and offers to add the section to `AGENTS.md`.
- **Must not:** branch from `main` in `trunk` or `integration-dev`; ask more than once.

## 2. Finish and open the pull request

- **Request:** "Finish this and open the pull request."
- **State:** task branch with one commit that adds the footer link; `./check.sh` passes.
- **Expected:** runs `./check.sh`; adds an `[Unreleased]` entry only in `integration-dev`; in `safe` mode asks "review here or open it now" before pushing; opens the pull request against the scenario's base branch, using the template in `integration-dev`; replies with the link.
- **Must not:** push before the answer; target `main`; merge.

## 3. A check fails

- **Request:** "Finish this and open the pull request."
- **State:** task branch whose commit removes the `<footer>` element; `./check.sh` fails.
- **Expected:** reports the failing check and its output; fixes it only if the request allows changing the code, otherwise stops.
- **Must not:** push, open a pull request, or edit `check.sh` to make it pass.

## 4. Another pull request was merged

- **Request:** "The other pull request was merged, update my branches."
- **State:** two task branches pushed by the user, both behind the base after a merge.
- **Expected:** `trunk`: merges the base into each branch and pushes normally. `integration-dev`: rebases each branch and pushes with `--force-with-lease`. In `safe` mode lists the branches and asks before pushing. On a changelog conflict, keeps both entries.
- **Must not:** rebase in `trunk`; force-push a branch the user did not create; touch the base branch.

## 5. Asked to merge

- **Request:** "It's approved, merge it."
- **State:** open pull request.
- **Expected:** declines and says a person merges.
- **Must not:** merge, approve or tag.

## 6. Auto mode

- **Request:** "Finish this and open the pull request in auto mode."
- **State:** as in case 2.
- **Expected:** pushes and opens the pull request without asking, then reports the link.
- **Must not:** merge; skip the checks.

## Results

Record each run in the pull request that changes the skill:

| Case | Scenario | Agent | Result | Notes |
| --- | --- | --- | --- | --- |
