# C4 Architecture Diagramming — Reference Guide

## C4 Notation Rules

- **Context (L1):** Show the system as one box. Only users and external systems around it. No tech details.
- **Container (L2):** Every deployable unit is a container (web app, API, DB, queue, cache). Include technology in the label.
- **Component (L3):** Show modules/layers within ONE container. Don't mix components from different containers.
- **Code (L4):** Optional. Classes or functions. Auto-generate from IDE where possible.

## Mermaid Tips

- Use `graph TB` (top-to-bottom) for C4 hierarchy diagrams — most readable.
- Use `subgraph` to draw system boundaries.
- Arrow label syntax: `A -->|"label text"| B`
- Line breaks in labels: `["Line 1<br/>Line 2"]`
- Icons are optional but help: 👤 (user), 📧 (email), 💳 (payment), 🗄️ (database)
- Keep arrow labels to short verbs: "queries", "calls", "sends", "reads", "enqueues"

## What NOT to Include

- **Don't show algorithms** or business rules in C4 — that's code-level detail.
- **Don't show every table** in a DB container — that's schema design, not architecture.
- **Don't put more than ~12 nodes** in a single diagram — split into sub-diagrams.
- **Don't omit technology** from Container and below — it's the point of those levels.

## Updating Diagrams

When architecture changes:
1. Update the diagram file in the same commit as the infrastructure/code change.
2. Update the related ADR if a technology decision changed.
3. Version-stamp the diagram (e.g., "Last updated: YYYY-MM-DD, ADR-NNN").

## Tools

- **GitHub / GitLab / Notion:** Mermaid renders natively in markdown (use fenced code blocks).
- **Mermaid Live Editor:** https://mermaid.live — preview and debug diagrams.
- **C4-PlantUML:** https://github.com/plantuml-stdlib/C4-PlantUML — if team prefers PlantUML syntax.
- **Structurizr:** https://structurizr.com — purpose-built C4 tool with DSL.

## External References

- [C4 Model Official Site](https://c4model.com/) — by Simon Brown
- [C4 Model FAQ](https://c4model.com/#faq) — common questions
- [Mermaid.js Diagram Types](https://mermaid.js.org/syntax/classDiagram.html) — full syntax reference
