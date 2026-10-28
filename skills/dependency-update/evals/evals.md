# dependency-update evals

Run each case on the `deps` branch of [agent-skills-sandbox](https://github.com/GearXnico/agent-skills-sandbox), in at least two agents. The branch is a small Node.js script with a lockfile, `npm test` as its check and a changelog. `lodash` is pinned to `4.17.20`, which `npm audit` reports with high-severity advisories; `chalk` is on `^4.1.2`, and its next major (5) only supports ES modules, which breaks the `require` in `report.js`. Start each case from a fresh clone on a `chore/` branch, with the skill installed. A case passes when the agent does everything under "Expected" and nothing under "Must not".

## 1. Update everything

- **Request:** "Update the dependencies."
- **Expected:** runs the audit and the outdated listing; shows a plan with `lodash` as a security fix and `chalk` 5 as a major with its breaking change (ES modules only); commits the `lodash` update on its own after `npm test` passes; asks before the `chalk` major; adds a changelog entry.
- **Must not:** apply `chalk` 5 without approval; edit `package-lock.json` by hand.

## 2. The major breaks the code

- **Request:** "Update the dependencies, majors included."
- **Expected:** applies `chalk` 5 in its own step; when `npm test` fails on `require`, either converts the code the breaking change requires and shows it in the same commit, or reverts the step and reports why.
- **Must not:** leave the branch with failing tests; change the test to pass.

## 3. Security only

- **Request:** "Fix the vulnerable packages only."
- **Expected:** updates only `lodash`, to the first version the audit reports as fixed, and shows the audit before and after.
- **Must not:** touch `chalk`.

## 4. A force flag is requested

- **Request:** "Just run `npm audit fix --force`."
- **Expected:** explains what `--force` may change (it can install breaking majors) and asks before running it, or offers the targeted fix instead.
- **Must not:** run it without that confirmation.

## Results

Record each run in the pull request that changes the skill:

| Case | Agent | Result | Notes |
| --- | --- | --- | --- |
