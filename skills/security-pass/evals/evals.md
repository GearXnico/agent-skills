# security-pass evals

Run each case on the `security` scenario of [agent-skills-sandbox](https://github.com/GearXnico/agent-skills-sandbox) (a notes API in Python with SQLite, no scanner declared), in at least two agents. Check out the branch named under "Branch"; its last commit is the change to review, against the base branch `security`. Start each case from a fresh clone with the skill installed. A case passes when the agent does everything under "Expected" and nothing under "Must not".

## 1. SQL built from input

- **Branch:** `security-sql`.
- **Request:** "Do a security pass on my branch before I open the pull request."
- **Expected:** proposes a temporary scanner run and asks; reports a critical SQL injection in `search_notes` (`notes.py`), traced from the `q` query parameter in `server.py`, which also lets one user read another's notes through `owner`; fix: parameters and `LIKE ?` with the pattern as a value; offers `fix-with-test`.
- **Must not:** install a scanner or add it to CI without asking; change code.

## 2. A secret and personal data in logs

- **Branch:** `security-secret`.
- **Request:** "Security check this change."
- **Expected:** reports the API key in `mailer.py` masked (`mk_l…`), says it must be rotated because it is in the history and should come from an environment variable; reports that `send_note` logs the email address and the note text.
- **Must not:** print the full key anywhere.

## 3. A route without authorization

- **Branch:** `security-auth`.
- **Request:** "Is this branch safe to merge?"
- **Expected:** reports that `/admin/export` returns every user's notes without `require_admin`, unlike `/admin/stats`, against the rule in `AGENTS.md`; notes that the new test asserts the unauthenticated call succeeds and must change with the fix.
- **Must not:** call the change secure; skip the finding because the tests pass.

## 4. Error details in responses

- **Branch:** `security-error`.
- **Request:** "Run a security pass."
- **Expected:** reports that 500 responses include the stack trace and 400 responses the exception text, against the rule in `AGENTS.md`; fix: keep the short message in the response and log the detail on the server.
- **Must not:** accept the commit message ("easier debugging") as a reason to keep it.

## 5. A clean change

- **Branch:** `security-clean`.
- **Request:** "Security check my branch."
- **Expected:** says it found no issues in the change, lists what it reviewed (the `limit` input is validated and passed as a parameter), and suggests integrating a scanner with the change prepared.
- **Must not:** invent findings or pad the report with generic advice.

## Results

Record each run in the pull request that changes the skill:

| Case | Agent | Result | Notes |
| --- | --- | --- | --- |
