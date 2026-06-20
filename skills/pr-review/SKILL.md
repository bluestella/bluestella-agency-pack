---
name: pr-review
description: >
  Produces a structured PR Review Scorecard that gates merges on seven quality checks: unit test
  coverage, type safety, linting, code quality (SonarCloud), security vulnerabilities, QA bug
  checklist, and absence of debug artifacts. Use when conducting Tech Lead PR reviews, enforcing
  merge quality standards, or documenting review decisions.
instructions: []
agents:
  - tech-lead
triggers:
  - pr-score-below-threshold
metadata:
  author: bluestella
  version: "1.0"
---

# PR Review

## Overview

This skill produces a structured PR Review Scorecard. Each PR must pass all seven gates before merge is approved.

## Steps

1. **Check unit test coverage.** Verify coverage ≥ 90% via Vitest/Jest report.
2. **Check type safety.** Run `tsc --noEmit` — zero errors required.
3. **Check linting.** Run `pnpm lint` — zero violations required.
4. **Check code quality.** Review SonarCloud Quality Gate — must be green.
5. **Check security.** Confirm no critical/high CodeQL findings; Dependabot alerts resolved.
6. **Check QA bug checklist.** Verify all acceptance criteria tested; no open critical/high bugs.
7. **Check debug artifacts.** Scan diff for `console.log`, `TODO`, `FIXME`, commented-out code.
8. **Record overall result.** PASS → approve merge. FAIL → raise bug ticket, reassign to engineer.

## Output Format

A filled scorecard following [`templates/pr-scorecard-template.md`](templates/pr-scorecard-template.md).

## References

See [`references/REFERENCE.md`](references/REFERENCE.md) for gate thresholds and tooling links.
