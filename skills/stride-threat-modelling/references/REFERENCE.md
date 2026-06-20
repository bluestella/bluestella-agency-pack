# STRIDE Threat Modelling — Reference Guide

## Severity Matrix

Combine Likelihood × Impact to determine overall severity:

| Likelihood \ Impact | Critical | High   | Medium | Low    |
| ------------------- | -------- | ------ | ------ | ------ |
| High                | Critical | High   | High   | Medium |
| Medium              | High     | High   | Medium | Low    |
| Low                 | High     | Medium | Medium | Low    |

**Critical:** Block release. Must be mitigated before shipping.
**High:** Fix this sprint. Significant risk if shipped.
**Medium:** Fix within the quarter. Monitor.
**Low:** Accept or fix opportunistically.

## Mitigation Types

| Type       | Description                                               |
| ---------- | --------------------------------------------------------- |
| Prevention | Controls that stop the attack before it happens           |
| Detection  | Monitoring/logging that catches the attack when it occurs |
| Response   | Actions that limit damage after the attack succeeds       |
| Transfer   | Move risk to a third party (e.g., use OAuth instead of custom auth) |
| Acceptance | Acknowledge the risk with documented rationale (for Low only) |

## Common Mitigations by STRIDE Category

**Spoofing:**
- JWT with short expiry (1h) + refresh token rotation
- MFA for high-value accounts
- HTTPS everywhere + HSTS headers

**Tampering:**
- Input validation and sanitization (never trust client data)
- Parameterized queries (prevent SQLi)
- HMAC signatures on API requests
- Integrity checks on config files

**Repudiation:**
- Append-only audit log (never delete/update entries)
- Log user ID, timestamp, action, and affected resource
- Immutable log storage (CloudWatch, S3 with Object Lock)

**Information Disclosure:**
- Generic error messages to clients; detailed errors in server logs only
- Encrypt PII at rest (application-level AES for sensitive fields)
- Never log passwords, tokens, or PII
- Least-privilege DB accounts (read-only where possible)

**Denial of Service:**
- Rate limiting per IP + per user
- Request size limits (max body size)
- Query timeouts (max 5s for API endpoints)
- CDN / WAF for DDoS mitigation

**Elevation of Privilege:**
- RBAC enforced at API layer (not just UI)
- Principle of least privilege on all accounts
- SAST scanning for authorization bypasses
- No direct SQL access from application layer (use ORM/repository pattern)

## DREAD Risk Scoring (Alternative to Likelihood/Impact)

If more granular scoring is needed, use DREAD:
- **D**amage potential (1–10)
- **R**eproducibility (1–10)
- **E**xploitability (1–10)
- **A**ffected users (1–10)
- **D**iscoverability (1–10)

Score = Average of all five. ≥8 = Critical, 6–7 = High, 4–5 = Medium, <4 = Low.

## External References

- [OWASP Threat Modeling](https://owasp.org/www-community/Threat_Modeling)
- [Microsoft STRIDE Overview](https://learn.microsoft.com/en-us/azure/security/develop/threat-modeling-tool-threats)
- [OWASP Threat Dragon (free tool)](https://www.threatdragon.com/)
- [NIST Threat Modeling](https://csrc.nist.gov/projects/threat-modeling/)
