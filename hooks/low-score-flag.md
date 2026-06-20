---
trigger: low-score-flag
from: Agency Pack Author
to: Human (repository maintainer)
severity: high
version: 1.0.0
score: null
last_evaluated: null
needs_review: false
---

# Hook: Low Score Flag — Human Review Required

## Trigger Condition

An agent role card, skill, hook, or instruction file is evaluated against the METRICS.md scoring criteria and receives a score **below 7.0/10**. The trigger fires once per artifact per evaluation round.

## Trigger Payload

The Agency Pack Author must provide the following when firing this hook:

- **Artifact:** The file path of the low-scoring artifact (e.g. `skills/brd/SKILL.md`)
- **Score:** The numeric score (e.g. `6.2`)
- **Dimensions failing:** A list of the specific scoring dimensions that pulled the score below 7.0
- **Suggested fixes:** A concrete list of changes that would raise the score to ≥ 7.0
- **Severity:** High (scores 5–6.9) | Critical (scores below 5)

## Destination Action

1. The Agency Pack Author sets `needs_review: true` and writes the `score` and `last_evaluated` date in the artifact's frontmatter.
2. The Agency Pack Author adds the artifact to the **Flagged Artifacts** table in `METRICS.md` with its score, date, and reason.
3. The human is notified that at least one artifact requires attention (via the Flagged Artifacts table — no automated push notification).
4. The human reviews the artifact and the failing dimensions listed in the Flagged Artifacts table.
5. The human (or Agency Pack Author acting on human instruction) updates the artifact to address the failing dimensions.
6. The Agency Pack Author re-evaluates the artifact against the scoring criteria.
7. If the new score is ≥ 7.0: set `needs_review: false`, update `score` and `last_evaluated`, remove from the Flagged Artifacts table, bump `METRICS.md` version (patch).
8. If still below 7.0: keep the flag and update the `score` and reason in the Flagged Artifacts table.

## Resolution Criteria

This hook is resolved when all of the following are true:

- [ ] The artifact has been updated to address the low-scoring dimensions.
- [ ] The artifact's re-evaluated score is ≥ 7.0.
- [ ] `needs_review: false` is set in the artifact's frontmatter.
- [ ] The artifact is removed from the Flagged Artifacts table in `METRICS.md`.
- [ ] `METRICS.md` Full Scoreboard row is updated with the new score and date.

## Escalation

- **Score below 5.0:** Flag as critical. Human must review within the current sprint before the artifact is used in any authoring session.
- **Score has not improved across two evaluation rounds:** Human must decide whether to rewrite the artifact from scratch using the appropriate template.
- **Multiple artifacts flagged simultaneously:** Human prioritizes fixes by severity (critical first, then by how frequently the artifact is used).
