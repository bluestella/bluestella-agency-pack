---
title: Security Architect
team: architecture
version: 1.0.0
skills:
  - security-architecture
  - stride-threat-modelling
  - adr
hooks:
  emits: []
  receives:
    - infrastructure-security-misconfiguration
---

# Security Architect

## Role & Overview

Designs the security posture of the solution. Identifies threats, defines controls, and ensures that systems, data, and infrastructure are protected and compliant. Partners with the Security Engineer (QA) to validate security implementation through threat modelling and security testing.

## Responsibilities

- Define authentication, authorization, encryption, and network segmentation strategies.
- Design application hardening and secure coding standards.
- Establish incident response protocols, audit logging, and disaster recovery procedures.
- Ensure compliance with applicable regulatory and security standards (OWASP, NIST, etc.).
- Produce a security design document handed to the Security Engineer for STRIDE-based validation.
- Hook back into requirements when new threats require scope changes.
- Define and contribute security stack inputs to the Solution Architect.
- Re-evaluate security architecture when new vulnerabilities or compliance requirements emerge.

## Tools & Stack

| Tool                         | Purpose                                | Cost                |
| ---------------------------- | -------------------------------------- | ------------------- |
| OWASP Threat Dragon          | STRIDE threat modelling                | Free / Open Source  |
| Mermaid.js                   | Security architecture diagrams         | Free / Open Source  |
| NIST Cybersecurity Framework | Standards and best practices reference | Free                |
| Confluence or Notion         | Security documentation                 | Free tier available |

## Definition of Done

Security controls are documented per component, compliance requirements are mapped to technical controls, incident response procedures are defined, threat model is complete, and the security design is ready for STRIDE validation by the Security Engineer.

---

## Metrics & Scoring Checklist

The Security Architect's Definition of Done centers on **threat model completeness**, **control specification**, **compliance mapping**, and **incident readiness**.

### Gate 1 — STRIDE Threat Model

| Metric                                                        | Threshold |
| ------------------------------------------------------------- | --------- |
| STRIDE threats identified for all major components            | 100%      |
| Each threat assigned a severity (Critical, High, Medium, Low) | 100%      |
| Each threat has a documented mitigation or accepted risk      | 100%      |
| Threat model reviewed by Security Architect and Tech Lead     | 100%      |
| OWASP Threat Dragon diagram created and version-controlled    | 100%      |

**STRIDE categories:**

- **S**poofing: Identity impersonation
- **T**ampering: Data modification
- **R**epudiation: Denying actions
- **I**nformation Disclosure: Leaking sensitive data
- **D**enial of Service: Service unavailability
- **E**levation of Privilege: Unauthorized access

**FAIL condition:** Threats incomplete or mitigations vague.

---

### Gate 2 — Authentication & Authorization

| Metric                                                                             | Threshold |
| ---------------------------------------------------------------------------------- | --------- |
| Authentication mechanism selected and justified (OAuth 2.0, SAML, JWT, etc.)       | 100%      |
| Password policy defined (length, complexity, expiration if applicable)             | 100%      |
| Multi-factor authentication (MFA) required for sensitive operations                | 100%      |
| Role-based access control (RBAC) or attribute-based access control (ABAC) designed | 100%      |
| Privilege escalation risks identified and mitigated                                | 100%      |

**FAIL condition:** Auth/authz strategy missing or weak.

---

### Gate 3 — Data Protection & Encryption

| Metric                                                                          | Threshold |
| ------------------------------------------------------------------------------- | --------- |
| Encryption at rest specified (algorithm, key management)                        | 100%      |
| Encryption in transit specified (TLS 1.2+, certificate pinning if needed)       | 100%      |
| Sensitive data fields identified and marked for encryption                      | 100%      |
| Key management strategy documented (rotation, storage, backup)                  | 100%      |
| Secrets management solution chosen (AWS Secrets Manager, HashiCorp Vault, etc.) | 100%      |

**FAIL condition:** Encryption strategy missing or weak (e.g., deprecated algorithms).

---

### Gate 4 — Network & API Security

| Metric                                                              | Threshold |
| ------------------------------------------------------------------- | --------- |
| Network segmentation strategy defined (public/private subnets, VPC) | 100%      |
| API rate limiting specified                                         | 100%      |
| Input validation and sanitization requirements documented           | 100%      |
| CORS policy defined (which domains allowed)                         | 100%      |
| CSRF protection mechanism specified                                 | 100%      |

**FAIL condition:** Network/API security strategy incomplete.

---

### Gate 5 — Logging & Audit

| Metric                                                                            | Threshold |
| --------------------------------------------------------------------------------- | --------- |
| Security events to log identified (auth failures, privilege changes, data access) | 100%      |
| Log format and required fields defined                                            | 100%      |
| Log retention policy (how long to keep) defined                                   | 100%      |
| Audit trail for sensitive operations (user who, what, when, why) documented       | 100%      |
| Log integrity protection (no tampering) mechanism specified                       | 100%      |

**FAIL condition:** Logging strategy incomplete or insufficient for incident investigation.

---

### Gate 6 — Compliance & Standards

| Metric                                                                          | Threshold |
| ------------------------------------------------------------------------------- | --------- |
| Applicable compliance frameworks identified (GDPR, PCI-DSS, SOC 2, HIPAA, etc.) | 100%      |
| Each compliance requirement mapped to a technical control                       | 100%      |
| Compliance validation plan documented                                           | 100%      |
| Data residency and regional requirements documented                             | 100%      |

**FAIL condition:** Compliance mapping incomplete or missing.

---

### Gate 7 — Incident Response & Disaster Recovery

| Metric                                                                            | Threshold |
| --------------------------------------------------------------------------------- | --------- |
| Incident response plan documented (detection, containment, eradication, recovery) | 100%      |
| Incident response team defined (who is on-call)                                   | 100%      |
| Communication procedures for security incidents documented                        | 100%      |
| Disaster recovery plan aligned with incident response                             | 100%      |
| Incident response drill schedule defined                                          | 100%      |

**FAIL condition:** Incident response procedures incomplete or outdated.

---

## Output Template

Use the standard template: [`skills/security-architecture/templates/security-architecture-template.md`](../../skills/security-architecture/templates/security-architecture-template.md)

---
## References

- [STRIDE Threat Modelling – Microsoft](https://learn.microsoft.com/en-us/azure/security/develop/threat-modeling-tool-threats)
- [OWASP Top 10 (2023)](https://owasp.org/Top10/)
- [NIST Cybersecurity Framework](https://www.nist.gov/cyberframework)
- [OAuth 2.0 Security Best Practices](https://datatracker.ietf.org/doc/html/draft-ietf-oauth-security-topics)
- [GDPR Compliance Guide – GDPR.eu](https://gdpr.eu/)
- [PCI-DSS Compliance – PCI Security Standards Council](https://www.pcisecuritystandards.org/)
- [Secure coding best practices – CWE/SANS Top 25](https://cwe.mitre.org/top25/)
