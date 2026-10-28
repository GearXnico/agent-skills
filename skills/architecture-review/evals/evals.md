# architecture-review evals

Run cases 1 to 3 on the `services` branch of [agent-skills-sandbox](https://github.com/GearXnico/agent-skills-sandbox) and case 4 on `trunk`, in at least two agents. The `services` branch describes an order system (web, api, worker, Postgres, Redis) through `compose.yml`, service READMEs and one accepted ADR, with known flaws. Start each case from a fresh clone with the skill installed. A case passes when the agent does everything under "Expected" and nothing under "Must not".

Known flaws in `services`, used by the cases below:

| Flaw | Evidence |
| --- | --- |
| Secrets written in the repository | `compose.yml`: `POSTGRES_PASSWORD`, `PAYMENT_API_KEY`, passwords in `DATABASE_URL` |
| A failed job retries at once, with no limit, and charging is not idempotent: a crash after the charge charges again | `worker/README.md` |
| Anyone with an order id can read the order; no authentication | `api/README.md` |
| Redis published on the host without a password | `compose.yml`: `6379:6379` |
| Both services use the database superuser on one shared schema | `compose.yml`, ADR 0001 |
| No health checks; `worker` does not wait for `db` | `compose.yml` |
| No database backups | Nothing in the repository |

## 1. General review

- **Request:** "Review the architecture of this system."
- **Expected:** a Mermaid map with the five components and the payment provider; findings with severity and `file:line` evidence that include at least the first three flaws as high; the missing backups as a finding or an open question; secrets named by file and line.
- **Must not:** print secret values; change any file; report a finding without evidence.

## 2. Ready for growth

- **Request:** "We expect 5,000 orders a day after the launch. Is the architecture ready?"
- **Expected:** estimates the load in numbers (about one order every 17 seconds) and says the current design handles it; puts the retry and idempotency flaw first, because more volume means more duplicate charges.
- **Must not:** recommend new infrastructure (Kafka, Kubernetes, splitting services, a cache) for this load.

## 3. Review a proposal

- **Request:** "Review this proposal: split the worker into a payments service and an email service, each with its own database."
- **Expected:** evaluates the proposal against the current system and ADR 0001; names what it costs (two more databases, a contract between services) and what it solves; points out that it does not fix the retry and idempotency flaw; suggests a decision record if the proposal goes ahead.
- **Must not:** approve or reject it without reasons tied to requirements; edit ADR 0001.

## 4. Little architecture

- **Branch:** `trunk` (a static page).
- **Request:** "Review the architecture."
- **Expected:** a short report that says it is a single static page and lists only what applies (for example, how it is served), or asks what the review is for.
- **Must not:** invent components, databases or load numbers.

## Results

Record each run in the pull request that changes the skill:

| Case | Agent | Result | Notes |
| --- | --- | --- | --- |
