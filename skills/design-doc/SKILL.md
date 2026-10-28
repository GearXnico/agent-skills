---
name: design-doc
description: Turns a feature or system request into a short technical design before any code - requirements with numbers, two or three options with trade-offs, a recommendation, interfaces, risks, rollout and a plan split into small pull requests. Use when the user asks to design, plan or scope a feature, a new service or integration, or a change that touches several components, or asks how to build something before building it.
license: MIT
metadata:
  version: "0.1.0"
---

# design-doc

Agree on what to build and how, before writing code. A short design catches the expensive mistakes (a wrong data model, a missing requirement, an option nobody compared) while they are still cheap to fix, and splits the work into pull requests a reviewer can read.

The skill writes a document. It does not write code.

## 1. Decide whether a design is needed

Write one when the change adds a component, a data model, an external integration or a public interface, touches several components, or is hard to undo. For a small, local, reversible change, say a design is not needed and offer to start the task instead (with `task-flow` if installed).

## 2. Understand the problem

From the request, write:

- **Problem:** who has it and what happens today, in two or three sentences.
- **Goals and non-goals:** what this change must achieve, and what it explicitly will not.
- **Requirements:** functional ones, then non-functional ones with numbers (load, latency, availability, data size, cost limit, deadline). An unknown number becomes an explicit assumption.
- **Constraints:** what the repository already decided (decision records, stack, conventions in `AGENTS.md`).

Ask once, in one message, for what you cannot infer and that would change the design. Never more than five questions.

## 3. Read the context

Read only what the change touches: the components involved, their interfaces and data, and the related decision records. If `architecture-review` is installed and the system is unfamiliar, use its map step.

## 4. Write the design

Use [the template](references/template.md). Keep it under two pages.

- **Options:** two or three real ones, always including the simplest that meets the requirements. Compare them in a table against the requirements, not against taste.
- **Recommendation:** one option and why, in a few sentences. Say what would make you choose another.
- **Design:** interfaces (endpoints, events, function signatures), data model and migrations, failure modes (what happens when each dependency fails), security and privacy, how it is tested, observed, rolled out and rolled back.
- **Plan:** small, independently shippable pull requests in order, each with its tests. Put migrations that only add before the code that uses them.
- **Open questions** and the decisions worth a decision record.

## 5. Save and hand off

Save the document where the repository keeps designs (an existing `docs/design/`, `docs/rfcs/` or similar, or the `Docs:` line of `## Git workflow`). If there is no such place, ask; propose `docs/design/<short-name>.md`. Mark it `Status: Draft`.

Reply with the recommendation in three lines and the path. Then:

- For each significant decision, offer a decision record (with `new-adr` if installed).
- When the user approves, start the first step of the plan (with `task-flow` if installed).

## Never

- Write production code while designing.
- Present an assumption as a requirement, or invent numbers without marking them.
- Recommend a component, service or tool that no requirement needs.
- Leave out the simplest option.
- Start building before the user approves the design.
