---
name: brd
description: >
  Generates structured Business Requirements Documents (BRDs) following the Agile hierarchy
  (Epic → User Story → Task → Sub-task) with acceptance criteria, Definition of Done per role,
  and a requirements checklist with status tracking. Use when writing requirements, creating
  an epic, drafting user stories, defining acceptance criteria, breaking down a business goal
  into development work items, or organizing requirements in JIRA/GitHub.
instructions:
  - brd-authoring
agents:
  - business-analyst
  - product-manager
triggers: []
metadata:
  author: bluestella
  version: "1.0"
---

# BRD — Business Requirements Document

## Overview

This skill generates structured BRDs for Business Analysts and Product Managers. Output follows the Agile hierarchy (Epic → User Story → Task → Sub-task) with testable acceptance criteria, role-specific Definition of Done, and a centralized requirements checklist for status tracking.

## Steps

1. **Define the Epic.** Capture the business goal in plain language. Output: epic title, business outcome, success metrics, timeline, stakeholders, assumptions, and constraints.
2. **Write User Stories.** Break the epic into 3–5 shippable stories using "As a / I want / So that" format. Each story needs acceptance criteria (testable, not implementation-specific) and a story point estimate.
3. **Add Definition of Done per role.** Attach the DoD checklist from [`templates/dod-by-role.md`](templates/dod-by-role.md) to each story. Roles: Developer (Backend), Developer (Frontend), QA, Security, Product.
4. **Break into Tasks and Sub-tasks.** Decompose each story into 2–4 implementable tasks, each with 2–5 sub-tasks. Sub-tasks map directly to work items in JIRA/GitHub.
5. **Build the Requirements Checklist.** Create a table (ID, item, type, owner, status, sprint, notes) covering all stories, tasks, and sub-tasks. Status values: TODO / In Progress / Done / Blocked / Deferred.
6. **Get sign-off.** Route for approval: Product Manager, Tech Lead, Security Lead, Stakeholder.

## Output Format

A single markdown BRD document:

```
# Business Requirements Document: [Epic Name]
## Executive Summary
## Epic Definition        — title, outcome, metrics, timeline, stakeholders
## User Stories           — 3–5 stories, each with AC + DoD + estimate
## Tasks & Sub-tasks      — decomposed work items per story
## Requirements Checklist — status table for all items
## References             — mockups, API spec, compliance links
## Sign-Off               — approval checkboxes
```

Template: [`templates/brd-template.md`](templates/brd-template.md)
DoD reference: [`templates/dod-by-role.md`](templates/dod-by-role.md)

## Examples

**Input:** "Enable new users to register with email and password."

**Output:** Epic "User Registration & Onboarding" → 4 User Stories (registration, email verification, profile setup, error handling) → Tasks broken down per story → Requirements checklist with owner + sprint assignment.

**Input:** "Security found a STRIDE threat — rate limiting not enforced on signup."

**Output:** Update affected User Story's acceptance criteria to add "Rate limiting: max 5 attempts/IP/hour". Update checklist status of security item from Done to In Progress.

## Edge Cases

- Vague goal ("improve performance"): ask for a measurable success metric before writing the epic.
- Missing stakeholders: list TBD rather than skipping; flag for Product Manager to fill in.
- Security hook: if a STRIDE threat model is attached, automatically add relevant security ACs to affected stories.
- Re-scope during sprint: add a new row to the requirements checklist with status Deferred; never modify existing IDs.

## References

See [`references/REFERENCE.md`](references/REFERENCE.md) for requirements hierarchy rules, SMART criteria guidance, and Agile authoring best practices.
