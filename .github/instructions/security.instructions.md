---
applyTo: "{src/middleware/**,src/auth/**,src/api/**}"
---

Authentication and protection:

- REQUIRE auth middleware on all protected routes; no exceptions

Rate limiting:

- APPLY rate limiting on every public endpoint

Secrets and PII:

- NEVER log or return passwords, tokens, secrets, or PII in responses or logs

Input sanitization:

- SANITIZE inputs before any database write

Forbidden patterns:

- NEVER use eval()
- NEVER use dynamic require()
- NEVER use string-interpolated SQL
