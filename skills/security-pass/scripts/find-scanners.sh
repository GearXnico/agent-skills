#!/usr/bin/env sh
# Usage: find-scanners.sh (run from the repository root)
# Lists the security tools the repository declares (CI, pre-commit, package
# scripts, build files) and which common ones are installed on this machine.
tools='gitleaks|trufflehog|detect-secrets|semgrep|bandit|brakeman|bundler-audit|bundle-audit|pip-audit|safety|npm audit|pnpm audit|yarn audit|osv-scanner|trivy|grype|snyk|codeql|gosec|govulncheck|cargo audit|cargo-audit|cargo deny|cargo-deny|dependency-check|spotbugs|psalm|phpstan|eslint-plugin-security|hadolint|checkov|tfsec|zizmor'
files=$(git ls-files | grep -E '^\.github/workflows/|^\.gitlab-ci|^\.circleci/|^azure-pipelines|^Jenkinsfile|^\.pre-commit-config|^package\.json$|^pyproject\.toml$|^Makefile$|^Rakefile$|^Gemfile$|^justfile$|^Taskfile|^\.semgrep|^\.gitleaks|^\.bandit|^\.snyk')
echo "== Declared"
found=0
for f in $files; do
  [ -f "$f" ] || continue
  matches=$(grep -inoE "$tools" "$f" | sort -t: -k2,2 -uf | head -10)
  [ -n "$matches" ] && { printf '%s\n' "$matches" | sed "s|^|$f:|"; found=1; }
done
[ "$found" -eq 1 ] || echo "none"
echo "== Installed"
for t in gitleaks trufflehog semgrep bandit brakeman bundler-audit pip-audit osv-scanner trivy gosec govulncheck; do
  command -v "$t" >/dev/null 2>&1 && echo "$t"
done
exit 0
