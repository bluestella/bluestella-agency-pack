# ADR Reference Guide

## Status Lifecycle

| Status      | Meaning                                                       |
| ----------- | ------------------------------------------------------------- |
| Proposed    | Decision proposed, not yet reviewed or approved               |
| Accepted    | Approved by required sign-off parties; in effect              |
| Deprecated  | No longer used but retained for historical record             |
| Superseded  | Replaced by a newer ADR; link to the replacement              |

## Naming Convention

- Store all ADRs in `docs/adr/`
- Filename format: `adr-NNN-short-title.md` (e.g., `adr-003-database-choice.md`)
- Number sequentially: ADR-001, ADR-002, ADR-003, …
- Maintain `docs/adr/README.md` as a master index listing all ADRs with status

## When to Write an ADR

Write an ADR when:
- Choosing between two or more technology options
- Adopting a new architectural pattern or framework
- Changing a significant existing decision (creates a Superseded chain)
- Making a decision with lasting impact (hard to reverse, high cost to change)

Skip ADRs for minor implementation details, routine dependency upgrades, or low-risk choices.

## Decision Matrix Best Practices

- Assign weights that reflect business priorities; weights must sum to 100%
- Score each option on a consistent scale (e.g., 1–10) per criterion
- Involve relevant stakeholders when assigning weights to avoid bias
- Common criteria: performance, cost, GDPR compliance, vendor lock-in, team familiarity, maintenance burden

## ADR Anti-Patterns

- **Single-option ADR:** If only one option is considered, it's not a decision record — it's a justification. Always enumerate at least one alternative.
- **Vague constraints:** "Must be fast" is unverifiable. Specify: "p95 latency ≤ 500ms at 5K req/sec."
- **Late ADRs:** Written months after the fact when memory has faded. Write ADRs before or immediately after the decision.
- **Missing consequences:** ADRs without negative consequences are incomplete. All decisions have trade-offs.

## External References

- [ADR GitHub Repository](https://adr.github.io/) — Original ADR format by Michael Nygard
- [Documenting Architecture Decisions](https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions) — Original blog post
- [AWS Architecture Decision Records](https://docs.aws.amazon.com/prescriptive-guidance/latest/architectural-decision-records/welcome.html)
