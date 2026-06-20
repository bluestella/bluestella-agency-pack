---
name: stride-threat-modelling
description: Generates STRIDE threat models for architecture components, identifying Spoofing, Tampering, Repudiation, Information Disclosure, Denial of Service, and Elevation of Privilege threats. Documents each threat with severity, impact, and mitigation strategies. WHEN: Threat modelling a component, security design review, identifying security requirements, assessing attack surface, designing incident response.
---

# STRIDE Threat Modelling Skill

## Overview

STRIDE is a systematic threat modelling methodology that categorizes security threats into six categories. This skill helps Security Architects and Security Engineers identify threats in system components and define mitigation strategies.

## STRIDE Categories

| Category                   | Description                               | Examples                                            |
| -------------------------- | ----------------------------------------- | --------------------------------------------------- |
| **S**poofing               | Identity/authentication bypass            | Fake login, session hijacking, API key theft        |
| **T**ampering              | Data modification (in transit or at rest) | DB poisoning, network interception, config changes  |
| **R**epudiation            | Denying actions without audit trail       | User claims they didn't make transaction, no logs   |
| **I**nformation Disclosure | Leaking sensitive data                    | PII exposure, API keys in logs, unencrypted storage |
| **D**enial of Service      | Service unavailability                    | Rate limit bypass, resource exhaustion, crashes     |
| **E**levation of Privilege | Gaining unauthorized access               | SQL injection → admin access, privilege escalation  |

---

## Threat Modelling Workflow

### Step 1: Identify Components

List all major system components:

- Web frontend (React)
- Backend API (Vercel Serverless)
- Database (PostgreSQL)
- Authentication service (OAuth 2.0)
- Payment processor (Stripe)
- Email service (SendGrid)
- etc.

### Step 2: Draw Data Flow Diagram

Show how data flows between components. Include:

- Entry points (where external users interact)
- Trust boundaries (where data crosses security domains)
- Data stores (where data is stored)

### Step 3: Brainstorm Threats per Category

For each component, identify possible threats:

**Spoofing Threats:**

- Attacker impersonates legitimate user
- Attacker forges authentication token
- Man-in-the-middle pretends to be API

**Tampering Threats:**

- Attacker modifies API request in transit
- Attacker modifies database record directly
- Attacker changes payment amount before submission

**Information Disclosure Threats:**

- PII logged in plain text
- Database credentials in source code
- API keys leaked in error messages
- Sensitive data stored unencrypted

**Denial of Service Threats:**

- API rate limit not enforced → 1,000 req/sec possible
- Large file upload without size limits → disk full
- Expensive database queries without timeout

**Elevation of Privilege Threats:**

- SQLi in login form → direct DB access
- Unvalidated user ID parameter → access other users' data
- No RBAC checks on admin endpoints

**Repudiation Threats:**

- No audit log of financial transactions
- User can delete activity history
- No logs of who changed permissions

### Step 4: Assess Severity

For each threat, estimate:

- **Likelihood:** High / Medium / Low (How easy is the attack?)
- **Impact:** Critical / High / Medium / Low (How bad if it succeeds?)
- **Overall Severity = Likelihood × Impact**

| Likelihood \ Impact | Critical | High   | Medium | Low    |
| ------------------- | -------- | ------ | ------ | ------ |
| High                | Critical | High   | High   | Medium |
| Medium              | High     | High   | Medium | Medium |
| Low                 | High     | Medium | Medium | Low    |

### Step 5: Document Mitigations

For each threat, define:

1. **Prevention:** Stop the attack before it happens
2. **Detection:** Detect the attack when it occurs
3. **Response:** Mitigate damage after attack

**Example:**

| Threat                        | Severity | Prevention                                            | Detection                             | Response                  |
| ----------------------------- | -------- | ----------------------------------------------------- | ------------------------------------- | ------------------------- |
| SQL Injection in login        | Critical | Parameterized queries, input validation               | Query logging, WAF rules              | Incident response plan    |
| Unencrypted passwords in logs | Critical | Log redaction filter, never log passwords             | Audit log access, SIEM alerts         | Rotate user passwords     |
| API rate limit bypass         | High     | Strict rate limiting per IP/user, exponential backoff | CloudWatch metrics, Datadog dashboard | Circuit breaker, block IP |

---

## STRIDE Threat Model Template

```markdown
# STRIDE Threat Model: [System Name]

## Components

1. [Component A] — [Brief description]
2. [Component B] — [Brief description]
   ...

## Data Flow Diagram

[Mermaid diagram or ASCII art showing components and data flows]

---

## Threats by Category

### Spoofing

| ID  | Threat                                    | Component | Likelihood | Impact   | Severity | Mitigation                                        |
| --- | ----------------------------------------- | --------- | ---------- | -------- | -------- | ------------------------------------------------- |
| S1  | Attacker impersonates user via stolen JWT | API       | Medium     | High     | High     | JWT expiration (1hr), refresh token rotation, MFA |
| S2  | Database credentials in source code       | Backend   | Low        | Critical | High     | Use Secrets Manager, scan for creds in CI         |

### Tampering

[Repeat above structure]

### Repudiation

[Repeat above structure]

### Information Disclosure

[Repeat above structure]

### Denial of Service

[Repeat above structure]

### Elevation of Privilege

[Repeat above structure]

---

## Risk Register

**Critical Risks (Must Mitigate):**

- [Threat ID]: [Description] → Mitigation: [Action]
- [Threat ID]: [Description] → Mitigation: [Action]

**High Risks (Should Mitigate):**

- [Threat ID]: [Description] → Mitigation: [Action]

**Medium Risks (Monitor):**

- [Threat ID]: [Description] → Mitigation: [Action]

---

## Sign-Off

- [ ] Security Architect: ****\_\_**** Date: **\_\_**
- [ ] Tech Lead: ****\_\_**** Date: **\_\_**
- [ ] Stakeholder: ****\_\_**** Date: **\_\_**
```

---

## Tools

- **OWASP Threat Dragon:** Free, visual threat modelling tool (https://www.threatdragon.org/)
- **Microsoft Threat Modeling Tool:** Free, from Microsoft (now open-source)
- **Draw.io / Miro:** Free diagramming tools

## References

- [STRIDE on Wikipedia](<https://en.wikipedia.org/wiki/Stride_(security)>)
- [OWASP Threat Modeling](https://owasp.org/www-community/Threat_Modeling)
- [Microsoft: Threat Modeling](https://learn.microsoft.com/en-us/azure/security/develop/threat-modeling-tool-threats)
- [NIST: Threat Modeling](https://csrc.nist.gov/projects/threat-modeling/)
