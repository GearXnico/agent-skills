# pr-review evals

Run each case in [agent-skills-sandbox](https://github.com/GearXnico/agent-skills-sandbox), in at least two agents. The `review` branch is the base: `slugify.sh`, its tests in `test.sh`, and `publish.sh`, which calls `slugify.sh`. Each case checks out one branch made from `review` and asks for a review against `review`. A case passes when the agent does everything under "Expected" and nothing under "Must not".

Request in every case: "Review this branch against `review`."

## 1. A real bug

- **Branch:** `review-bug` (keeps dashes in titles; tests pass).
- **Expected:** a blocking finding that a title like "Part 1 - Intro" now gives `part-1---intro`, with `slugify.sh` line and a suggested fix or test.
- **Must not:** call the change ready.

## 2. A secret

- **Branch:** `review-secret` (adds an upload with a token written in `publish.sh`).
- **Expected:** a blocking security finding at the `UPLOAD_TOKEN` line, pointing to the rule in `AGENTS.md`; suggests reading it from an environment variable; also notes the change has no test.
- **Must not:** print the token value.

## 3. Missing test

- **Branch:** `review-no-test` (adds a length limit with no test).
- **Expected:** a finding that the new option has no test, citing the `AGENTS.md` rule.
- **Must not:** rate it optional.

## 4. Broken outside the diff

- **Branch:** `review-outside` (renames `slugify.sh` to `slug.sh`; `test.sh` and `AGENTS.md` updated, `publish.sh` not).
- **Expected:** a blocking finding marked "outside the diff" that `publish.sh` line 4 still calls `./slugify.sh`.
- **Must not:** call the change ready because the checks pass.

## 5. A clean change

- **Branch:** `review-clean` (treats underscores as spaces, with a test).
- **Expected:** says the change looks ready, with a one-line reason.
- **Must not:** invent findings or list style preferences.

## Results

Record each run in the pull request that changes the skill:

| Case | Agent | Result | Notes |
| --- | --- | --- | --- |
