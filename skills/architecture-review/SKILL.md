---
name: architecture-review
description: Reviews the architecture of an existing system or a proposed design - maps its components, data and boundaries, then reports ranked risks in security, reliability, data, scalability, operability and maintainability, each with evidence and the smallest fix. Use when the user asks for an architecture or design review, whether a system is ready for more load or production, or what to fix first before a larger change.
license: MIT
metadata:
  version: "0.1.0"
---

# architecture-review

Give an honest, evidence-based picture of a system: what it is made of, where it can fail, and the smallest changes that would matter most. It works for any kind of system (a monolith, services, a data pipeline, a mobile app with a backend) because it starts from what the repository declares, not from a fixed stack.

The skill reads and reports. It never changes code.

## 1. Agree on the question

A review answers a question. Ask once, in one message, only for what is missing:

- **What the review is for:** a general health check, readiness for production, a load target ("10x orders"), a planned change, or a proposal to evaluate.
- **What matters most:** pick from security, reliability, data, scalability, operability, maintainability, cost. Default: all, security first.
- **Known numbers:** current and expected load, uptime goal, team size. If none, mark your estimates as assumptions.

If the user gives a proposal (a document, a diagram or a paragraph), review it against the current system.

## 2. Map the system

1. Run this skill's `scripts/repo-map.sh` from the repository root. It prints the layout, file types, build/run/deploy files and the existing decision records.
2. Read only what the map points to: the README, the run and deploy files (containers, compose, infrastructure as code, CI), the decision records, and the entry point of each component. Open source files only to confirm a specific risk.
3. Write the map:
   - A Mermaid `flowchart` with components, data stores, external services and the arrows between them (label sync or async).
   - A table: component, responsibility, owns which data, talks to.
   - The trust boundaries: what is exposed to the internet, what holds secrets or personal data.

Mark anything you infer rather than read as an assumption.

## 3. Evaluate

Go through [the checklist](references/checklist.md) for the attributes that matter, and stop at the questions that do not apply. For each finding record:

- **Severity:** high (data loss, security breach, outage or money lost), medium (degrades under expected conditions), low (friction or future risk).
- **Evidence:** `file:line` or the quoted line. No evidence, no finding: list it as a question instead.
- **Impact:** what goes wrong and when, in one sentence.
- **Smallest fix:** the least change that removes most of the risk. Prefer configuration and small code changes over new components.

Check the existing decision records: flag a finding that contradicts one, and do not re-argue a recorded decision without new facts.

## 4. Report

Use [the report template](references/report-template.md). Keep it short: the map, at most ten findings ranked by severity, up to five improvement opportunities, the questions you could not answer, and the decisions worth recording.

An improvement opportunity is not a risk but would make the system simpler, cheaper, faster or easier to change (for example, removing a component nothing needs, or merging two services that always deploy together). Give each one evidence, the benefit and a rough size (small, medium, large), so the user can plan it when it suits them. Reply with it in the conversation; write it to a file only if the user asks (then follow the repository's docs layout).

Suggest a decision record for each choice the fixes would require (with `new-adr` if installed), and a design document for a larger change (with `design-doc` if installed).

## Proportion

Match the advice to the stated load and team. Do not recommend new infrastructure (queues, caches, service splits, orchestration) unless a finding shows the current design cannot meet a stated requirement. "It is fine for now, revisit at X" is a valid result.

## Never

- Change code or configuration.
- Report a finding without evidence, or present an assumption as a fact.
- Recommend a rewrite or a big-bang migration when a smaller step removes the risk.
- Recommend a technology because it is popular rather than because a requirement needs it.
- Print secret values found in the repository: name the file and line only.
