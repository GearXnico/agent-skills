# Decision record template

Use this only when the repository has no format of its own.

```markdown
# <Number>. <Decision as a short phrase>

Status: Proposed · Date: <YYYY-MM-DD>

## Context

<The problem, the forces and the constraints.>

## Options

1. **<Option>:** <main benefit>; <main cost>.
2. **<Option>:** <main benefit>; <main cost>.
3. **Do nothing:** <what happens if nothing changes>.

## Decision

We will <chosen option>, because <reason>.

## Consequences

- Better: <what improves>.
- Worse: <what gets harder or costs more>.
- Revisit when: <the condition that would change this decision>.
```

When a record replaces another, add `Supersedes <number>` under the status line, and set the old record's status to `Superseded by <number>`.
