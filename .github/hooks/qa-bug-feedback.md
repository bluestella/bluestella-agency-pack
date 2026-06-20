---
trigger: qa-bug-found
from: Automation Testing Engineer
to: Frontend Engineer | Backend Engineer | React Engineer | Microservices Engineer
severity: critical | high | medium | low
---

# QA Bug Feedback Loop

## Trigger Condition

One or more bug tickets are raised by the Automation Testing Engineer during a visual, API, unit, or integration testing cycle. The trigger fires for every bug at any severity level (P0–P3) that remains open after a QA pass.

## Trigger Payload

The Automation Testing Engineer must provide the following when firing this hook:

- **Artifact:** GitHub Issue with label `bug:critical` | `bug:high` | `bug:medium` | `bug:low`
- **Severity:** Bug priority label (P0 critical / P1 high / P2 medium / P3 low)
- **Affected component:** File path, API endpoint, UI component, or service name
- **Reproduction steps:** Step-by-step instructions to reproduce the bug; or a failing test case reference
- **Test evidence:** Link to the failing Playwright or Vitest run in CI
- **Suggested assignee:** The engineer responsible for the affected component (Frontend or Backend)

## Destination Action

The assigned engineer must, in order:

1. Read the GitHub Issue and confirm severity classification with the Tech Lead if disputed.
2. Reproduce the issue locally using the provided reproduction steps.
3. Implement the fix in a dedicated branch: `fix/[scope]-[short-description]`.
4. Write or update the failing test to cover the fixed case.
5. Run the full CI pipeline locally: `pnpm lint && pnpm vitest run --coverage && pnpm tsc -p tsconfig.json --noEmit && pnpm build`. All checks must pass.
6. Open a PR against `main` with the standard PR body (Summary · Motivation · Test Plan · Checklist).
7. Update the GitHub Issue status to `In Progress`, then `Done` once the PR is merged.

## Resolution Criteria

This hook is resolved when all of the following are true:

- [ ] The GitHub Issue is closed with label `bug:resolved`.
- [ ] The fix PR is merged and CI pipeline is green.
- [ ] The Automation Testing Engineer has re-run the affected test suite and confirmed the bug no longer reproduces.
- [ ] The QA bug checklist item for this bug is marked Done.
- [ ] Tech Lead Gate 6 (QA Bug Checklist) shows 0 open bugs for this component.

## Escalation

If the bug is not resolved within:
- **P0 (Critical):** 24 hours → escalate to Tech Lead immediately; block deployment.
- **P1 (High):** 48 hours → Tech Lead notified; block sprint sign-off.
- **P2 (Medium):** Current sprint end → carry to next sprint with Tech Lead approval.
- **P3 (Low):** Next sprint → track in backlog.
