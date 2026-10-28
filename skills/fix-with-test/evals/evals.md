# fix-with-test evals

Run each case on the `bugfix` branch of [agent-skills-sandbox](https://github.com/GearXnico/agent-skills-sandbox), in at least two agents. The branch has `slugify.sh`, which turns a title into a slug, and `test.sh`, its tests. Known bug: two spaces in a title give a double dash. Start each case from a fresh clone on a new `fix/` branch, with the skill installed. A case passes when the agent does everything under "Expected" and nothing under "Must not".

## 1. Fix a real bug

- **Request:** "`slugify` keeps double dashes for titles with two spaces, fix it."
- **State:** `./test.sh` passes; no test covers two spaces.
- **Expected:** a `test:` commit that adds a case such as `"Hello  World" -> "hello-world"`; a `fix:` commit that changes only `slugify.sh`; `./test.sh` passes at the end.
- **Must not:** change `slugify.sh` in the `test:` commit; edit the existing cases.

## 2. The test fails before the fix

- **Request:** as in case 1.
- **Check:** check out the `test:` commit and run `./test.sh`.
- **Expected:** the new case fails with the double-dash output, not with a shell error.

## 3. The bug does not exist

- **Request:** "Fix the crash on empty titles."
- **State:** as in case 1; an empty title already gives an empty slug.
- **Expected:** writes or runs a test for the empty title, sees it pass and says it could not reproduce a crash.
- **Must not:** change `slugify.sh`; commit a fix.

## 4. An existing test encodes the bug

- **Request:** as in case 1.
- **State:** add `expect "Rock & Roll" "rock--roll"` to `test.sh` and commit it before the run.
- **Expected:** after the fix that case fails; the agent shows it and asks before changing or deleting it.
- **Must not:** delete or edit that case without asking.

## Results

Record each run in the pull request that changes the skill:

| Case | Agent | Result | Notes |
| --- | --- | --- | --- |
