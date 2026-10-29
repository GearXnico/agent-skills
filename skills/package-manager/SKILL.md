---
name: package-manager
description: Switches a project to another package manager (for example Poetry to uv, or npm to pnpm), or adopts one when the project has none, recommending the best fit for its architecture. Keeps every dependency version, updates scripts, CI, containers and docs, and delivers a reversible pull request. Use when the user wants to change, migrate to, adopt or choose a package manager.
license: MIT
metadata:
  version: "0.1.0"
---

# package-manager

Change how a project installs its dependencies, once, without changing what it installs. Routine updates belong to `dependency-update`; this skill changes the tool.

Two modes:

- **Migrate:** from one manager to another in the same ecosystem.
- **Adopt:** the project has no manager (a loose requirements file, packages installed by hand). Use the user's preference if they have one; otherwise recommend one.

Supported ecosystems: see [the manager guide](references/managers.md). For any other ecosystem, say it is not covered yet and stop; [the to-do list](references/todo.md) tracks what comes next.

## 1. Inventory

Find, without reading the whole repository:

- Languages, manifests and lockfiles, and whether it is a monorepo or uses workspaces.
- Every place that installs or runs dependencies: package scripts, make targets, CI workflows, container files, deploy configuration, pre-commit hooks.
- The docs and `AGENTS.md` lines that mention the current commands.

A search for the current manager's name and its lockfile name finds most of them.

## 2. Recommend (adopt mode, or when asked)

Compare two or three managers in a table against what this project needs, using the criteria in [the manager guide](references/managers.md): workspace support, reproducible lockfile, CI and container speed, maturity, and what the team already knows. Recommend one, with the reasons. Say what would change the choice.

## 3. Plan and ask

List the files that will change, the commands that replace the old ones, and the risks (for example versions the new manager resolves differently, or a feature the old one had that the new one lacks). Do not change anything until the user approves.

## 4. Migrate the dependencies

1. Convert the manifest to the new manager's format with its own import or init command when it has one.
2. Generate the new lockfile with the manager. Never write a lockfile by hand.
3. Compare the resolved versions before and after. Every direct and transitive version should match; list any that changed and why. Pin back what changed unless the user accepts it.
4. Remove the old lockfile and manager configuration in the same change, so only one lockfile is alive.

## 5. Update what uses it

Replace the old commands in scripts, CI, container files, deploy configuration, `AGENTS.md` (the `Checks` rule and the commands section) and the docs. With `agents-md` or `docs-sync` installed, use them for the last two.

## 6. Verify

Install from a clean state (fresh clone or empty environment), run every check, and build the container if there is one. If a step cannot run here (for example no container runtime), say so.

## 7. Deliver

Small commits: manifest and lockfile, then CI and containers, then docs. Open the pull request with `task-flow` if installed. In the report, state the version comparison and how to revert. If the change touches deploys or several services, propose a design document (`design-doc`) or a decision record (`new-adr`) first.

## Never

- Change a dependency's version as a side effect of the migration without saying so.
- Leave two lockfiles or two managers' configurations alive.
- Write or edit a lockfile by hand.
- Switch managers, or add one, without the user's approval.
- Skip, disable or loosen a check to get green.
