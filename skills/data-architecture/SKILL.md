---
name: data-architecture
description: >
  Produces structured Data Architecture documents covering data models, ERDs, governance policies,
  data lineage, compliance mapping, and backup/DR strategy. Use when designing a new data layer,
  documenting an existing schema, planning compliance controls, or defining data ownership and access policies.
instructions: []
agents:
  - data-architect
triggers: []
metadata:
  author: bluestella
  version: "1.0"
---

# Data Architecture

## Overview

This skill produces a comprehensive Data Architecture document for a project. It covers entity relationships, governance, lineage, compliance, and resilience in a single structured document.

## Steps

1. **Define the data model.** Produce an ERD (Mermaid) and document key entities with column definitions, types, and constraints.
2. **Set data governance.** Assign data owner, steward, classification tier, and access policy (read/write/delete).
3. **Map data lineage.** Trace the flow of each major data domain from source through transformation to consumption.
4. **Map compliance requirements.** For each applicable regulation (GDPR, CCPA, PCI-DSS, etc.), document the requirement, the technical control, and how it is verified.
5. **Define backup & DR.** State RTO, RPO, backup schedule, and restore test cadence.

## Output Format

A single markdown document following the structure in [`templates/data-architecture-template.md`](templates/data-architecture-template.md).

## References

See [`references/REFERENCE.md`](references/REFERENCE.md) for design best practices and compliance resources.
