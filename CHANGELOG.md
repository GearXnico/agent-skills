# Changelog

New changes go under `[Unreleased]` and get a version number when a release is cut. The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and versions follow [SemVer](https://semver.org/): a new skill bumps MINOR, a change that alters a skill's expected behaviour bumps MAJOR, anything else bumps PATCH.

## [Unreleased]

### Added

- `task-flow` skill: takes a change from branch to pull request following the repository's `## Git workflow` rules, with `safe` and `auto` modes, rebase or merge updates after a merge, a script that reads only the workflow section, and six evals.
- Design principles for every skill in `CONTRIBUTING.md`: spend few tokens and steer the agent to good coding practices.
- Repository foundation: README with install steps per agent, MIT license, contributing guide, pull request template and CI that validates every skill against the Agent Skills specification.
