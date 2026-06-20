---
name: bug-report
description: >
  Generates standardized bug reports with clear reproduction steps, expected vs. actual behavior,
  severity classification, environment details, and evidence placeholders. Use when reporting bugs,
  creating QA tickets, communicating issues to developers, tracking quality issues, or building
  a structured bug database.
metadata:
  author: bluestella
  version: "1.0"
---

# Bug Report

## Overview

This skill produces structured bug reports that give developers everything needed to reproduce and fix an issue. Good reports are specific, reproducible, and include evidence. Each report maps to a single bug — never bundle multiple issues.

## Steps

1. **Write a specific title.** Not "upload broken" but "File upload >50MB fails silently with S3 403 error." Include the component, condition, and symptom.
2. **Classify severity.** Choose Critical / High / Medium / Low using the severity matrix in [`references/REFERENCE.md`](references/REFERENCE.md).
3. **Document the environment.** Browser/app version, OS, device, network, app version, backend version.
4. **Write numbered reproduction steps.** Each step must be exact. Someone unfamiliar with the feature should be able to reproduce the bug by following them.
5. **State expected vs. actual behavior.** Use checkboxes. Expected = what the acceptance criteria or design says should happen. Actual = what actually happens.
6. **Attach evidence.** Screenshots (3 max), video link (Loom/Gyazo), browser console errors, server logs.
7. **Add developer investigation hints.** List potential root causes and investigation steps — this accelerates triage significantly.
8. **Link related issues.** Duplicates, blockers, related tickets.

## Output Format

A single markdown bug report:

```
# Bug: [Specific title]
Severity / Status / Reported by / Date / Related ticket
## Summary           — 1–2 sentences
## Environment       — browser, OS, device, versions
## Steps to Reproduce — numbered list
## Expected Behavior  — checkbox list
## Actual Behavior    — checkbox list
## Evidence           — screenshots, video, logs
## Severity Assessment — matrix + rationale
## Acceptance Criteria for Fix
## For Developer       — root causes + investigation steps
## Linked Issues
## Sign-Off
```

Template: [`templates/bug-report-template.md`](templates/bug-report-template.md)

## Examples

**Input:** "File upload shows success but the file doesn't appear in the dashboard."

**Output:** Bug titled "File upload >50MB fails silently — file not stored in S3" with severity HIGH, 6 reproduction steps, expected/actual checklists, S3 log excerpts, and developer notes identifying expired IAM credentials as the likely root cause.

**Input:** "Button color is wrong on mobile."

**Output:** Bug titled "Submit button background is #1A73E9 instead of #1557B0 on iOS Safari 17" with severity LOW, 3 reproduction steps, and a single screenshot.

## Edge Cases

- Intermittent bug (can't always reproduce): document frequency ("happens ~30% of the time") and any conditions that increase likelihood.
- Bug found in production only: include production environment details and note if staging cannot reproduce.
- Security bug: use severity Critical/High; mark as `security` label; notify Security Architect directly (don't create a public GitHub issue).
- Duplicate bug: link to the original, close this one as duplicate.

## References

See [`references/REFERENCE.md`](references/REFERENCE.md) for the severity matrix and best practices for effective bug reporting.
