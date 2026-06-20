---
trigger: learning-loop-update
from: Agency Pack Author
to: Agency Pack Author
severity: low
version: 1.0.0
score: null
last_evaluated: null
needs_review: false
---

# Hook: Learning Loop Update

## Trigger Condition

Any authoring session that creates, modifies, or deletes a file in `agents/`, `skills/`, `hooks/`, `instructions/`, or `templates/` and produces at least one net-new insight about how the pack should be structured, authored, or maintained. The trigger fires at the end of the session — not per file change.

## Trigger Payload

The Agency Pack Author must provide the following when firing this hook:

- **Artifact:** A proposed new entry (or entries) for `LEARNINGS.md` in the correct category section
- **Category:** One of: Agent Role Card Learnings | Skill Authoring Learnings | Hook Authoring Learnings | Instructions Authoring Learnings | Process & Structural Learnings
- **Evidence:** The specific file(s) changed and the reason the change was made
- **Change applied:** A one-line description of what was updated as a result of the learning

## Destination Action

1. Read `LEARNINGS.md` and identify the correct category for the new entry.
2. Write the entry in the standard format:
   ```markdown
   ### [YYYY-MM-DD] [Short descriptive title]

   **What happened:** [Brief description of the authoring scenario]

   **What we learned:** [The insight — pattern, anti-pattern, or rule]

   **Change applied:** [What was changed in the repository as a result]
   ```
3. Append the entry under the correct category. Do not modify existing entries.
4. Bump `LEARNINGS.md` frontmatter `version` (patch for a new entry, minor for a structural change to categories).
5. If the learning implies a change to an instruction file, template, or CONTRIBUTING.md — make that change in the same session.

## Resolution Criteria

This hook is resolved when all of the following are true:

- [ ] The new entry is present in `LEARNINGS.md` under the correct category.
- [ ] The entry follows the standard format (date, title, What happened, What we learned, Change applied).
- [ ] `LEARNINGS.md` frontmatter version is bumped.
- [ ] Any downstream instruction or template changes implied by the learning are applied in the same session.

## Escalation

This hook has no escalation path — learning entries are low-severity, non-blocking improvements. If a learning implies a breaking change to an existing artifact format (e.g. changing required frontmatter fields), escalate to the human for approval before applying.
