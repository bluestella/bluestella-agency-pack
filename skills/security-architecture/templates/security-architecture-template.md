# Security Architecture: [Project Name]

## Executive Summary

[Overview of security approach and key principles]

## STRIDE Threat Model

[OWASP Threat Dragon diagram]

### Critical Threats & Mitigations

| Threat | Category | Severity | Mitigation |
| ------ | -------- | -------- | ---------- |
| SQL injection in order API | Tampering | Critical | Parameterized queries, input validation, WAF |
| Unauthorized API access | Spoofing | High | OAuth 2.0 + API key rotation |
| PII exposure in logs | Information Disclosure | Critical | Redaction filters, encryption at rest |

---

## Authentication & Authorization

**Mechanism:** [e.g., OAuth 2.0 Authorization Code flow with JWT tokens]

**Token expiration:** [e.g., 1 hour (short-lived) + refresh token (7 days)]

**MFA:** [Required for / optional for]

**RBAC Roles:**
- Admin: Full access
- User: [Permissions]
- [Role]: [Permissions]

---

## Data Protection

**At Rest:**
- Database: [Encryption method]
- Object storage: [Encryption method]
- Backups: [Encryption + location]

**In Transit:**
- [TLS version]
- [Certificate pinning policy]

**Secrets Management:**
- Service credentials: [Tool]
- API keys: [Tool]
- Database passwords: [Rotation policy]

---

## Compliance Mapping

| Requirement | Control | Verification |
| ----------- | ------- | ------------ |
| GDPR: Data retention limit | Automated purge after 2 years | Quarterly audit |
| GDPR: Right to deletion | Soft-delete + backup restore within 30 days | Tested quarterly |
| PCI-DSS: No PII in logs | Log redaction filter on payment data | Code review + scanning |

---

## Incident Response Plan

**Detection:** [Monitoring tools + on-call process]

**Severity Levels:**
- Critical (P0): System down, data breach → immediate response
- High (P1): Data loss risk, auth failure → within 1 hour
- Medium (P2): Degraded functionality → within 4 hours

**Escalation Path:** On-call engineer → Manager → CISO (if breach suspected)

---

## References & Attachments
- [OWASP Top 10 (2023)](#)
- [NIST Cybersecurity Framework](#)
- [AWS Well-Architected Security Pillar](#)
- [Incident Response Playbook](#)
