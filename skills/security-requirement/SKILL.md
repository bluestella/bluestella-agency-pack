---
name: security-requirement
description: >
  Produces a structured Security Requirement ticket from a STRIDE finding, CodeQL alert, Dependabot
  CVE, or OWASP mapping. Includes source, category, severity, impacted component, required mitigation,
  acceptance criteria, and verification method. Use when raising a security finding as a trackable
  work item for a developer, or when translating a threat model output into actionable tickets.
instructions:
  - security
agents:
  - security-engineer
triggers:
  - stride-threat-finding
  - stride-finding-requires-requirement
metadata:
  author: bluestella
  version: "1.0"
---

# Security Requirement

## Overview

This skill turns a raw security finding into a structured ticket that a developer can act on. It captures the source, threat category, severity, what needs to be fixed, and how the fix will be verified.

## Steps

1. **Identify the source.** Is this from STRIDE, CodeQL, Dependabot, or an OWASP mapping?
2. **Classify the finding.** Assign a STRIDE category (or CVE/OWASP identifier) and severity (Critical / High / Medium / Low).
3. **Identify the impacted component.** Name the specific service, endpoint, file, or dependency.
4. **Write the required mitigation.** Be specific and actionable — the developer should know exactly what to implement.
5. **Write acceptance criteria.** Testable conditions the developer must satisfy plus a scan rerun confirmation.
6. **Define verification.** How will the Security Engineer confirm the fix (rerun scan, code review, manual test)?

## Output Format

A single markdown ticket following [`templates/security-requirement-template.md`](templates/security-requirement-template.md).

## References

See [`references/REFERENCE.md`](references/REFERENCE.md) for severity definitions, source categories, and tooling links.
