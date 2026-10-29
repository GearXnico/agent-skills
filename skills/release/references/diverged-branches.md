# Diverged branches

With rebase or squash merges, the commits that reach the release branch get new hashes. The integration branch keeps the old ones, so after a release the two branches share content but not history, and the next release pull request shows old commits again or conflicts.

Signs: the state script prints commits only on the release branch whose subjects also appear on the integration branch.

## Build the release from the release branch

1. Create `release/x.y.z` from the release branch (not from the integration branch).
2. List the commits on the integration branch that are new since the last release (compare by subject or pull request number, not by hash).
3. Cherry-pick them in order with `git cherry-pick -x <sha>...`. Resolve conflicts the way the repository says; for the changelog, keep every entry.
4. Close the changelog and bump the version as usual, run the checks, open the pull request to the release branch.
5. After the merge, the back-merge (release branch into integration branch) realigns the two.

## Prevent it

Suggest, once and without changing anything, one of: merge commits for release pull requests, or resetting the integration branch to the release branch after each release, if the repository's rules allow it. The choice belongs to the maintainer.
