# Security checklist

Read only the sections the change touches. Each item is a question; a "yes" with a path from input to use is a finding.

## Secrets and personal data

- Is a key, token, password, private key or connection string written in code, config, tests or docs? Is a `.env` or credentials file tracked?
- Is personal data (email, name, address, phone, document number, IP, message text) written to logs, error reports or analytics?
- Is a secret sent to the client, put in a URL, or logged?

## Input and injection

- Does input reach a SQL or NoSQL query, a shell command, a file path, a template, a regular expression, a redirect URL or a deserializer without parameters, escaping or an allow-list?
- Is input validated for type, length and range at the boundary, as the rest of the code does?
- Can a request make the server fetch a URL it chooses (server-side request forgery)?
- Is user content rendered as HTML without escaping (cross-site scripting)?

## Authentication and authorization

- Does a new route, handler, job or command check who the caller is and what they may do, the same way its neighbours do?
- Can a caller read or change another user's data by changing an id (missing ownership check)?
- Are tokens compared in constant time, sessions expired, and passwords hashed with a slow algorithm?

## Errors and output

- Does an error response include a stack trace, exception message, query, path or version?
- Does a response return more fields than the caller needs (internal ids, other users' data, hashes)?

## Configuration

- Is CORS, cookie security (`Secure`, `HttpOnly`, `SameSite`), a security header, TLS verification or a debug mode weakened?
- Is a default credential, an open port or a permissive file permission introduced?

## Cryptography and randomness

- Is a token, id or password generated with a non-cryptographic random source?
- Is a home-made or outdated algorithm (MD5, SHA-1 for passwords, ECB) used?

## Files and uploads

- Are uploaded file names, types and sizes checked, and stored outside the served directory?
- Can a path from input escape the intended folder (`../`)?

## Dependencies

- Is a new dependency well maintained, widely used, and free of known advisories (run the repository's audit command)?
- Is its version pinned in the lockfile, and is it the package the author meant (no typosquatting)?
