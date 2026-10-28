#!/usr/bin/env sh
# Prints the facts an AGENTS.md is built from (run from the repository root):
# existing agent files, manifests, declared commands, CI steps and git habits.
# The agent reads this output instead of exploring the repository.
echo "== Agent instruction files"
for f in AGENTS.md CLAUDE.md GEMINI.md .cursorrules .github/copilot-instructions.md; do
  [ -f "$f" ] && { echo "-- $f ($(wc -l < "$f") lines), headings:"; grep -E '^#{1,3} ' "$f"; }
done

echo "== Manifests and build files"
git ls-files | grep -Ei '(^|/)(package\.json|pyproject\.toml|requirements[^/]*\.txt|go\.mod|Cargo\.toml|pom\.xml|build\.gradle(\.kts)?|Gemfile|composer\.json|[^/]*\.csproj|mix\.exs|Makefile|justfile|Taskfile\.ya?ml|(docker-)?compose[^/]*\.ya?ml|Dockerfile|\.pre-commit-config\.yaml|\.editorconfig)$' | head -30

echo "== Declared commands"
git ls-files | grep -E '(^|/)package\.json$' | head -5 | while IFS= read -r f; do
  echo "-- $f scripts:"
  sed -n '/"scripts"[[:space:]]*:/,/}/p' "$f" | grep -E '^[[:space:]]*"[^"]+"[[:space:]]*:' 
done
git ls-files | grep -E '(^|/)(Makefile|justfile)$' | head -3 | while IFS= read -r f; do
  echo "-- $f targets:"; grep -E '^[A-Za-z0-9_.-]+:' "$f" | cut -d: -f1 | head -20
done

echo "== CI steps"
git ls-files | grep -E '^\.github/workflows/.*\.ya?ml$|^\.gitlab-ci\.yml$' | while IFS= read -r f; do
  echo "-- $f"; grep -E '^[[:space:]]*(- )?run:' "$f" | sed 's/^[[:space:]]*//' | head -15
done

echo "== Git habits"
echo "default branch: $(git symbolic-ref --short refs/remotes/origin/HEAD 2>/dev/null | sed 's|^origin/||')"
echo "remote branches: $(git branch -r --format='%(refname:short)' 2>/dev/null | sed 's|^origin/||' | grep -vxE 'HEAD|origin' | head -15 | tr '\n' ' ')"
echo "last commits:"; git log --format='  %s' -15 2>/dev/null
for f in CHANGELOG.md .github/pull_request_template.md .github/PULL_REQUEST_TEMPLATE.md CONTRIBUTING.md; do
  [ -f "$f" ] && echo "has $f"
done
exit 0
