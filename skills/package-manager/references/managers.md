# Manager guide

Supported now: Python and JavaScript. Other ecosystems are listed in [todo.md](todo.md).

Facts about managers change: check the manager's own documentation for the current command before running it, and prefer its migration guide when one exists.

## Choosing

Score each candidate against what the project needs, not against popularity.

| Criterion | Ask |
| --- | --- |
| Workspaces | Does the repository hold several packages that depend on each other? |
| Reproducible installs | Does it produce a lockfile that pins every transitive version, and can CI install strictly from it? |
| Speed | How long do installs take in CI and container builds today, and does that matter here? |
| Python versions or Node versions | Does it need to manage the runtime version too? |
| Publishing | Does the project publish a package to a registry? |
| Maturity and support | Is it maintained, documented and supported by the platforms this project deploys to? |
| Team | What does the team already know, and what do sibling repositories use? |

## Python

| Manager | Lockfile | Fits when |
| --- | --- | --- |
| uv | `uv.lock` | Most new projects: fast installs, manages Python versions, workspaces, standard `pyproject.toml` |
| Poetry | `poetry.lock` | Teams already on it, or projects that publish packages and use its plugins |
| pip with pip-tools | `requirements.txt` compiled from `requirements.in` | Minimal tooling, or environments where only pip is allowed |

Migration notes:

- **Poetry to uv:** move dependencies from `[tool.poetry.dependencies]` and dependency groups to `[project.dependencies]` and `[dependency-groups]` (PEP 621 and PEP 735); translate caret and tilde constraints to explicit ranges (`^8.1` becomes `>=8.1,<9`); move scripts to `[project.scripts]`; choose a build backend if the project is packaged. Then `uv lock`, and replace `poetry install` / `poetry run` with `uv sync` / `uv run`.
- **pip to uv or Poetry (adopt):** create `pyproject.toml` from `requirements.txt`. Pin each package to the version currently installed or resolved, so adoption does not upgrade anything; separate test tools into a development group.
- In containers, install the manager at a pinned version, copy the manifest and lockfile before the source, and install from the lockfile only (`uv sync --frozen`, `poetry install --no-root` with the lockfile).

## JavaScript

| Manager | Lockfile | Fits when |
| --- | --- | --- |
| npm | `package-lock.json` | Default with Node; no extra tool to install |
| pnpm | `pnpm-lock.yaml` | Workspaces and monorepos, disk and install speed, strict dependency resolution |
| Yarn (Berry) | `yarn.lock` | Teams already on it, or Plug'n'Play needs |
| Bun | `bun.lock` | Projects that also use the Bun runtime |

Migration notes:

- **npm or Yarn to pnpm:** `pnpm import` builds `pnpm-lock.yaml` from the existing lockfile, keeping versions. Move workspaces to `pnpm-workspace.yaml`. pnpm's strict resolution can expose undeclared dependencies: add them explicitly instead of loosening the setting.
- Set the `packageManager` field in `package.json` so Corepack and CI use the same version.
- Replace `npm ci` with `pnpm install --frozen-lockfile` in CI and containers.
