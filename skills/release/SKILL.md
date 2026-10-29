---
name: release
description: Prepares a release following the repository's own flow - finds what changed since the last version, proposes the version number from the repository's versioning rules, closes the changelog, bumps the version files and opens the release pull request; after the merge, gives the exact tag and back-merge commands for the maintainer to run. Use when the user asks to cut, prepare or ship a release or a new version, or to write release notes.
license: MIT
metadata:
  version: "0.1.0"
---

# release

Get a release ready for the maintainer to merge and tag. The skill prepares; the maintainer publishes. It never merges, tags or publishes anything.

## 1. Read the rules

| Need | Where to look | If missing |
| --- | --- | --- |
| Release flow | A `Release:` line in the `## Git workflow` section of `AGENTS.md` (for example "git-flow; `release/x.y.z` from develop, pull request to main, then back-merge" or "trunk; pull request to main that bumps the version") | Deduce it from `CONTRIBUTING.md`, the changelog guide and the release workflows; show it as a proposal, confirm it once, and offer to add the line (with `agents-md` if installed) |
| Versioning | The changelog guide, `CONTRIBUTING.md`, decision records, past tags and changelog headings: the scheme (SemVer, CalVer or other), whether versions are set per pull request or only at release time, and which files declare the version | Suggest SemVer with an `[Unreleased]` section, as a proposal |
| Base, checks, commit format | `## Git workflow` | Ask |
| Release pull request template | `.github/PULL_REQUEST_TEMPLATE/`, or the repository's equivalent | Use the normal template |

## 2. Check the state

Run this skill's `scripts/release-state.sh <release-branch> <integration-branch>` from the repository root (one branch name twice for a trunk flow). It prints the last version found (tags, changelog, version files), the `[Unreleased]` section, the commits since the last version, the files that declare it, and whether the two branches have diverged.

Stop and say why if the checks fail on the base, or if nothing changed since the last version.

## 3. Propose the version

Follow the scheme the repository uses. With SemVer: a breaking change (a `!` or `BREAKING CHANGE` in a commit, a "Breaking" changelog entry, a removed or renamed public interface) is MAJOR, a new feature is MINOR, anything else is PATCH; before 1.0.0, follow what the repository's guide says. Give the number and the reason in one line and wait for the user to confirm it.

## 4. Prepare the release

1. Create the release branch if the flow uses one, from the branch the flow names, after fetching it.
2. Close the changelog the way the repository does it: usually move `[Unreleased]` under the new version with today's date, leave an empty `[Unreleased]`, and update the comparison links. Take every entry from the changelog and the merged pull requests; never write an entry nothing supports.
3. Bump the version only in the files that already declare it.
4. Run the checks. Commit as the repository's format asks (for example `chore: release 1.3.0`).

## 5. Open the pull request

Push the release branch and open the pull request against the branch the flow names, with the release template if there is one. Its body holds the release notes: the changes grouped by type, written for the people who use the product, and a "Breaking" section with upgrade steps when there is one. Open it with `task-flow` if installed. Reply with the link.

## 6. After the merge

When the user says the release pull request was merged:

- Give the exact commands for the tag and the release (for example `git tag -a v1.3.0 <sha> -m "1.3.0"`, `git push origin v1.3.0`, and the hosting tool's release command with the notes), for the maintainer to run.
- If the flow has a back-merge, open that pull request.
- If the integration branch and the release branch have diverged (the script reports it; rebase or squash merges rewrite hashes), build the next release from the release branch and cherry-pick only the new commits. See [diverged branches](references/diverged-branches.md).

## Never

- Create or push a tag, publish a package or a release, or merge a pull request.
- Push to the release branch or the integration branch directly.
- Invent changelog entries or release notes.
- Pick the version without the user's confirmation.
- Continue with failing checks.
