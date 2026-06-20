---
name: brd
description: >
  Generates a structured Business Requirements Document (BRD) following Agile hierarchy:
  Epic → User Story → Task → Sub-task. Produces acceptance criteria, a Definition of Done
  per role, and a requirements checklist with TODO / In Progress / Done status.
  Use when writing requirements, creating an epic, drafting user stories, defining
  acceptance criteria, or breaking down a business goal into development work items.
metadata:
  author: bluestella
  version: "1.0"
---

# BRD Skill

## Overview

Given a plain-language goal or feature description, this skill produces a fully structured BRD document ready for the engineering team to consume. Output follows the Epic → User Story → Task → Sub-task hierarchy defined in PLANS.md Step 3 and the Atlassian Agile model.

## Steps

1. **Clarify scope.** Ask the human for: the business goal (one sentence), the target persona or user, and any known constraints (deadline, tech stack, regulatory requirements). If the input already contains these, skip to step 2.

2. **Draft the Epic.** Write the Epic header using the template at `.github/templates/brd-epic.md`. Fill in: business goal, scope statement, priority.

3. **Identify User Stories.** Break the Epic goal into 2–5 User Stories. Each story must be independently deliverable and testable. Write each in As a / I want / So that format.

4. **Write Acceptance Criteria.** For each User Story, write a numbered checklist of acceptance criteria. Each criterion must be specific, testable, and binary (pass/fail).

5. **Define the Definition of Done per role.** For each User Story, fill the DoD table with role-specific criteria:
   - Developer: coverage thresholds, lint/type errors, no debug artifacts
   - Tester: automated test pass rate, open bug count = 0
   - Architect: required artifacts produced (diagram, contract, decision record)
   - DevOps: deployment targets reached, CI pipeline green

6. **Break down Tasks and Sub-tasks.** For each User Story, list the Tasks (concrete development units) and Sub-tasks (atomic implementation steps). Assign each to the appropriate agent role.

7. **Generate the requirements checklist.** Produce a table at the top of the Epic with all User Stories and Tasks listed, assignees, and status set to TODO.

8. **Output the document.** Write the complete BRD to a markdown file. Suggested path: `docs/requirements/[epic-name].md` or inline in PLANS.md under the relevant Step.

## Output Format

See `.github/templates/brd-epic.md` for the full output structure.

Key sections:
- Epic header (business goal, scope, priority)
- Requirements checklist table (all items, assignees, status)
- User Stories (As a / I want / So that)
- Acceptance Criteria per story (checklist)
- Definition of Done per role per story (table)
- Tasks and Sub-tasks per story (table)
- Epic Definition of Done (checklist)

## Examples

**Input:** "We need users to be able to log in with email and password."

**Output skeleton:**

```markdown
# Epic: User Authentication

Business Goal: Enable registered users to authenticate via email and password.

## User Stories

### Story 1: Email + Password Login
As a registered user
I want to log in with my email and password
So that I can access my account securely.

Acceptance Criteria:
- [ ] Login form accepts email and password fields
- [ ] Valid credentials redirect to the dashboard
- [ ] Invalid credentials show a non-revealing error message
- [ ] Account is locked after 5 failed attempts

Definition of Done:
| Role | Criteria | Tool |
| Developer | ≥ 90% coverage; 0 TS errors | Vitest; tsc |
| Tester | All ACs pass E2E; 0 open bugs | Playwright |
| DevOps | Feature deployed to preview | Vercel |
```

## Edge Cases

- If the input goal is too broad (spans multiple epics), split it and produce one BRD per epic.
- If the tech stack is not yet defined (TBD in PLANS.md), write Tasks without tool-specific DoD metrics and flag them for the Architecture Team to complete.
- If a User Story has no testable acceptance criteria, pause and ask the human to supply them before continuing.
- If a story crosses team boundaries (frontend + backend), list Tasks for each team separately and flag the dependency.

## References

See [references/REFERENCE.md](references/REFERENCE.md) for the Atlassian Agile model and scoring matrix documentation.
