---
name: role-card-generator
description: >
  Generates a complete agent role card in the bluestella-agency-pack Role Card format.
  Produces Role & Overview, Responsibilities, Tools & Stack, and Definition of Done with
  role-specific metrics and scoring checklist. Use when creating a new agent, adding an
  agent to PLANS.md, scaffolding a new team member role, or writing an agent role card
  from a plain-language description.
instructions:
  - agent-role-card
agents:
  - agency-pack-author
triggers: []
metadata:
  author: bluestella
  version: "1.0"
---

# Role Card Generator Skill

## Overview

Given a plain-language description of an agent role (or the relevant section from PLANS.md), this skill produces a fully populated role card at `agents/[team]/[agent-name].md`. Output follows the Role Card format defined in `AGENTS.md` and the template at `.github/templates/agent-role-card.md`.

## Steps

1. **Identify the role.** Extract or ask for: the role name, the team it belongs to, and a brief description of what it does. If generating from PLANS.md, read the relevant section under Step 1.

2. **Determine the team.** Map the role to one of: `management` | `analysis` | `architecture` | `frontend` | `backend` | `quality` | `devops`. This sets the output path and frontmatter `team` field.

3. **Write Role & Overview.** One paragraph. State the agent's primary ownership and position in the delivery pipeline. Reference the workflow hierarchy from PLANS.md Step 2 if relevant.

4. **Write Responsibilities.** 5–7 bulleted items. Each is an active, outcome-focused statement. If the role has sub-skills or sub-agents, list them as nested bullets under the relevant responsibility.

5. **Write Tools & Stack.** Produce a table of tools this specific role uses. For roles with TBD stack, mark tools as TBD and note that the Architecture Team will define the final stack.

6. **Write Definition of Done.** Write the overall DoD paragraph. Then build the Metrics & Scoring Checklist using role-specific criteria:
   - Developer roles → coverage thresholds, type safety, lint, debug artifacts
   - Architect roles → artifact completeness (diagrams, contracts, ADRs)
   - QA roles → bug counts by severity, test pass rates
   - DevOps roles → CI status, deployment targets, IaC coverage

7. **Add References.** Include 2–5 links to authoritative sources relevant to this role (official tool docs, OWASP, WCAG, agile standards, etc.).

8. **Output the file.** Write to `agents/[team]/[agent-name].md`. File name must be kebab-case.

9. **Update the roster.** Add or verify the role entry in the Agent Roster table in `AGENTS.md` and in the Step 1 roster in `PLANS.md`.

## Output Format

See `templates/agent-role-card.md` for the full output structure.

Key elements:
- YAML frontmatter (title, team, version)
- Four sections: Role & Overview · Responsibilities · Tools & Stack · Definition of Done
- Metrics & Scoring Checklist (role-specific, measurable criteria)
- References section

## Examples

**Input:** "Create the Business Analyst role card."

**Output path:** `agents/analysis/business-analyst.md`

**Output skeleton:**

```markdown
---
title: Business Analyst
team: analysis
version: 1.0.0
---

# Business Analyst

## Role & Overview
Translates business goals into structured requirements the engineering team consumes
to develop Epics, User Stories, Tasks, and Sub-tasks.

## Responsibilities
- Elicit and document business requirements from stakeholders.
- Write BRDs in Agile format (Epic → Story → Task → Sub-task).
- Define and maintain the requirements checklist (TODO / In Progress / Done).
- Write acceptance criteria and Definition of Done per work item.
- Score completeness using a requirements scoring matrix.
- Re-open requirements when QA or Security surfaces scope-changing issues.

## Tools & Stack
| Tool | Purpose | Cost |
| BRD Skill (`skills/brd/`) | Generate structured BRD documents | Free |

## Definition of Done
Requirements are documented to Epic → Story → Task → Sub-task level, acceptance
criteria are written, and the requirements checklist is fully up to date.

### Metrics & Scoring Checklist
| Metric | Threshold | Evidence |
| All User Stories have As a / I want / So that format | 100% | Manual review |
| All stories have Acceptance Criteria checklist | 100% | BRD document |
| All stories have DoD table with role criteria | 100% | BRD document |
| Requirements checklist status is current | 100% | Checklist table |
```

## Edge Cases

- If the role is listed as *(planned)* in AGENTS.md, create the file but set frontmatter `version: 0.1.0` to indicate it is a draft.
- If the tech stack for this role is genuinely undefined (Architecture Team has not finalised it), write TBD in the Tools & Stack table and add a note: "Stack defined by Architecture Team output."
- If generating from a PLANS.md description that conflicts with AGENTS.md, use PLANS.md as authoritative for responsibilities and AGENTS.md for boundaries and stack.
- If a role has sub-agents (e.g. Frontend Team → React Engineer, SEO Engineer), generate a separate role card for each sub-agent, not a combined card.

## References

See [references/REFERENCE.md](references/REFERENCE.md) for the Role Card format specification and writing-good-agents best practices.
