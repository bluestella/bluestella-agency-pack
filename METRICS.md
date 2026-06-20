---
title: METRICS.md — Agency Pack Performance Scoreboard
description: Central scoreboard for all agents, skills, hooks, and instructions. Scores below 7/10 are flagged for human review.
author: bluestella
date: 2026-06-20
version: 1.0.0
---

# METRICS.md

> **Purpose:** This file tracks the quality score of every agent, skill, hook, and instruction in the repository. Scores are evaluated periodically and written back to each artifact's frontmatter (`score`, `last_evaluated`, `needs_review`). Any artifact scoring **below 7/10** is flagged — a `needs_review: true` entry appears here and in the artifact's frontmatter to alert a human to update it.

---

## Scoring Criteria

Each artifact type is scored on a 0–10 scale using the criteria below. A score is the weighted average of all applicable dimensions.

### Agent Role Cards (agents/**/*)

| Dimension | Weight | How to Score |
| --------- | ------ | ------------ |
| All four required sections present (Role & Overview, Responsibilities, Tools & Stack, DoD) | 20% | 10 = all present; 0 = any missing |
| Frontmatter complete (title, team, version, skills, hooks) | 20% | 10 = all fields; deduct 2 per missing field |
| Responsibilities are outcome-focused and measurable | 20% | 10 = all bullets have verb + outcome + qualifier; deduct 2 per vague bullet |
| DoD contains role-specific, measurable metrics | 20% | 10 = metrics table populated; deduct 2 per generic or missing row |
| Referenced skills and hooks exist in the repository | 20% | 10 = all references resolve; deduct 2 per broken reference |

### Skills (skills/**/SKILL.md)

| Dimension | Weight | How to Score |
| --------- | ------ | ------------ |
| `name` matches directory name exactly | 15% | 10 = match; 0 = mismatch |
| `description` ≤ 1024 chars and includes clear trigger keywords | 15% | 10 = complete; deduct 2 per missing element |
| All required sections present (Overview, Steps, Output Format, Examples, Edge Cases) | 20% | 10 = all present; deduct 2 per missing section |
| Steps are discrete and reference specific tools/templates | 20% | 10 = all steps actionable; deduct 2 per vague step |
| SKILL.md body ≤ 500 lines | 15% | 10 = within limit; 5 = 500–600 lines; 0 = > 600 lines |
| `instructions`, `agents`, `triggers` frontmatter populated | 15% | 10 = all populated; deduct 3 per missing field |

### Hooks (hooks/**)

| Dimension | Weight | How to Score |
| --------- | ------ | ------------ |
| All six required sections present (Trigger Condition, Payload, Destination Action, Resolution Criteria, Escalation, plus frontmatter) | 25% | 10 = all present; deduct 2 per missing |
| `from` and `to` agents both exist in PLANS.md roster | 25% | 10 = both resolve; 5 = one missing; 0 = both missing |
| Resolution criteria are verifiable (reference a tool, checklist, or CI gate) | 25% | 10 = all criteria are binary-verifiable; deduct 2 per vague criterion |
| Escalation path is defined and actionable | 25% | 10 = concrete SLA and next action; 5 = partial; 0 = missing |

### Instructions (instructions/**)

| Dimension | Weight | How to Score |
| --------- | ------ | ------------ |
| `applyTo` glob present and correct | 25% | 10 = present and valid; 0 = missing |
| Content is imperative and step-by-step (no narrative prose) | 25% | 10 = fully imperative; deduct 2 per narrative paragraph |
| No rules duplicated from other instruction files | 25% | 10 = unique; deduct 2 per duplicate rule found |
| References correct templates and output paths | 25% | 10 = all paths resolve; deduct 2 per broken reference |

---

## Flag Policy

An artifact is flagged (`needs_review: true`) when its score is **below 7.0**. Flagged artifacts appear in the table below. A human must review, update, and re-score the artifact to clear the flag.

To clear a flag:
1. Update the artifact to address the low-scoring dimensions.
2. Re-score the artifact using the criteria above.
3. Update `score`, `last_evaluated`, and set `needs_review: false` in the artifact's frontmatter.
4. Remove the artifact from the Flagged Artifacts table below.
5. Bump `METRICS.md` `version` (patch).

---

## Flagged Artifacts

> Artifacts with score < 7/10. Human review required.

| Artifact | Path | Score | Last Evaluated | Reason |
| -------- | ---- | ----- | -------------- | ------ |
| *(none)* | — | — | — | — |

---

## Full Scoreboard

> All artifacts. Updated when scores are evaluated. `—` means not yet evaluated.

### Agents

| Agent | Path | Score | Last Evaluated | Needs Review |
| ----- | ---- | ----- | -------------- | ------------ |
| Tech Lead | agents/management/tech-lead.md | — | — | false |
| Product Manager | agents/management/product-manager.md | — | — | false |
| Business Analyst | agents/analysis/business-analyst.md | — | — | false |
| Solution Architect | agents/architecture/solution-architect.md | — | — | false |
| Integration Architect | agents/architecture/integration-architect.md | — | — | false |
| Data Architect | agents/architecture/data-architect.md | — | — | false |
| Security Architect | agents/architecture/security-architect.md | — | — | false |
| React Engineer | agents/frontend/react-engineer.md | — | — | false |
| React Native Engineer | agents/frontend/react-native-engineer.md | — | — | false |
| SEO Engineer | agents/frontend/seo-engineer.md | — | — | false |
| Accessibility Engineer | agents/frontend/a11y-engineer.md | — | — | false |
| Microservices Engineer | agents/backend/microservices-engineer.md | — | — | false |
| Automation Testing Engineer | agents/quality/automation-testing-engineer.md | — | — | false |
| Performance Testing Engineer | agents/quality/performance-testing-engineer.md | — | — | false |
| Security Engineer | agents/quality/security-engineer.md | — | — | false |
| DevOps Engineer | agents/devops/devops-engineer.md | — | — | false |
| Agency Pack Author | agents/tools/agency-pack-author.md | — | — | false |

### Skills

| Skill | Path | Score | Last Evaluated | Needs Review |
| ----- | ---- | ----- | -------------- | ------------ |
| brd | skills/brd/SKILL.md | — | — | false |
| role-card-generator | skills/role-card-generator/SKILL.md | — | — | false |
| accessibility-audit | skills/accessibility-audit/SKILL.md | — | — | false |
| adr | skills/adr/SKILL.md | — | — | false |
| api-contract-specification | skills/api-contract-specification/SKILL.md | — | — | false |
| bug-report | skills/bug-report/SKILL.md | — | — | false |
| c4-architecture-diagramming | skills/c4-architecture-diagramming/SKILL.md | — | — | false |
| data-architecture | skills/data-architecture/SKILL.md | — | — | false |
| database-schema-design | skills/database-schema-design/SKILL.md | — | — | false |
| integration-architecture | skills/integration-architecture/SKILL.md | — | — | false |
| performance-baseline | skills/performance-baseline/SKILL.md | — | — | false |
| post-incident-review | skills/post-incident-review/SKILL.md | — | — | false |
| pr-review | skills/pr-review/SKILL.md | — | — | false |
| release-notes | skills/release-notes/SKILL.md | — | — | false |
| security-architecture | skills/security-architecture/SKILL.md | — | — | false |
| security-requirement | skills/security-requirement/SKILL.md | — | — | false |
| seo-checklist | skills/seo-checklist/SKILL.md | — | — | false |
| solution-architecture | skills/solution-architecture/SKILL.md | — | — | false |
| sprint-ceremonies | skills/sprint-ceremonies/SKILL.md | — | — | false |
| stride-threat-modelling | skills/stride-threat-modelling/SKILL.md | — | — | false |
| test-plan | skills/test-plan/SKILL.md | — | — | false |

### Hooks

| Hook | Path | Score | Last Evaluated | Needs Review |
| ---- | ---- | ----- | -------------- | ------------ |
| qa-test-findings-to-developer | hooks/qa-test-findings-to-developer.md | — | — | false |
| qa-systemic-issues-to-tech-lead | hooks/qa-systemic-issues-to-tech-lead.md | — | — | false |
| tech-lead-pr-score-to-developer | hooks/tech-lead-pr-score-to-developer.md | — | — | false |
| tech-lead-to-architecture-technical-debt | hooks/tech-lead-to-architecture-technical-debt.md | — | — | false |
| security-finding-to-ba-requirement | hooks/security-finding-to-ba-requirement.md | — | — | false |
| security-findings-to-dev-architect | hooks/security-findings-to-dev-architect.md | — | — | false |
| performance-bottleneck-to-dev-architect | hooks/performance-bottleneck-to-dev-architect.md | — | — | false |
| developer-to-devops-deployment-readiness | hooks/developer-to-devops-deployment-readiness.md | — | — | false |
| devops-to-security-infrastructure-audit | hooks/devops-to-security-infrastructure-audit.md | — | — | false |
| deployment-failure-to-tech-lead | hooks/deployment-failure-to-tech-lead.md | — | — | false |
| product-manager-tech-lead-roadmap-conflict | hooks/product-manager-tech-lead-roadmap-conflict.md | — | — | false |
| architecture-enforcement-api-compliance | hooks/architecture-enforcement-api-compliance.md | — | — | false |
| learning-loop-update | hooks/learning-loop-update.md | — | — | false |
| low-score-flag | hooks/low-score-flag.md | — | — | false |
| version-bump | hooks/version-bump.md | — | — | false |

### Instructions

| Instruction | Path | Score | Last Evaluated | Needs Review |
| ----------- | ---- | ----- | -------------- | ------------ |
| api-patterns | instructions/api-patterns.instructions.md | — | — | false |
| brd-authoring | instructions/brd-authoring.instructions.md | — | — | false |
| c4-diagramming | instructions/c4-diagramming.instructions.md | — | — | false |
| security | instructions/security.instructions.md | — | — | false |
| testing | instructions/testing.instructions.md | — | — | false |
| skill-authoring | instructions/skill-authoring.instructions.md | — | — | false |
| agent-role-card | instructions/agent-role-card.instructions.md | — | — | false |
| hook-authoring | instructions/hook-authoring.instructions.md | — | — | false |
| plans-authoring | instructions/plans-authoring.instructions.md | — | — | false |
