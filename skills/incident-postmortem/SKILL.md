---
name: incident-postmortem
description: Writes a blameless postmortem after an incident - outage, production error, bad data - with a sourced timeline, the trigger and the latent causes behind it, impact, and a specific fix recommendation for each finding. Use when the user asks for a postmortem, an incident report, a root cause analysis, or what went wrong after something broke.
license: MIT
metadata:
  version: "0.1.0"
---

# incident-postmortem

Explain what happened, why, and what would stop it from happening again, using only facts you can point to. The report is about causes, never about who is at fault.

## 1. Gather the facts

1. Take what the user gives you: times, logs, messages, tickets, numbers.
2. **Search only the incident window.** Read the commits, merged pull requests and deploys from the last release or deploy known to work up to the incident start, and the logs from about one hour before detection until the fix. If the user names a range (dates, versions, pull requests), use it instead. Do not walk the whole history; if the cause is not in the window, say so and ask before widening it.
3. Ask once, in one message, for whatever is still missing among start, detection, end and impact. Mark anything still unknown as an assumption.

## 2. Build the timeline

One line per fact: time (UTC unless the user uses another zone), what happened, and its source (`file:line`, commit, log line, message). A fact without a source is labelled "assumption".

## 3. Find the causes

1. **Trigger:** what set the incident off in the window (a change, more load, new data, a third party).
2. **Contributing causes:** what allowed it or made it worse (no limit, no alert, no test, no timeout). Ask "why" until the answer is something the team can change, usually up to five times.
3. **Latent defects:** if the code that failed is older than the window, follow only those lines back (`git blame -L`, `git log -S` or `git log -L`) to the commit that introduced it. Report when it went in, how long it stayed latent, and why it did not show earlier (a condition that never happened, low volume, no test).
4. If the evidence does not prove a cause, say so and list it as a hypothesis with what would confirm it.

## 4. Measure the impact

Who was affected, for how long, and what was lost, with numbers when the sources have them.

## 5. Recommend

1. **Actions:** few and concrete. Each says what to change and where, its type (prevent, detect sooner, recover faster), a suggested owner role and a size (small, medium, large).
2. **A recommendation for every finding** in step 3, naming the skill or step that fits when one is installed. For example: "fix-with-test can fix this", "fix-with-test can fix this; consider a refactor too, because the same retry logic is in three places", or "this needs a design first (design-doc)".
3. **Improvements:** broader changes the incident suggests that are not urgent (monitoring, a process change), each with reason, benefit and size, so the user can plan them. They are not commitments.

## 6. Write the report

Fill in [the template](references/report-template.md) and save it where the repository keeps documents (the `Docs:` line in `## Git workflow` of `AGENTS.md`, or an existing `docs/` folder), as `postmortems/<YYYY-MM-DD>-<short-name>.md`. If there is no such place, ask. Show the user the summary and the path; do not commit unless asked.

## Never

- Blame people. If the user asks who is at fault, decline that part, explain that the report looks for causes so they can be fixed, and carry on with the analysis. `git blame` dates a commit; the report never names its author.
- Invent times, causes or numbers.
- Copy secrets or personal data (emails, names, card numbers, tokens) from logs into the report: write `customer A` or `[redacted]`.
- Change code, configuration or production while writing the report.
