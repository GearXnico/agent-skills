# Design document template

```markdown
# <Title>

Status: Draft · Author: <name> · Date: <YYYY-MM-DD>

## Problem

<Who has the problem and what happens today.>

## Goals

- <Outcome this change must achieve.>

## Non-goals

- <What this change will not do.>

## Requirements

| Requirement | Target | Source |
| --- | --- | --- |
| <Functional or non-functional> | <number or behaviour> | <user, decision record, assumption> |

## Options

| | Option A (simplest) | Option B | Option C |
| --- | --- | --- | --- |
| <Requirement 1> | | | |
| Effort | | | |
| Risk | | | |
| Cost | | | |

## Recommendation

<One option and why. What would change the choice.>

## Design

- **Interfaces:** <endpoints, events, signatures>
- **Data:** <tables or schemas, migrations (add-only first)>
- **Failure modes:** <dependency → what happens → how it recovers>
- **Security and privacy:** <authentication, authorization, input validation, personal data>
- **Testing:** <unit, integration, end to end>
- **Observability:** <logs, metrics, alerts>
- **Rollout and rollback:** <flag, migration order, how to undo>

## Plan

1. <Pull request 1: what it ships, with its tests>
2. <Pull request 2>

## Open questions

- <Question, and who can answer it.>

## Decisions to record

- <Decision record title>
```

Keep each section to what the change needs; write "None" rather than padding.
