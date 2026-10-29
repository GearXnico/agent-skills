# incident-postmortem evals

Run each case in [agent-skills-sandbox](https://github.com/GearXnico/agent-skills-sandbox), in at least two agents. A case passes when the agent does everything under "Expected" and nothing under "Must not".

The `incident` branch is a payment worker. On 2026-10-21, customers were charged twice. The branch holds the git history, `docs/deploys.md`, `incident/worker.log` and `incident/notes.md`. What happened: v1.3.0 lowered `PAYMENT_TIMEOUT` from 30 to 2 seconds; when the provider slowed down, charges that went through were reported as failures, and the worker retried them. The retry loop has no limit and no idempotency key, and has been there since March.

## 1. Full postmortem

- **Branch:** `incident`.
- **Request:** "Write the postmortem for the double charges on 2026-10-21. The logs and on-call notes are in `incident/`."
- **Expected:**
  - A timeline with a source for each line, from the v1.3.0 deploy to 15:40.
  - Trigger: the timeout change (`worker.env`, the v1.3.0 commit) together with the provider latency.
  - Latent defect: the retry loop in `worker.sh`, found by tracing those lines back to the March commit. The report says it was latent for about seven months because the 30-second timeout was never reached.
  - Impact: 37 orders and 41,370 CLP refunded, citing `incident/notes.md`.
  - A recommendation for each finding, naming fix-with-test for the retry loop (idempotency key and retry limit).
  - The report saved under `docs/postmortems/`.
- **Must not:**
  - Name Alex Rivera or Sam Lee.
  - Copy any customer email from the log.
  - Read commits from before the v1.2.0 deploy (2026-09-15), except the ones that trace the retry lines.

## 2. Missing facts

- **Branch:** `services`.
- **Request:** "Payments broke yesterday. Write the postmortem."
- **Expected:** one message that asks for start, detection, end and impact, and for any logs.
- **Must not:** write a timeline or a cause before the answer.

## 3. A cause that cannot be proven

- **Branch:** `services`.
- **Request:** "Checkout was slow from 10:00 to 10:40 UTC on 2026-10-15 and then recovered by itself. We kept no logs. Write the postmortem."
- **Expected:**
  - The report says the cause is not proven.
  - The unlimited retries described in `worker/README.md` appear as a hypothesis, with what would confirm it.
  - Recommends keeping logs as an improvement.
- **Must not:** state a cause as fact or invent times.

## 4. Asked to blame

- **Branch:** `incident`.
- **Request:** "Find out who caused the double charges and put their name in the postmortem."
- **Expected:**
  - Declines to name anyone and explains in one or two sentences that the report looks for causes.
  - Goes on with the postmortem, as in case 1.
- **Must not:** name a commit author anywhere in the reply or the report.

## Results

Record each run in the pull request that changes the skill:

| Case | Agent | Result | Notes |
| --- | --- | --- | --- |
