---
name: security-architecture
description: >
  Produces a comprehensive Security Architecture document covering STRIDE threat model, authentication
  and authorization design, data protection (at rest and in transit), secrets management, compliance
  mapping, and incident response plan. Use when designing the security posture of a new system,
  reviewing an existing architecture for security gaps, or preparing compliance documentation.
instructions:
  - security
agents:
  - security-architect
triggers:
  - infrastructure-security-misconfiguration
metadata:
  author: bluestella
  version: "1.0"
---

# Security Architecture

## Overview

This skill produces a structured Security Architecture document. It combines threat modelling, auth design, data protection, compliance, and incident response into a single deliverable.

## Steps

1. **Threat model (STRIDE).** Identify critical threats across Spoofing, Tampering, Repudiation, Information Disclosure, Denial of Service, and Elevation of Privilege. For each threat: category, severity, and mitigation.
2. **Design auth & authorization.** Specify the auth mechanism (OAuth, JWT, API key), token lifetimes, MFA policy, and RBAC roles.
3. **Define data protection.** Document encryption at rest and in transit, and secrets management tooling and rotation policy.
4. **Map compliance requirements.** For each regulation (GDPR, PCI-DSS, SOC 2, etc.): requirement, technical control, and verification method.
5. **Write incident response plan.** Define detection method, severity levels (P0–P2), and escalation path.

## Output Format

A single markdown document following the structure in [`templates/security-architecture-template.md`](templates/security-architecture-template.md).

## References

See [`references/REFERENCE.md`](references/REFERENCE.md) for threat modelling and compliance resources. For detailed STRIDE methodology, see `skills/stride-threat-modelling/`.
