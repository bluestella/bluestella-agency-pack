---
trigger: version-bump
from: Agency Pack Author
to: Agency Pack Author
severity: low
version: 1.0.0
score: null
last_evaluated: null
needs_review: false
---

# Hook: Version Bump — Revision History on File Change

## Trigger Condition

Any agent role card (`agents/**/*.md`), skill (`skills/**/SKILL.md`), hook (`hooks/**/*.md`), instruction (`instructions/**/*.md`), or root document (`AGENTS.md`, `PLANS.md`, `CONTRIBUTING.md`, `METRICS.md`, `LEARNINGS.md`, `templates/**/*.md`) is modified. The trigger fires at the point of writing the final edited content — before the file is saved.

## Version Bump Rules

Version numbers follow **Semantic Versioning** (`MAJOR.MINOR.PATCH`):

| Change size | Rule | Threshold | Example |
| ----------- | ---- | --------- | ------- |
| Small edit | Increment PATCH | < 50% of file lines changed | `1.0.0 → 1.0.1` |
| Significant rewrite | Increment MINOR, reset PATCH to 0 | 50–80% of file lines changed | `1.0.1 → 1.1.0` |
| Full rewrite | Increment MAJOR, reset MINOR and PATCH to 0 | > 80% of file lines changed | `1.1.0 → 2.0.0` |

**How to calculate change size:**

Count the total lines in the file before the edit. Count the lines added + deleted in the diff. Change percentage = (lines added + lines deleted) / (total lines before × 2) × 100.

For files with `metadata.version` (skills), the format is `"MAJOR.MINOR"` — only increment the relevant part and omit patch for skills.

## Trigger Payload

The editing agent must provide:

- **File path:** The file being modified
- **Lines before:** Total line count before the edit
- **Lines changed:** Count of lines added + deleted
- **Change %:** (lines changed / (lines before × 2)) × 100
- **Calculated bump:** PATCH | MINOR | MAJOR
- **Old version:** Current value of the `version` field in frontmatter
- **New version:** Computed new value

## Destination Action

1. Calculate the change percentage using the formula above.
2. Determine the appropriate bump (PATCH / MINOR / MAJOR) using the rules table.
3. Update the `version` field in the file's frontmatter to the new version.
4. If the file is `PLANS.md`: also update the `date` field to today's ISO date.
5. If the file is `METRICS.md` or `LEARNINGS.md`: bump is always PATCH unless the category structure changes (MINOR) or the scoring system changes (MAJOR).
6. Record the version change in a `## Revision History` section at the bottom of the file if one does not already exist. Format:

```markdown
## Revision History

| Version | Date | Author | Change summary |
| ------- | ---- | ------ | -------------- |
| 1.0.1 | 2026-06-20 | bluestella | Added edge case for vague goal inputs |
| 1.0.0 | 2026-06-01 | bluestella | Initial version |
```

## Resolution Criteria

This hook is resolved when all of the following are true:

- [ ] The `version` field in the file's frontmatter reflects the correct new version.
- [ ] A `## Revision History` table entry is appended at the bottom of the file.
- [ ] The entry includes: version, date (ISO), author, and a one-line change summary.

## Escalation

No escalation path. If a file lacks a `version` field in its frontmatter, add one at `1.0.0` before applying any bump. If a file's version is malformed (not semver), fix it to the nearest valid semver before bumping.

## Scope Exclusions

Do not apply version bumps to:
- `.github/**` (managed by sync script)
- `*.excalidraw` (visual files, not text artifacts)
- `.gitignore`, `.vscode/**` (tooling config)
- `docs/**` (general documentation, not governed artifacts)
