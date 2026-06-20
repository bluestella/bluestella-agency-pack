---
name: c4-architecture-diagramming
description: >
  Generates C4 model architecture diagrams (Context, Container, Component, Code levels)
  using Mermaid.js showing system structure, dependencies, and technology choices.
  Use when documenting system architecture, creating architecture decisions, sharing
  architecture with a team, designing new system structure, or aligning cross-team
  understanding of the current or target-state architecture.
instructions:
  - c4-diagramming
agents:
  - solution-architect
triggers: []
metadata:
  author: bluestella
  version: "1.0"
---

# C4 Architecture Diagramming

## Overview

The C4 model visualizes software architecture at four levels of abstraction — from the big picture down to implementation detail. This skill produces Mermaid.js diagrams for one or more C4 levels, depending on the audience and purpose. Diagrams are embedded directly in markdown and render in GitHub, Notion, and most documentation tools.

## C4 Levels

| Level       | Audience                | Shows                                                   |
| ----------- | ----------------------- | ------------------------------------------------------- |
| 1 — Context  | Everyone, non-technical | System + its users + external systems                   |
| 2 — Container | Developers, architects  | Frontend, backend, DB, queues — tech choices included   |
| 3 — Component | Developers              | Internal structure of one container (modules, services) |
| 4 — Code     | Developers              | Classes, functions — usually auto-generated from IDE    |

## Steps

1. **Identify the scope.** Which level(s) are needed? Context for stakeholder communication; Container for architecture alignment; Component for sprint planning.
2. **List system elements.** For Context: users + external systems. For Container: all major technical building blocks. For Component: internal modules of the selected container.
3. **Draw data flows.** Label each arrow with the verb (sends, reads, triggers, queries). Keep flows directional.
4. **Choose the right Mermaid diagram type.** Use `graph TB` for C4 Context/Container/Component. Use `erDiagram` for data models. Use `sequenceDiagram` for flows.
5. **Apply technology labels.** In Container and below, add `[Technology]` in the node label (e.g., `React SPA`, `PostgreSQL 16`).
6. **Embed in the relevant document.** ADR, BRD, or architecture design doc. Link the diagram file from the ADR or design doc.

## Output Format

Mermaid code blocks embedded in markdown:

````markdown
```mermaid
graph TB
    [node definitions]
    [relationships with labels]
```
````

One fenced block per level. Nodes use double-quoted labels with `<br/>` for line breaks.

Templates: [`templates/c4-templates.md`](templates/c4-templates.md)

## Examples

**Input:** "Show the system context for a SaaS registration app."

**Output:** Level 1 Context diagram — central system box, User actor, SendGrid (email), Stripe (payment). Arrows labeled "Signs up", "Sends verification email", "Processes payment".

**Input:** "Show the container architecture for the same app."

**Output:** Level 2 Container diagram — React SPA (frontend), Next.js API (backend), PostgreSQL (DB), Redis (cache), SendGrid and Stripe as external boxes. Tech stack labels on each container.

## Edge Cases

- Microservices with 10+ containers: split into multiple diagrams (one per domain boundary); don't try to show all containers in one diagram.
- Existing system being documented: discover containers by reading the codebase and infrastructure config before drawing.
- Third-party SaaS in the diagram: show at boundary level only; don't detail their internals.
- Code level (L4): only generate if the team explicitly needs a class diagram; usually the IDE generates this better.

## References

See [`references/REFERENCE.md`](references/REFERENCE.md) for C4 notation rules, Mermaid syntax tips, and the C4 model specification.
