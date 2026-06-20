---
title: [Epic Name]
type: epic
status: TODO
sprint: [number or TBD]
assignee: Business Analyst
---

# Epic: [Epic Name]

**Business Goal:** [One sentence. The outcome the business needs, not the feature to be built.]

**Scope:** [What is in scope. Call out explicit exclusions if needed.]

**Priority:** [P0 — Critical | P1 — High | P2 — Medium | P3 — Low]

---

## Requirements Checklist

| Item | Type | Assignee | Status |
| ---- | ---- | -------- | ------ |
| [User Story 1 name] | Story | [Agent role] | TODO |
| [User Story 2 name] | Story | [Agent role] | TODO |
| [Architecture decision] | Task | Solution Architect | TODO |
| [Security threat model] | Task | Security Engineer | TODO |

---

## User Stories

### Story 1: [Story Name]

**As a** [persona or agent role]
**I want** [capability or output]
**So that** [business or technical benefit]

**Acceptance Criteria:**

- [ ] [Criterion 1 — specific, testable, binary pass/fail]
- [ ] [Criterion 2]
- [ ] [Criterion 3]

**Definition of Done:**

| Role | Criteria | Tool / Evidence |
| ---- | -------- | --------------- |
| Developer | Unit test coverage ≥ 90%; 0 TypeScript errors; 0 ESLint errors | Vitest `--coverage`; `tsc --noEmit`; CI lint job |
| Tester | All Acceptance Criteria pass automated tests; 0 open bugs | Playwright / Vitest; GitHub Issues |
| Architect | API contract or data model reviewed and approved | PR review by Solution Architect |
| DevOps | Feature deployed to preview environment; CI pipeline green | Vercel preview URL; GitHub Actions |

**Tasks:**

| # | Task | Sub-tasks | Assignee | Status |
| - | ---- | --------- | -------- | ------ |
| 1 | [Task name] | [Sub-task A], [Sub-task B] | [Agent role] | TODO |
| 2 | [Task name] | [Sub-task A] | [Agent role] | TODO |

---

### Story 2: [Story Name]

**As a** [persona or agent role]
**I want** [capability or output]
**So that** [business or technical benefit]

**Acceptance Criteria:**

- [ ] [Criterion 1]
- [ ] [Criterion 2]

**Definition of Done:**

| Role | Criteria | Tool / Evidence |
| ---- | -------- | --------------- |
| Developer | [criteria] | [tool] |
| Tester | [criteria] | [tool] |

**Tasks:**

| # | Task | Sub-tasks | Assignee | Status |
| - | ---- | --------- | -------- | ------ |
| 1 | [Task name] | [Sub-task A] | [Agent role] | TODO |

---

## Epic Definition of Done

- [ ] All User Stories have status: Done
- [ ] All Tasks and Sub-tasks have status: Done
- [ ] 0 open bugs at any severity (P0–P3)
- [ ] Architecture artifacts produced (diagrams, contracts, decisions)
- [ ] Security threat model completed and all findings resolved
- [ ] Feature deployed to production and monitored
- [ ] Requirements checklist fully updated to Done
