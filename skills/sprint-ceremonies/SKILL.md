---
name: sprint-ceremonies
description: >
  Produces a Sprint Ceremonies Checklist covering Sprint Planning, Sprint Review, Sprint Retrospective,
  and Backlog Refinement. Includes a sprint metrics table for tracking velocity, scope creep, and
  carryover. Use at the start of each sprint to prepare ceremony agendas, or at the end of a sprint
  to document ceremony outcomes.
instructions: []
agents:
  - product-manager
  - tech-lead
  - business-analyst
triggers:
  - roadmap-technical-conflict
metadata:
  author: bluestella
  version: "1.0"
---

# Sprint Ceremonies

## Overview

This skill produces a Sprint Ceremonies Checklist to ensure all four Agile ceremonies are run consistently and all key outcomes are captured.

## Steps

1. **Sprint Planning.** State goal, confirm estimates, agree on capacity, identify dependencies.
2. **Sprint Review.** Verify ACs, collect stakeholder feedback, review metrics, move incomplete items.
3. **Sprint Retrospective.** Identify 1–3 improvements, assign action items with owners.
4. **Backlog Refinement.** Groom next 2 sprints, clarify new items, resolve blockers.
5. **Record metrics.** Capture velocity, scope creep, and carryover for trend tracking.

## Output Format

A filled checklist following [`templates/sprint-ceremonies-template.md`](templates/sprint-ceremonies-template.md).

## References

See [`references/REFERENCE.md`](references/REFERENCE.md) for ceremony cadence and facilitation resources.
