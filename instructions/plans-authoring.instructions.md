---
applyTo: "PLANS*.md"
---

# PLANS.md Authoring Rules

## What PLANS.md is

PLANS.md is the master implementation plan for the agency pack. It defines:
- The agent roster and role cards (Step 1)
- The agent workflow and feedback loops (Step 2)
- Skill definitions (Step 3)
- Supporting artifact types (Step 4)

`PLANS_Working Document.md` is a draft scratchpad — it is not authoritative. Changes must be promoted to `PLANS.md` explicitly.

## Hierarchy model (Atlassian Agile)

```
Epic
└── User Story (As a / I want / So that)
    └── Task
        └── Sub-task
```

### Epic
- One clear business goal.
- Contains multiple User Stories.
- Has an overall Definition of Done.

### User Story
Format:
```
**As a** [persona / agent role]
**I want** [capability or output]
**So that** [business or technical benefit]
```

- Every story must have Acceptance Criteria — a numbered or bulleted checklist.
- Every story must have a Definition of Done per role (developer, tester, architect, DevOps as applicable).
- Status: TODO | In Progress | Done

### Task
- One concrete unit of work that implements part of a User Story.
- Assigned to a specific agent role.
- Has its own acceptance criteria if non-trivial.

### Sub-task
- Smallest atomic unit. Typically one function, one endpoint, one test file, or one config block.
- Status tracked in the parent Task checklist.

## Adding a new agent to PLANS.md

1. Add the agent to the Step 1 roster table under the correct team heading.
2. Write the role card inline using the Role Card format (Role & Overview · Responsibilities · Tools & Stack · Definition of Done).
3. Update the Step 2 hierarchy diagram and feedback loop table if the agent introduces new hand-offs.
4. Create the actual role card file at `agents/[team]/[agent-name].md` following `.github/instructions/agent-role-card.instructions.md`.

## Adding a new skill to PLANS.md

1. Add the skill under Step 3 with: Input description, Output description, Feature list.
2. Create the skill directory at `skills/[skill-name]/SKILL.md` following `.github/instructions/skill-authoring.instructions.md`.
3. Update Step 4 artifact table to reference the new skill.

## Frontmatter

PLANS.md must maintain its frontmatter block:
```yaml
---
title: [document title]
description: [one-line description]
author: bluestella
date: [YYYY-MM-DD of last significant change]
version: [semver — bump minor for new agents or skills, patch for edits]
---
```

## Content rules

- Do not modify `PLANS_Working Document.md` to be authoritative — promote changes to `PLANS.md` only.
- The agent roster in Step 1 must stay in sync with the roster table in `AGENTS.md`.
- The Step 2 hierarchy diagram is ASCII art — preserve its structure when adding agents.
- All feedback loop additions go in both the diagram and the feedback loop table.
- Version bump is required on every PLANS.md edit.
