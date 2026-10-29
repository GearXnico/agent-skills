# Scanners

Use this only when the repository declares no scanner. Pick one or two that fit the stack; propose them, run them only after the user accepts, and never install them into the project.

## Temporary runs

| Need | Tool | Run without installing into the project |
| --- | --- | --- |
| Secrets in the change | gitleaks | `docker run --rm -v "$PWD:/repo" zricethezav/gitleaks git /repo --log-opts="<base>..HEAD"`, or a local `gitleaks git --log-opts="<base>..HEAD"` |
| Code patterns, many languages | semgrep | `docker run --rm -v "$PWD:/src" semgrep/semgrep semgrep scan --config auto --baseline-commit <base>`, or `pipx run semgrep scan --config auto --baseline-commit <base>` |
| Python | bandit | `pipx run bandit -r <changed paths>` |
| Ruby on Rails | brakeman | `gem exec brakeman --no-pager` if available, otherwise `docker run --rm -v "$PWD:/code" presidentbeef/brakeman --color` |
| Dependencies, any lockfile | osv-scanner | `docker run --rm -v "$PWD:/src" ghcr.io/google/osv-scanner scan source -r /src` |

Pin the image or package version the repository would use, if it pins others. Report the exact command you ran.

## Integration, after approval

Prepare the change, show it, and apply it only when the user approves. Prefer the place the repository already uses for checks.

**pre-commit** (`.pre-commit-config.yaml`):

```yaml
- repo: https://github.com/gitleaks/gitleaks
  rev: <latest release tag>
  hooks:
    - id: gitleaks
```

**GitHub Actions** (a step in the existing check job):

```yaml
- uses: actions/checkout@<pinned sha>
  with:
    fetch-depth: 0
- run: docker run --rm -v "$PWD:/repo" zricethezav/gitleaks:<version> git /repo
```

For other CI systems, add the same command as a step of the existing check job. Add the tool's line to `Checks:` in `## Git workflow` (with `agents-md` if installed).
