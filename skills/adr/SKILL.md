---
name: adr
description: >
  Generates Architecture Decision Records (ADRs) documenting major technical decisions
  with context, options considered, rationale, and consequences. Use when documenting
  architecture decisions, choosing between technology options, recording trade-offs,
  keeping decision history for future teams, or conducting architectural retrospectives.
metadata:
  author: bluestella
  version: "1.0"
---

# ADR — Architecture Decision Record

## Overview

An ADR documents a significant architectural decision — including context, options, the chosen option, and consequences. ADRs create a decision history that helps current and future teams understand *why* a decision was made, not just *what* was decided. Each ADR is a standalone markdown file stored in `docs/adr/`.

## Steps

1. **Identify the decision scope.** Confirm this is a significant architectural choice (technology selection, pattern adoption, platform change). Minor implementation details don't need ADRs.
2. **Gather context.** Collect business constraints, technical constraints, performance requirements, cost limits, and compliance needs.
3. **List options.** Enumerate 2–4 realistic alternatives. For each, list pros, cons, effort estimate, and monthly cost.
4. **Score options.** Build a decision matrix weighting the key criteria. Score each option per criterion, calculate weighted totals.
5. **Write the ADR.** Use [`templates/adr-template.md`](templates/adr-template.md). State the chosen option clearly, explain rationale referencing the matrix.
6. **Get sign-off.** Route to Solution Architect + Tech Lead. Include Security Architect if the decision involves auth, data, or infrastructure.
7. **File it.** Save as `docs/adr/adr-NNN-short-title.md`. Add entry to `docs/adr/README.md` index.

## Output Format

A single markdown file per decision:

```
# ADR-[NNN]: [Title]
Status / Date / Author(s)
## Context          — problem statement + key constraints
## Decision         — chosen option in 1–2 sentences
## Options          — pros/cons/effort per alternative
## Rationale        — decision matrix + reasoning
## Consequences     — positive / negative / neutral
## Implementation   — phased plan with owner + timeline
## Related ADRs     — linked decisions
## Sign-Off         — checkboxes for required approvers
```

Template: [`templates/adr-template.md`](templates/adr-template.md)

## Examples

**Input:** "Choose a primary database for a SaaS app expecting 1M users. Budget: $10K/month. Need ACID transactions and complex queries. GDPR required."

**Output:** ADR-003 comparing PostgreSQL vs DynamoDB vs Aurora, with a weighted decision matrix scoring query flexibility (30%), ACID (25%), GDPR (20%), cost (15%), portability (10%). PostgreSQL wins (9.35/10).

**Input (reversal):** "We're migrating from REST to GraphQL."

**Output:** New ADR with status `Accepted`, old REST ADR updated to `Superseded by ADR-NNN`.

## Edge Cases

- Fewer than 2 options: ask for at least one alternative before writing — single-option ADRs skip the decision process.
- Decision involves personal data or auth: always include Security Architect in sign-off.
- Vague constraints ("needs to be fast"): ask for specific thresholds (p95 latency, RPS, budget) before proceeding.
- Superseding an existing ADR: set status `Superseded` on the old file, link both ADRs to each other.

## References

See [`references/REFERENCE.md`](references/REFERENCE.md) for ADR best practices, naming conventions, and status lifecycle.
