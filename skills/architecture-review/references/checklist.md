# Architecture checklist

Use the sections that match what the review is for. Each line is a question; a "no" with evidence is a finding.

## Security

- Are secrets kept out of the repository, images and logs (environment, secret store)?
- Is every endpoint that reads or changes private data authenticated and authorized per resource, not only per user?
- Are identifiers that grant access unguessable, or checked against the caller?
- Is only what must be public exposed (ports, admin panels, databases, queues, caches)?
- Does each component use its own credentials with the least privilege it needs?
- Is input validated at every trust boundary, and is personal data minimized and kept out of logs?
- Are dependencies and base images pinned and scanned?

## Reliability

- What happens when each dependency is slow or down: timeouts, retries with backoff and a limit, a dead-letter path?
- Are operations that touch money or external systems idempotent, so a retry cannot repeat them?
- Are there single points of failure the stated uptime goal cannot accept?
- Do containers or processes have health checks and restart policies, and do dependants wait for health, not just start?
- Is there a way to roll back a bad deploy?

## Data

- Which component owns each piece of data? Is any table written by more than one component?
- Are schema changes backward compatible across components deployed separately?
- Are there backups, are they tested by a restore, and are they stored apart from the data?
- Is data retained only as long as needed, and can personal data be deleted on request?

## Scalability

- At the stated load, what saturates first (database connections, a single worker, a rate-limited external API)?
- Does the expected growth actually need more than the current design? Estimate with numbers.
- Is work that can be slow moved off the request path?

## Operability

- Can someone tell the system is broken before users do (logs with request ids, metrics, alerts)?
- Is configuration per environment, outside the code?
- Can a new developer run it locally with one documented command?
- Are deploys automated and repeatable?

## Maintainability

- Do component boundaries match how the code changes (things that change together live together)?
- Is coupling explicit (an API or a contract) rather than hidden (a shared table, a shared file)?
- Do the decision records still match the code?
- Is there complexity no requirement asks for?

## Cost

- What does the system cost at the current and expected load, and which component dominates?
- Is anything paid for and idle?
