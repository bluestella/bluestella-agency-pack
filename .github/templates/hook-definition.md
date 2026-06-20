---
trigger: [event-name-kebab-case]
from: [Source Agent Role — must match PLANS.md roster]
to: [Destination Agent Role — must match PLANS.md roster]
severity: critical | high | medium | low
---

# [Hook Display Name]

## Trigger Condition

[One sentence. State the exact event or threshold that fires this hook.]

Example: "One or more QA bug tickets at any severity level remain open after a QA cycle completes."

## Trigger Payload

The source agent must provide the following when firing this hook:

- **Artifact:** [The document, ticket, or output containing the finding — e.g. "QA bug report in GitHub Issues"]
- **Severity:** [The severity level of the finding — e.g. "P0–P3 bug label"]
- **Affected component:** [The file, service, or feature that is impacted]
- **Reproduction steps:** [How to reproduce the issue — link or inline]
- **Suggested assignee:** [The specific agent or engineer to whom the work is re-assigned]

## Destination Action

Steps the destination agent must take when it receives this hook:

1. [Acknowledge the trigger — e.g. "Read the bug report and confirm severity."]
2. [Re-run the relevant development or design cycle — e.g. "Fix the identified code defect."]
3. [Verify the fix — e.g. "Run the affected test suite and confirm all tests pass."]
4. [Update the bug checklist status to Done.]
5. [Notify the source agent that the fix is ready for re-validation.]

## Resolution Criteria

This hook is resolved when all of the following are true:

- [ ] [Criterion 1 — specific, verifiable — e.g. "The GitHub Issue is closed with label `bug:resolved`."]
- [ ] [Criterion 2 — e.g. "CI pipeline is green (lint → test → type-check → build)."]
- [ ] [Criterion 3 — e.g. "The source agent (QA) has re-run validation and confirmed the fix."]

## Escalation

If resolution criteria are not met within [1 sprint / 48 hours / defined SLA]:

- [Escalation action — e.g. "Tech Lead is notified and the bug ticket is promoted to the next severity level."]
- [Secondary escalation — e.g. "If still unresolved, the feature is blocked from deployment until resolved."]
