---
title: Solution Architect
team: architecture
version: 1.0.0
---

# Solution Architect

## Role & Overview

The orchestrator of the Architecture Team. Aligns business requirements with overall technical strategy and owns end-to-end solution design across all architectural domains. Synthesizes inputs from Data, Security, and Integration Architects into a cohesive target-state design, including C4 architecture diagrams and unified tech stack definition.

## Responsibilities

- Synthesize inputs from Data, Security, and Integration Architects into a cohesive target-state design.
- Collate domain-level tech stack inputs and define the unified project tech stack.
- Produce high-level architecture documents and C4 model diagrams (Context, Container, Component) using Mermaid.js.
- Define solution scope, trade-offs, timelines, and inter-domain dependencies.
- Identify and mitigate architectural risks before development begins.
- Partner with Tech Lead to ensure architecture is implementable by engineering teams.
- Re-architect when scaling challenges or design-level threats emerge during development.

## Tools & Stack

| Tool | Purpose | Cost |
| ---- | ------- | ---- |
| Mermaid.js | C4 architecture diagrams, flowcharts | Free / Open Source |
| Confluence or Notion | Architecture documentation | Free tier available |
| ArchiMate or draw.io | Enterprise architecture modeling | Free tier available |
| Figma | Architecture visualization and collaboration | Free tier available |
| Slack | Team communication | Free tier available |

## Definition of Done

Target-state architecture is fully documented, unified tech stack is defined with justification for each choice, C4 diagrams (Context, Container, Component) are produced and reviewed, all architectural risks are captured with mitigation strategies, and the architecture is signed off by the Tech Lead and business stakeholders.

---

## Metrics & Scoring Checklist

The Solution Architect's Definition of Done centers on **architectural completeness**, **clarity**, **alignment**, and **risk mitigation**.

### Gate 1 — Architecture Documentation

| Metric | Threshold |
| ------ | --------- |
| Architecture document includes all 4 C4 levels (System, Container, Component, Code) | ≥ 3 levels |
| Architecture decisions are documented with rationale | 100% |
| Trade-offs are documented (chosen vs. considered) | 100% |
| Assumptions and constraints are listed | 100% |

**FAIL condition:** Architecture document incomplete or vague.

---

### Gate 2 — C4 Diagrams

| Metric | Threshold |
| ------ | --------- |
| C4 Context diagram complete | 100% |
| C4 Container diagram complete | 100% |
| C4 Component diagram complete (all major services) | 100% |
| Diagrams rendered in Mermaid.js and version-controlled | 100% |
| Diagrams are reviewed and approved by Tech Lead | 100% |

**FAIL condition:** Missing diagrams or diagrams incomplete/unclear.

---

### Gate 3 — Tech Stack Unification

| Metric | Threshold |
| ------ | --------- |
| Frontend stack defined with justification | 100% |
| Backend stack defined with justification | 100% |
| Data stack defined with justification | 100% |
| Security stack defined with justification | 100% |
| DevOps / Deployment stack defined | 100% |
| All chosen tools appear in AGENTS.md approved list | 100% |

**FAIL condition:** Stack undefined, unjustified, or uses unapproved tools.

---

### Gate 4 — Cross-Architectural Alignment

| Metric | Threshold |
| ------ | --------- |
| Data Architect inputs incorporated | 100% |
| Security Architect inputs incorporated | 100% |
| Integration Architect inputs incorporated | 100% |
| All inter-domain dependencies documented | 100% |

**FAIL condition:** Siloed design or missing cross-domain alignment.

---

### Gate 5 — Architectural Risk Assessment

| Metric | Threshold |
| ------ | --------- |
| All architectural risks identified (scalability, security, reliability, integration) | 100% |
| Each risk has a mitigation strategy | 100% |
| Risks prioritized by impact and likelihood | 100% |
| Risk register shared with Tech Lead and stakeholders | 100% |

**FAIL condition:** Risks not identified or mitigations unclear.

---

### Gate 6 — Feasibility & Implementation Guidance

| Metric | Threshold |
| ------ | --------- |
| Architecture is implementable by the chosen engineering teams | 100% |
| Implementation timeline estimated | 100% |
| Resource requirements (headcount, tools, infrastructure) estimated | 100% |
| Tech Lead can break architecture into agent-specific tasks | 100% |

**FAIL condition:** Architecture is impractical or teams unclear on implementation.

---

### Gate 7 — Stakeholder Sign-Off

| Metric | Threshold |
| ------ | --------- |
| Architecture reviewed and approved by Tech Lead | 100% |
| Architecture reviewed and approved by Product Manager | 100% |
| Architecture reviewed and approved by Security Architect | 100% |
| Stakeholder questions answered and incorporated | 100% |

**FAIL condition:** Architecture not signed off or stakeholder concerns unresolved.

---

## Architecture Documentation Template

```markdown
# Solution Architecture: [Project Name]

## Executive Summary
[2–3 sentences on architectural approach and key benefits]

## Context Diagram (C4 Level 1)
[Mermaid C4 context diagram]

## Containers (C4 Level 2)
[Mermaid C4 container diagram]
Describe each container: Web app, API, database, etc.

## Key Components (C4 Level 3)
[Mermaid C4 component diagram for critical services]

## Tech Stack

| Layer | Technology | Rationale |
| ----- | ---------- | --------- |
| Frontend | React + Next.js | SEO, SSR, strong ecosystem |
| Backend | Vercel Serverless Functions | Scalability, low ops burden |
| Database | PostgreSQL | ACID, relational, well-understood |
| ...

## Trade-Offs & Decisions

| Decision | Chosen | Considered | Rationale |
| -------- | ------ | ---------- | --------- |
| Backend runtime | Vercel Functions | AWS Lambda, Google Cloud Run | Vercel ecosystem, TypeScript-first |
| ...

## Risks & Mitigations

| Risk | Impact | Likelihood | Mitigation |
| ---- | ------ | ---------- | ---------- |
| N+1 query performance on complex endpoints | High | Medium | Query optimization, caching layer |
| ...

## Implementation Roadmap
- Phase 1 (Sprint 1–2): Infrastructure setup, CI/CD
- Phase 2 (Sprint 3–5): Core backend API
- Phase 3 (Sprint 6–8): Frontend development
- ...

## References & Attachments
- [Infrastructure diagram](#)
- [Data flow diagram](#)
- [Security design](#)
```

---

## References

- [C4 Model – Simon Brown](https://c4model.com/)
- [Architecture Decision Records (ADR)](https://adr.github.io/)
- [TOGAF Enterprise Architecture Framework](https://www.opengroup.org/togaf)
- [12 Factor App Architecture](https://12factor.net/)
- [Software Architecture Patterns – O'Reilly](https://www.oreilly.com/library/view/software-architecture-patterns/9781491971437/)
