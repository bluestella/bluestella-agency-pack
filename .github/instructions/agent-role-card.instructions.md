---
applyTo: "agents/**"
---

# Agent Role Card Authoring Rules

## File structure

Every role card lives at `agents/[team]/[agent-name].md`.
Valid team values: `management` | `analysis` | `architecture` | `frontend` | `backend` | `quality` | `devops`
File names: kebab-case only (e.g. `solution-architect.md`, `a11y-engineer.md`).

## Required frontmatter

```yaml
---
title: Human-readable role name
team: [team value from list above]
version: 1.0.0
---
```

## Required sections (in order)

### 1. Role & Overview
One paragraph. State what this agent owns and why it exists in the pipeline.
Do not describe what other agents do here.

### 2. Responsibilities
Bulleted list. Each bullet is an active, outcome-focused statement.
Format: verb + object + measurable qualifier where possible.
Example: "Design service boundaries and API contracts in collaboration with the Integration Architect."
Avoid: vague statements like "Help with architecture."

### 3. Tools & Stack
Markdown table with columns: Tool | Purpose | Cost
List only tools this specific role uses. Do not duplicate the full project stack.

### 4. Definition of Done
Paragraph stating the overall DoD, then a metrics and scoring checklist specific to this role.
The checklist must be measurable — thresholds, counts, or binary pass/fail.
Do not write generic DoD statements (e.g. "all tests pass") unless you specify the tool and threshold.
Role-specific DoD structure:
- Developer roles: test coverage %, lint errors, type errors, no debug artifacts
- Architect roles: artifact completeness (diagram produced, contract defined, etc.)
- QA roles: bug counts by severity, checklist completion
- DevOps roles: pipeline status, deployment targets, IaC coverage

## Content rules

- Write in present tense, third person (the role does X, not you should do X).
- Do not embed code snippets unless they are a config reference for the DoD.
- Cross-reference other agents by role name only; do not describe their internals.
- If the role has sub-skills, list them under Responsibilities with a nested bullet.
- References section is optional but recommended. Use format: `- [Title](URL)`.

## Template

Use `.github/templates/agent-role-card.md` when creating a new role card from scratch.
