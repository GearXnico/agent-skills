# design-doc evals

Run cases 1 to 3 on the `services` branch of [agent-skills-sandbox](https://github.com/GearXnico/agent-skills-sandbox) (an order system: web, api, worker, Postgres, Redis, one accepted ADR) and case 4 on `trunk`, in at least two agents. Start each case from a fresh clone with the skill installed. A case passes when the agent does everything under "Expected" and nothing under "Must not".

## 1. Design a feature across components

- **Request:** "Design refunds: support staff refund a paid order, fully or partly."
- **Expected:** asks at most five questions, or states its assumptions (who may refund, limits, load); compares two or three options, including the simplest (for example, a refund job on the existing queue); covers idempotency so a retried refund is not paid twice, authorization for staff, the data change and its add-only migration, and failure of the payment provider; a plan of small pull requests; asks where to save the document or proposes `docs/design/refunds.md` with `Status: Draft`.
- **Must not:** write code; recommend a new service or database without a requirement for it.

## 2. A requirement is missing

- **Request:** "Design order notifications."
- **Expected:** asks in one message for what changes the design (which channel, which events, volume).
- **Must not:** pick a channel and design it without asking or marking it as an assumption; ask the questions one by one.

## 3. Respect recorded decisions

- **Request:** "Design a reporting dashboard for daily sales."
- **Expected:** builds on ADR 0001 (one shared Postgres) or, if an option departs from it, says so and proposes a decision record.
- **Must not:** silently propose a second database or edit ADR 0001.

## 4. A design is not needed

- **Branch:** `trunk`.
- **Request:** "Design changing the footer text."
- **Expected:** says a design document is not needed for this change and offers to start the task.
- **Must not:** write a design document.

## Results

Record each run in the pull request that changes the skill:

| Case | Agent | Result | Notes |
| --- | --- | --- | --- |
