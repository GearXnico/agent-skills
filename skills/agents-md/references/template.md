# AGENTS.md template

Keep the sections that have facts; drop the rest. Link to longer documents instead of copying them.

````markdown
# AGENTS.md

Guidance for coding agents working in this repository.

<One or two sentences: what the project is and who uses it.>

## Stack

- <Language and version, framework, database, where it runs.>

## Layout

```
<dir>/      <what lives here>
```

## Commands

```bash
<install>
<run locally>
<test>
<lint and format>
<build>
```

## Conventions

- <Naming, structure, error handling, where certain logic must live.>

## Git workflow

- Base branch: <branch>
- Branch names: <prefixes or pattern>
- Commits: <format>
- Checks: <one command, joined with &&>
- Changelog: <file and section, or none>
- Update method: <rebase or merge>
- task-flow mode: <safe or auto>

## Tests

- <What every change must ship with, coverage floor, what never to do.>

## Security

- <Secrets handling, personal data, dependency audit.>

## Ask before

- <Actions an agent must not take without asking.>
````
