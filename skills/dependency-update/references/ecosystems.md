# Commands by package manager

Use the row of each manager the repository uses. Prefer a project script (package script, make target) when one wraps these.

| Manager (lockfile) | List outdated | Audit | Update one package |
| --- | --- | --- | --- |
| npm (`package-lock.json`) | `npm outdated` | `npm audit` | `npm install <pkg>@<version>` |
| pnpm (`pnpm-lock.yaml`) | `pnpm outdated` | `pnpm audit` | `pnpm add <pkg>@<version>` |
| Yarn (`yarn.lock`) | `yarn outdated` (v1), `yarn upgrade-interactive` (v2+) | `yarn npm audit` (v2+), `yarn audit` (v1) | `yarn add <pkg>@<version>` |
| Bun (`bun.lock`) | `bun outdated` | `bun audit` | `bun add <pkg>@<version>` |
| uv (`uv.lock`) | `uv tree --outdated` | `uvx pip-audit` | `uv add <pkg>==<version>` or `uv lock --upgrade-package <pkg>` |
| Poetry (`poetry.lock`) | `poetry show --outdated` | `pip-audit` in the environment | `poetry add <pkg>@<version>` |
| pip (`requirements*.txt`) | `pip list --outdated` | `pip-audit -r requirements.txt` | Change the pin, then `pip install -r requirements.txt` |
| Bundler (`Gemfile.lock`) | `bundle outdated` | `bundle exec bundler-audit check --update` | `bundle update <gem> --conservative` |
| Go modules (`go.sum`) | `go list -m -u all` | `govulncheck ./...` | `go get <module>@<version> && go mod tidy` |
| Cargo (`Cargo.lock`) | `cargo outdated` (plugin) | `cargo audit` (plugin) | `cargo update -p <crate> --precise <version>` |
| Maven (`pom.xml`) | `mvn versions:display-dependency-updates` | OWASP `dependency-check` plugin | Change the version in `pom.xml` |
| Gradle (`*.lockfile`, `build.gradle`) | `gradle dependencyUpdates` (plugin) | OWASP `dependency-check` plugin | Change the version, then `gradle dependencies --write-locks` |
| Composer (`composer.lock`) | `composer outdated --direct` | `composer audit` | `composer require <pkg>:<version>` |
| NuGet (`packages.lock.json`, `*.csproj`) | `dotnet list package --outdated` | `dotnet list package --vulnerable` | `dotnet add package <pkg> --version <version>` |

If a tool marked "plugin" is not installed, ask before installing it.

Container base images and CI actions are dependencies too: update their tags or digests in their own steps, and keep actions pinned to a full commit SHA if the repository already does.
