---
name: solution-architecture
description: >
  Produces a Solution Architecture document with C4 diagrams (context, containers, components), tech
  stack decisions, trade-off analysis, risk register, and implementation roadmap. Use when designing
  a new system, presenting architecture to stakeholders, justifying technology choices, or documenting
  the overall structure of a solution.
instructions:
  - c4-diagramming
agents:
  - solution-architect
triggers:
  - technical-debt-architectural-review
metadata:
  author: bluestella
  version: "1.0"
---

# Solution Architecture

## Overview

This skill produces a comprehensive Solution Architecture document, from high-level context diagrams through to tech stack decisions, trade-off rationale, and an implementation roadmap.

## Steps

1. **Write the executive summary.** 2–3 sentences capturing the architectural approach and key benefits.
2. **Draw C4 diagrams.** Level 1 (context), Level 2 (containers), Level 3 (key components) using Mermaid.
3. **Define the tech stack.** For each layer (frontend, backend, database, cache, etc.) document the chosen technology and rationale.
4. **Document trade-offs & decisions.** For each significant architectural decision, list what was chosen, what was considered, and why.
5. **Build a risk register.** For each risk: impact, likelihood, and mitigation strategy.
6. **Create an implementation roadmap.** Break delivery into phases with sprint estimates.

## Output Format

A single markdown document following the structure in [`templates/solution-architecture-template.md`](templates/solution-architecture-template.md).

## References

See [`references/REFERENCE.md`](references/REFERENCE.md) for architecture frameworks and C4 resources. For detailed C4 diagrams, see `skills/c4-architecture-diagramming/`. For ADRs, see `skills/adr/`.
