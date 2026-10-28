# Git workflow section

Add this section to the repository's `AGENTS.md` and fill in each value. Agents that read `CLAUDE.md` instead can import it with a line containing `@AGENTS.md`.

```markdown
## Git workflow

- Base branch: main
- Branch names: feature/, fix/, docs/, chore/
- Commits: Conventional Commits
- Checks: npm test && npm run lint
- Changelog: CHANGELOG.md, under [Unreleased]
- Update method: rebase
- task-flow mode: safe
```

| Rule | Accepted values |
| --- | --- |
| Base branch | Any branch name |
| Branch names | Prefixes, a pattern, or "any short lowercase name" |
| Commits | A format name (Conventional Commits) or a short description |
| Checks | One shell command; join several with `&&` |
| Changelog | A file and section, or `none` |
| Update method | `rebase` (rewrites the branch, pushed with `--force-with-lease`) or `merge` (keeps history, normal push) |
| task-flow mode | `safe` asks before every push; `auto` pushes and opens pull requests without asking |
