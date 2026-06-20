---
trigger: pr-score-below-threshold
from: Tech Lead
to: Frontend Engineer | Backend Engineer | React Engineer | Microservices Engineer
severity: high
---

# PR Score Fail Feedback Loop

## Trigger Condition

The Tech Lead completes a PR review using the 7-gate scoring checklist (defined in `agents/management/tech-lead.md`) and one or more gates fail. The trigger fires immediately on any red gate — the PR is not approved.

## Trigger Payload

The Tech Lead must provide the following when firing this hook:

- **Artifact:** A GitHub Issue with label `bug:high` or higher, linked to the failing PR
- **Severity:** High (gate failures block merge by default; escalate to Critical if Gate 5 — Security is red)
- **Affected component:** The PR number, branch name, and the specific files or functions that caused the failure
- **Failing gates:** A completed Summary Scorecard from the tech-lead role card, with failing gates clearly marked
- **Reproduction steps:** The exact CI command or tool output that shows the failure (e.g. Vitest coverage report, SonarCloud gate status, `pnpm audit` output)
- **Suggested fix:** The Tech Lead's recommended remediation — specific, not generic

## Failing Gate Reference

| Gate | Failure Condition | Tool |
| ---- | ----------------- | ---- |
| 1 — Unit Test Coverage | Any dimension < 90% (statement/line/branch/function) | Vitest `--coverage` + Codecov |
| 2 — Type Safety | Any TypeScript compile error | `tsc --noEmit` |
| 3 — Linting | Any ESLint error or enforced-rule warning | ESLint |
| 4 — Code Quality | SonarCloud gate not "Passed"; any Blocker/Critical/Major; duplication ≥ 3%; complexity > 15 | SonarCloud |
| 5 — Security Vulnerabilities | Any open CVE (any severity); any CodeQL finding; any hardcoded secret | `pnpm audit`; CodeQL; Secret Scanning |
| 6 — QA Bug Checklist | Any open bug (P0–P3) in GitHub Issues | GitHub Issues |
| 7 — No Debug Artifacts | Any `console.log`, `debugger`, or untracked TODO/FIXME | ESLint |

## Destination Action

The assigned engineer must, in order:

1. Read the bug ticket and the Summary Scorecard. Confirm which gates failed and why.
2. Address each failing gate:
   - **Gate 1:** Add missing tests until coverage thresholds are met.
   - **Gate 2:** Fix all TypeScript errors. Run `pnpm tsc -p tsconfig.json --noEmit` to verify.
   - **Gate 3:** Fix all ESLint errors. Run `pnpm lint` to verify.
   - **Gate 4:** Resolve SonarCloud findings. Refactor functions with complexity > 15.
   - **Gate 5:** Update vulnerable dependencies (`pnpm update [package]`); fix CodeQL findings; remove hardcoded secrets.
   - **Gate 6:** Fix all open bugs before re-submitting the PR.
   - **Gate 7:** Remove all `console.log`, `debugger`, and untracked TODO/FIXME statements.
3. Push fixes to the same PR branch.
4. Re-run the full CI pipeline: `pnpm lint && pnpm vitest run --coverage && pnpm tsc -p tsconfig.json --noEmit && pnpm build`.
5. Comment on the PR with the updated gate results (paste the Summary Scorecard with all gates now green).
6. Request re-review from the Tech Lead.

## Resolution Criteria

This hook is resolved when all of the following are true:

- [ ] All 7 gates are green in the CI pipeline.
- [ ] SonarCloud PR Quality Gate status is "Passed".
- [ ] Tech Lead has re-reviewed and approved the PR.
- [ ] The PR is merged to `main`.
- [ ] The bug ticket is closed.

## Escalation

- If the same gate fails on 3 consecutive PRs from the same engineer, the Tech Lead raises a systemic quality issue ticket and schedules a coaching session.
- If Gate 5 (Security) is red with a Critical CVE, the PR is blocked from all branches immediately and escalated to the Security Architect.
