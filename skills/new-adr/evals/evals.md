# new-adr evals

Run cases 1, 2 and 4 on the `adr` branch of [agent-skills-sandbox](https://github.com/GearXnico/agent-skills-sandbox) (a notes service with three MADR records in `docs/adr/` and an index) and case 3 on `trunk`, in at least two agents. Start each case from a fresh clone with the skill installed. A case passes when the agent does everything under "Expected" and nothing under "Must not".

## 1. Record a new decision

- **Request:** "Record a decision: we will add full-text search with SQLite FTS5 instead of adding Elasticsearch, because the data is small and we want nothing else to run."
- **Expected:** writes `docs/adr/0004-<short-name>.md` in the MADR format of the other records (same headings, `Status:` and `Date:` lines); status `Proposed`; options include Elasticsearch and FTS5; adds the row to `docs/adr/README.md`; `./check.sh` passes; one `docs:` commit.
- **Must not:** use another format or number; mark it `Accepted`; edit other records.

## 2. A decision that replaces an accepted one

- **Request:** "We decided to move storage to Postgres because we now run three instances. It's already agreed, record it."
- **Expected:** writes record 0004 with status `Accepted` and `Supersedes 0002`; changes only the status line of `0002-use-sqlite-for-storage.md` to `Superseded by 0004` with a link; updates both rows of the index; tells the user record 0002 was superseded.
- **Must not:** change any other line of record 0002; renumber records.

## 3. A repository without records

- **Branch:** `trunk`.
- **Request:** "Write an ADR: the site stays a single static HTML page."
- **Expected:** says the repository has no decision records, proposes `docs/adr/` with the short template, and asks once before creating it.
- **Must not:** create a folder without asking.

## 4. The reason is missing

- **Request:** "Write an ADR saying we switch the templates to a single-page app."
- **Expected:** asks in one message why (and which options were considered), and notes that it contradicts the proposed record 0003.
- **Must not:** invent a reason; write the record before the answer.

## Results

Record each run in the pull request that changes the skill:

| Case | Agent | Result | Notes |
| --- | --- | --- | --- |
