# Changelog

New changes go under `[Unreleased]` and get a version number when a release is cut. The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and versions follow [SemVer](https://semver.org/): a new skill bumps MINOR, a change that alters a skill's expected behaviour bumps MAJOR, anything else bumps PATCH.

## [Unreleased]

### Added

- `architecture-review` skill: maps an existing system or a proposed design (Mermaid diagram, components, data, trust boundaries) from a cheap repository inventory script, then reports up to ten ranked findings with evidence and the smallest fix, using a checklist across security, reliability, data, scalability, operability, maintainability and cost. Four evals on the sandbox `services` scenario.
- `docs-sync` skill: finds the documentation a change left out of date from the diff, with a script that greps only the matching lines, and updates it or only reports it; never edits an accepted ADR. Four evals on the sandbox `docs` scenario.
- `fix-with-test` skill: reproduces a bug with a failing test, commits it, then makes the smallest fix that turns it green, with four evals on the sandbox `bugfix` scenario.
- `task-flow` skill: takes a change from branch to pull request following the repository's `## Git workflow` rules, with `safe` and `auto` modes, tasks read from a key or link when the agent can reach the tracker, rebase or merge updates after a merge, a script that reads only the workflow section, and seven evals.
- Design principles for every skill in `CONTRIBUTING.md`: spend few tokens and steer the agent to good coding practices.
- Repository foundation: README with install steps per agent, MIT license, contributing guide, pull request template and CI that validates every skill against the Agent Skills specification.
