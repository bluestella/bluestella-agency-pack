---
name: accessibility-audit
description: >
  Produces a structured Accessibility Audit report covering automated scan results, manual testing
  findings (keyboard, screen reader, colour contrast), categorized issues by severity (Critical /
  Serious / Moderate), and a release checklist. Use when auditing a product for WCAG compliance,
  documenting accessibility findings after a sprint, or preparing a pre-launch accessibility sign-off.
instructions:
  - testing
agents:
  - a11y-engineer
  - automation-testing-engineer
triggers: []
metadata:
  author: bluestella
  version: "1.0"
---

# Accessibility Audit

## Overview

This skill produces a structured Accessibility Audit report that documents findings from automated and manual testing, categorizes issues by severity, and provides a release checklist.

## Steps

1. **Run automated scans.** Use axe-core (jest-axe for unit tests, axe-playwright for E2E). Record critical, serious, and moderate violation counts.
2. **Manual testing.** Test keyboard-only navigation, screen reader (NVDA on Windows, VoiceOver on Mac), colour contrast (WAVE or Lighthouse), and zoom to 200%.
3. **Categorize findings.** Sort into Critical (blocks access), Serious (significant difficulty), Moderate (some difficulty), and Minor.
4. **Write the executive summary.** State overall status, WCAG level, and issue counts.
5. **Produce the release checklist.** List all items that must pass before launch.

## Output Format

A single markdown document following the structure in [`templates/accessibility-audit-template.md`](templates/accessibility-audit-template.md).

## References

See [`references/REFERENCE.md`](references/REFERENCE.md) for WCAG levels, severity definitions, and testing tools.
