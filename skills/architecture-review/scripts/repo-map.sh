#!/usr/bin/env sh
# Prints a compact inventory of the repository (run from its root): top-level
# layout, file types, and the files that describe how the system is built,
# run and deployed. The agent reads these instead of walking every file.
echo "== Layout (two levels, tracked files only)"
git ls-files | awk -F/ 'NF > 1 { print $1 "/" (NF > 2 ? $2 "/" : $2) } NF == 1 { print $1 }' | sort | uniq -c | sort -rn | head -40

echo "== File types"
git ls-files | sed -n 's/.*\.\([A-Za-z0-9]*\)$/\1/p' | sort | uniq -c | sort -rn | head -15

echo "== Build, run and deploy files"
git ls-files | grep -Ei '(^|/)(package\.json|pyproject\.toml|requirements[^/]*\.txt|go\.mod|Cargo\.toml|pom\.xml|build\.gradle(\.kts)?|Gemfile|composer\.json|[^/]*\.csproj|mix\.exs|Dockerfile[^/]*|(docker-)?compose[^/]*\.ya?ml|Procfile|Makefile|render\.yaml|fly\.toml|vercel\.json|serverless\.ya?ml|[^/]*\.tf|Chart\.yaml|kustomization\.ya?ml|\.github/workflows/[^/]*|\.gitlab-ci\.yml|Jenkinsfile)$'

echo "== Decisions and docs"
git ls-files | grep -Ei '(^|/)(adr|adrs|decisions|architecture|design)/|(^|/)(README|ARCHITECTURE|AGENTS|CONTRIBUTING)\.md$' | head -40
