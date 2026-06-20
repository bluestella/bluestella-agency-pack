# BRD Skill — Reference Documentation

## Agile Hierarchy Model

Source: [Epics, Stories and Themes — Atlassian](https://www.atlassian.com/agile/project-management/epics-stories-themes)

### Epic
A large body of work that can be broken down into smaller stories. An Epic captures a significant chunk of business value and typically spans one or more sprints.

### User Story
A short description of a feature from the perspective of the end user or agent consuming the output.
Format: **As a** [who] **I want** [what] **So that** [why]

Stories should be:
- Independent (deliverable without other stories)
- Negotiable (not a fixed contract)
- Valuable (delivers value to the persona)
- Estimable (can be sized)
- Small (fits in a sprint)
- Testable (has verifiable acceptance criteria)

This is the **INVEST** criteria.

### Task
A concrete unit of work required to complete a User Story. Assigned to a specific agent role. Can have a single acceptance criterion or be verified by the parent story's criteria.

### Sub-task
The smallest atomic unit. Typically maps to a single function, endpoint, test file, or configuration block.

## Acceptance Criteria Format

Each criterion must be:
- **Specific:** names a concrete behaviour or output
- **Testable:** can be verified by a QA engineer or automated test
- **Binary:** either passes or fails — no partial credit

Use Given / When / Then format for complex behavioural criteria:
```
Given [precondition]
When [action]
Then [expected outcome]
```

## Definition of Done — Role-Specific Scoring Matrix

The DoD table in each User Story uses role-specific metrics to make "done" unambiguous.

### Developer
| Metric | Threshold | Tool |
| Statement/Line/Branch/Function coverage | ≥ 90% each | Vitest `--coverage` |
| TypeScript compile errors | 0 | `tsc --noEmit` |
| ESLint errors | 0 | ESLint |
| `console.log` / `debugger` in production code | 0 | ESLint `no-console` / `no-debugger` |

### Tester
| Metric | Threshold | Tool |
| Automated test pass rate | 100% | Playwright / Vitest |
| Open bugs (any severity P0–P3) | 0 | GitHub Issues |

### Architect
| Artifact | Required |
| Architecture diagram (C4 model) | Yes |
| API contract (OpenAPI or defined schema) | Yes |
| Architecture Decision Record (ADR) for key decisions | Yes |

### DevOps
| Metric | Threshold | Tool |
| CI pipeline (lint → test → type-check → build) | All green | GitHub Actions |
| Preview deployment | Live and accessible | Vercel |
| Production deployment | Gated on CI green + QA sign-off | Vercel |

## Checklist Status Values

| Status | Meaning |
| ------ | ------- |
| TODO | Work has not started |
| In Progress | Work is actively being done |
| Done | All DoD criteria met and verified |

## References

- [Epics, Stories and Themes — Atlassian](https://www.atlassian.com/agile/project-management/epics-stories-themes)
- [INVEST criteria for User Stories](https://www.agilealliance.org/glossary/invest/)
- [Writing Acceptance Criteria — Mike Cohn](https://www.mountaingoatsoftware.com/blog/clarifying-the-relationship-between-definition-of-done-and-conditions-of-satisfaction)
- [Definition of Done vs Acceptance Criteria](https://www.scrum.org/resources/blog/done-understanding-definition-done)
