# Role Card Generator — Reference Documentation

## Role Card Format Specification

Source: `AGENTS.md` → Filename & Formatting Conventions

### Required Frontmatter

```yaml
---
title: Human-readable role name
team: management | analysis | architecture | frontend | backend | quality | devops
version: 1.0.0
---
```

### Required Sections

| Section | Purpose | Format |
| ------- | ------- | ------ |
| Role & Overview | One paragraph describing ownership and position in the pipeline | Prose |
| Responsibilities | Active, outcome-focused statements | Bulleted list |
| Tools & Stack | Tools specific to this role | Markdown table |
| Definition of Done | Completion state + scoring checklist | Prose + table |

### Responsibilities Writing Rules

Each bullet must be:
- Active voice (verb + object)
- Outcome-focused (what is produced, not what is attempted)
- Specific enough that another agent reading it knows what to do

Bad: "Help with architecture."
Good: "Synthesize input from Data, Security, and Integration Architects into a cohesive target-state design."

### Definition of Done Writing Rules

The DoD must be role-specific and measurable. Generic statements ("all tests pass") are insufficient unless paired with a threshold and a verification tool.

The DoD scoring checklist tells the Tech Lead exactly when to approve or fail a PR from this role.

## Writing Good AGENTS.md Files

Source: [Writing a Good AGENTS.md — Phil Schmid](https://www.philschmid.de/writing-good-agents)

Key principles applied to role cards:

- **Include WHAT:** The role's position in the pipeline and what it produces.
- **Include WHY:** The purpose of the role and its value to the team.
- **Include HOW:** Specific tools, commands, thresholds, and verification steps in the DoD.
- **Exclude:** Detailed codebase overviews (agents discover structure themselves), generic style guidelines (use linters), and task-specific instructions that don't apply universally to the role.
- **Use progressive disclosure:** The role card is the summary. Deep references go in `skills/`, `instructions/`, and `docs/`.

## Agent Roster (as of PLANS.md v1.2.0)

| Team | Agent | File | Status |
| ---- | ----- | ---- | ------ |
| Management | Tech Lead | `agents/management/tech-lead.md` | ✅ Exists |
| Management | Product Manager | `agents/management/product-manager.md` | 📋 Planned |
| Analysis | Business Analyst | `agents/analysis/business-analyst.md` | 📋 Planned |
| Architecture | Solution Architect | `agents/architecture/solution-architect.md` | 📋 Planned |
| Architecture | Integration Architect | `agents/architecture/integration-architect.md` | 📋 Planned |
| Architecture | Data Architect | `agents/architecture/data-architect.md` | 📋 Planned |
| Architecture | Security Architect | `agents/architecture/security-architect.md` | 📋 Planned |
| Frontend | React Engineer | `agents/frontend/react-engineer.md` | ✅ Exists |
| Frontend | React Native Engineer | `agents/frontend/react-native-engineer.md` | ✅ Exists |
| Frontend | SEO Engineer | `agents/frontend/seo-engineer.md` | 📋 Planned |
| Frontend | A11y Engineer | `agents/frontend/a11y-engineer.md` | 📋 Planned |
| Backend | Microservices Engineer | `agents/backend/microservices-engineer.md` | ✅ Exists |
| Quality | Automation Testing Engineer | `agents/quality/automation-testing-engineer.md` | ✅ Exists |
| Quality | Performance Testing Engineer | `agents/quality/performance-testing-engineer.md` | ✅ Exists |
| Quality | Security Engineer | `agents/quality/security-engineer.md` | ✅ Exists |
| DevOps | DevOps / Platform Engineer | `agents/devops/devops-engineer.md` | ✅ Exists |

## Team Naming Convention

| Team value | Agent examples |
| ---------- | -------------- |
| `management` | Tech Lead, Product Manager |
| `analysis` | Business Analyst |
| `architecture` | Solution Architect, Integration Architect, Data Architect, Security Architect |
| `frontend` | React Engineer, React Native Engineer, SEO Engineer, A11y Engineer |
| `backend` | Microservices Engineer |
| `quality` | Automation Testing Engineer, Performance Testing Engineer, Security Engineer |
| `devops` | DevOps / Platform Engineer |
