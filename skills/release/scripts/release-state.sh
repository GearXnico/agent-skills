#!/usr/bin/env sh
# Usage: release-state.sh <release-branch> [integration-branch] (run from the repository root)
# Prints what a release needs: last version, [Unreleased] section, commits since
# the last version, files that declare a version, and branch divergence.
[ "$#" -ge 1 ] || { echo "usage: release-state.sh <release-branch> [integration-branch]" >&2; exit 2; }
rel=$1; int=${2:-$1}
git fetch -q --tags origin "$rel" "$int" 2>/dev/null
r=origin/$rel; i=origin/$int
git rev-parse -q --verify "$r" >/dev/null || r=$rel
git rev-parse -q --verify "$i" >/dev/null || i=$int
echo "== Last tag on $r"
tag=$(git describe --tags --abbrev=0 "$r" 2>/dev/null) && echo "$tag" || echo "none"
changelog=$(git ls-tree --name-only "$i" | grep -iE '^(changelog|changes|history)(\.md)?$' | head -1)
if [ -n "$changelog" ]; then
  echo "== Versions in $changelog (on $i)"
  git show "$i:$changelog" | grep -E '^## ' | head -4
  echo "== [Unreleased] section"
  git show "$i:$changelog" | awk '/^## \[?Unreleased/ {p=1; next} /^## / {p=0} p' | grep . | head -40
fi
echo "== Commits on $i since ${tag:-$r}"
if [ -n "$tag" ]; then git log --oneline --no-merges "$tag..$i" | head -50
else git log --oneline --no-merges "$r..$i" | head -50; fi
echo "== Files that declare a version"
for f in VERSION version.txt package.json pyproject.toml setup.cfg Cargo.toml composer.json pom.xml build.gradle build.gradle.kts mix.exs pubspec.yaml Chart.yaml; do
  git cat-file -e "$i:$f" 2>/dev/null || continue
  line=$(git show "$i:$f" | grep -m1 -nE '^[0-9]+\.[0-9]+|"version"|^version|<version>' | cut -c1-80)
  [ -n "$line" ] && echo "$f:$line"
done
git ls-tree -r --name-only "$i" | grep -E '(^|/)version\.(rb|py|go|ts|js)$' | head -5
if [ "$rel" != "$int" ]; then
  echo "== $i compared with $r"
  echo "commits only on $i: $(git rev-list --count "$r..$i")"
  echo "commits only on $r: $(git rev-list --count "$i..$r")"
  ahead=$(git log --format=%s "$i..$r" --no-merges | head -20)
  [ -n "$ahead" ] && { echo "subjects only on $r (same subject on both sides means rewritten hashes):"; printf '%s\n' "$ahead"; }
fi
exit 0
