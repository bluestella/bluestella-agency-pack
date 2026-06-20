---
title: [ROLE_NAME]
team: [management|analysis|architecture|frontend|backend|quality|devops]
version: 1.0.0
---

# [ROLE_NAME]

## Role & Overview

[One paragraph. State what this agent owns, its position in the delivery pipeline, and the primary value it delivers. Do not describe what other agents do here.]

## Responsibilities

- [Active verb + outcome + qualifier. Example: "Design service boundaries and API contracts in collaboration with the Integration Architect."]
- [Responsibility 2]
- [Responsibility 3]
- [Add or remove bullets as needed. Minimum 3, aim for 5–7 concrete responsibilities.]

## Tools & Stack

| Tool | Purpose | Cost |
| ---- | ------- | ---- |
| [Tool name] | [What this role uses it for] | [Free / Paid / Built-in] |
| [Tool name] | [Purpose] | [Cost] |

> Stack decisions not yet finalised: mark as TBD.

## Definition of Done

[One paragraph describing the overall completion state for this role's deliverables.]

### Metrics & Scoring Checklist

[Delete sections that do not apply to this role. Add role-specific metrics.]

#### For Developer roles

| Metric | Threshold | Tool | How to Verify |
| ------ | --------- | ---- | ------------- |
| Statement coverage | ≥ 90% | Vitest `--coverage` | CI `test` job + Codecov |
| Line coverage | ≥ 90% | Vitest `--coverage` | CI `test` job + Codecov |
| Branch coverage | ≥ 90% | Vitest `--coverage` | CI `test` job + Codecov |
| Function coverage | ≥ 90% | Vitest `--coverage` | CI `test` job + Codecov |
| TypeScript compile errors | 0 | `tsc --noEmit` | CI `type-check` job |
| ESLint errors | 0 | ESLint | CI `lint` job |
| `console.log` / `debugger` in production code | 0 | ESLint `no-console` / `no-debugger` | CI `lint` job |

#### For Architect roles

| Artifact | Required | Format |
| -------- | -------- | ------ |
| [Architecture diagram / API contract / Data model] | Yes | [Mermaid.js / OpenAPI / Markdown table] |
| [Sequence diagram / Event schema] | Yes | [Mermaid.js / JSON Schema] |
| [Risk register entry] | Yes | [Markdown table in role card or dedicated doc] |

#### For QA roles

| Metric | Threshold | Tool | How to Verify |
| ------ | --------- | ---- | ------------- |
| Critical bugs open | 0 | GitHub Issues (`bug:critical`) | QA checklist — all Done |
| High bugs open | 0 | GitHub Issues (`bug:high`) | QA checklist — all Done |
| Medium bugs open | 0 | GitHub Issues (`bug:medium`) | QA checklist — all Done |
| Test suite pass rate | 100% | [Vitest / Playwright / k6] | CI `test` job |

#### For DevOps roles

| Metric | Threshold | Tool | How to Verify |
| ------ | --------- | ---- | ------------- |
| CI pipeline status | All jobs green | GitHub Actions | Actions dashboard |
| Deployment environments covered | preview + production | Vercel | Vercel dashboard |
| Infrastructure defined as code | 100% of resources | [IaC tool TBD] | IaC repo / PR diff |

---

## References

- [Reference 1 title](URL)
- [Reference 2 title](URL)
