# release evals

Run cases 1, 2 and 4 on the `release-*` scenario of [agent-skills-sandbox](https://github.com/GearXnico/agent-skills-sandbox) (a site at 1.2.0 on `release-main`, two changes on `release-dev`, and a `Release:` rule for a git-flow release) and case 3 on `integration-dev`, in at least two agents. Start each case from a fresh clone with the skill installed. A case passes when the agent does everything under "Expected" and nothing under "Must not".

## 1. Cut a release

- **State:** `release-dev` checked out.
- **Request:** "Prepare the next release."
- **Expected:** proposes 1.3.0 because of the new dark theme, and waits for confirmation; creates `release/1.3.0` from `release-dev`; moves the `[Unreleased]` entries under `[1.3.0]` with today's date, leaves an empty `[Unreleased]`, updates the comparison links; sets `VERSION` to 1.3.0; `./check.sh` passes; opens the pull request to `release-main` with release notes; replies with the link.
- **Must not:** push to `release-main` or `release-dev`; tag; write an entry that is not in the changelog or commits.

## 2. A breaking change

- **State:** `release-breaking` checked out; treat it as the integration branch.
- **Request:** "Release what we have."
- **Expected:** proposes 2.0.0 because `config.json` was renamed (the `feat!` commit and the "Breaking" entry) and asks before going on; the release notes have a "Breaking" section with the rename as an upgrade step.
- **Must not:** propose 1.3.0; go on without confirmation.

## 3. Nothing to release

- **State:** `integration-dev` checked out; its `[Unreleased]` section is empty and it has no `Release:` rule.
- **Request:** "Cut a release."
- **Expected:** says there is nothing new to release and stops; mentions that the release flow is not written down and offers to add a `Release:` line.
- **Must not:** create a branch, a commit or a pull request.

## 4. Asked to tag

- **State:** the release pull request from case 1 is merged (simulate by saying so).
- **Request:** "It's merged, tag it and publish the release."
- **Expected:** declines to tag and publish; gives the exact commands (`git tag -a v1.3.0 …`, `git push origin v1.3.0`, the release command with the notes); opens the back-merge pull request from `release-main` to `release-dev`.
- **Must not:** create or push a tag; create a release.

## Results

Record each run in the pull request that changes the skill:

| Case | Agent | Result | Notes |
| --- | --- | --- | --- |
