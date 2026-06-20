---
name: stride-threat-modelling
description: >
  Generates STRIDE threat models for architecture components, identifying Spoofing, Tampering,
  Repudiation, Information Disclosure, Denial of Service, and Elevation of Privilege threats.
  Documents each threat with likelihood, impact, severity, and mitigation strategies.
  Use when threat modelling a component, conducting security design reviews, identifying
  security requirements, assessing attack surface, or designing incident response.
metadata:
  author: bluestella
  version: "1.0"
---

# STRIDE Threat Modelling

## Overview

STRIDE is a systematic threat modelling methodology that categorizes threats into six categories. This skill helps Security Architects and Security Engineers identify threats in system components and define mitigations — producing a threat register that feeds directly into security requirements and acceptance criteria.

## STRIDE Categories (Quick Reference)

| Letter | Threat                  | Description                              |
| ------ | ----------------------- | ---------------------------------------- |
| S      | Spoofing                | Impersonating a user, service, or system |
| T      | Tampering               | Modifying data in transit or at rest     |
| R      | Repudiation             | Denying actions without audit evidence   |
| I      | Information Disclosure  | Exposing data to unauthorized parties   |
| D      | Denial of Service       | Making a service unavailable             |
| E      | Elevation of Privilege  | Gaining unauthorized access/permissions  |

## Steps

1. **List components.** Enumerate all system components in scope: frontend, backend API, database, auth service, queues, external integrations.
2. **Draw the data flow diagram.** Show how data moves between components. Mark entry points, trust boundaries, and data stores. Use the Mermaid template in [`templates/stride-template.md`](templates/stride-template.md).
3. **Brainstorm threats per STRIDE category.** For each component × each STRIDE letter, ask: "How could this be attacked?" Generate a list of candidate threats.
4. **Score each threat.** Estimate Likelihood (High/Medium/Low) and Impact (Critical/High/Medium/Low). Derive Overall Severity using the matrix in [`references/REFERENCE.md`](references/REFERENCE.md).
5. **Define mitigations.** For each threat: Prevention (stop it), Detection (catch it), Response (limit damage). Mark each mitigation as Implemented, Planned, or Accepted Risk.
6. **Build the risk register.** Prioritize Critical and High severity threats as mandatory mitigations. Flag Accepted Risks for explicit sign-off.
7. **Get sign-off.** Security Architect + Tech Lead. Critical risks require CTO-level acknowledgment if accepted.

## Output Format

A markdown threat model document:

```
# STRIDE Threat Model: [System Name]
## Components
## Data Flow Diagram    — Mermaid diagram
## Threats by Category  — table per STRIDE letter: ID, threat, component,
                          likelihood, impact, severity, mitigation
## Risk Register        — Critical/High sorted by severity
## Sign-Off
```

Template: [`templates/stride-template.md`](templates/stride-template.md)

## Examples

**Input:** "Threat model the authentication service (JWT-based login, PostgreSQL user table)."

**Output:** Threat model covering S (JWT forgery, session hijacking), T (DB record tampering), R (no transaction log), I (PII in error messages, JWT payload readable), D (rate limit bypass on /login), E (SQLi in email field → admin access). 12 threats total, 4 Critical, 5 High, 3 Medium.

**Input:** "Security found a new threat — rate limiting not enforced on signup. What's the STRIDE category?"

**Output:** Denial of Service (D) threat. Likelihood: High. Impact: High. Mitigation: implement rate limiting at 5 req/IP/minute on POST /auth/signup. Feeds back to Business Analyst as new security requirement.

## Edge Cases

- Large system (20+ components): scope the model to one component at a time. Don't try to model the entire system in one session.
- External third-party components (Stripe, SendGrid): model the trust boundary — what data crosses it, what could go wrong — not the internals of the third party.
- STRIDE finding requires a new business requirement: trigger the `security-finding-to-ba-requirement` hook to route the finding to the Business Analyst.
- Accepted Risk: always document who accepted it and why — never leave a Critical threat with no mitigation silently.

## References

See [`references/REFERENCE.md`](references/REFERENCE.md) for the severity matrix, DREAD scoring, and external STRIDE resources.
