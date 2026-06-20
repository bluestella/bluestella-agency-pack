---
trigger: pr-score-below-threshold
from: Tech Lead
to: Developer
severity: medium
---

# Hook: Tech Lead PR Review → Developer

## Trigger Condition

**Source Agent:** Tech Lead  
**Destination Agent:** Frontend Engineer or Backend Engineer  
**Event:** PR code review scores below quality gate threshold

**Detection:**

- Tech Lead runs 7-gate scoring checklist on PR
- One or more gates fail (red):
  1. Unit test coverage < 90%
  2. TypeScript compile errors (> 0)
  3. ESLint errors (> 0)
  4. SonarCloud Quality Gate failed
  5. Security vulnerabilities found (CVEs or SAST findings)
  6. Open QA bugs (P0-P3) on related component
  7. Debug artifacts found (console.log, debugger, etc.)

**Gate Status:**

- 🟢 **Green (PASS):** Gate criterion met
- 🔴 **Red (FAIL):** Gate criterion not met; bug ticket required
- 🟡 **Yellow (WARN):** Gate approaching threshold; accepted with ticket

---

## Trigger Payload

```json
{
  "event": "pr_review_score_below_threshold",
  "pr_number": 1234,
  "pr_title": "feat(auth): Add OAuth 2.0 integration",
  "developer_name": "Alice Chen",
  "branch": "feat/oauth",
  "gates": [
    {
      "gate": 1,
      "name": "Unit Test Coverage",
      "threshold": "≥ 90%",
      "actual": "85%",
      "status": "FAIL"
    },
    {
      "gate": 4,
      "name": "Code Quality (SonarCloud)",
      "threshold": "Quality Gate Passed",
      "actual": "Quality Gate Failed (3 Major issues)",
      "status": "FAIL"
    },
    {
      "gate": 7,
      "name": "No Debug Artifacts",
      "threshold": "0 console.log, debugger, TODO/FIXME",
      "actual": "2 console.log statements found",
      "status": "FAIL"
    }
  ],
  "failed_gate_count": 3,
  "failed_gates": [1, 4, 7],
  "overall_status": "BLOCKED",
  "tech_lead": "Bob Smith",
  "created_at": "ISO 8601 timestamp"
}
```

---

## Required Action

1. **Tech Lead** creates a GitHub issue labeled `bug:review-failure` with:
   - List of all failed gates
   - Specific failures (coverage %, SonarCloud issues, etc.)
   - Remediation steps for each gate
   - Link to the PR
   - Example: "Increase test coverage to 90%: add tests in `src/auth.test.ts` covering OAuth flow"

2. **Tech Lead** comments on PR with scoring summary:

   ```
   ❌ Code Review Score: BLOCKED

   Gate 1 — Unit Test Coverage: ❌ FAIL (85% < 90%)
   Gate 2 — Type Safety: ✅ PASS (0 TS errors)
   Gate 3 — Linting: ✅ PASS (0 ESLint errors)
   Gate 4 — Code Quality: ❌ FAIL (SonarCloud 3 Major issues)
   Gate 5 — Security: ✅ PASS (0 CVEs)
   Gate 6 — QA Bugs: ✅ PASS (0 open bugs)
   Gate 7 — No Debug Artifacts: ❌ FAIL (2 console.log found)

   🔴 Overall: BLOCKED FOR MERGE

   Issues #1234, #1235, #1236 raised.
   Please fix and re-request review.
   ```

3. **Tech Lead** reassigns PR back to developer with status "Requested Changes"

4. **Tech Lead** creates GitHub issues for each failed gate:
   - Issue title: "[PR #1234] Gate X: [specific failure]"
   - Issue body: Remediation steps + link to PR
   - Labels: `bug:review-failure`, `bug:high` or `bug:medium`
   - Assigned to: Developer who opened the PR

---

## Developer Resolution Actions

For each failed gate:

| Gate                | Failure                | Remediation                                                             |
| ------------------- | ---------------------- | ----------------------------------------------------------------------- |
| 1 — Coverage        | Coverage < 90%         | Add tests to reach 90% coverage: `pnpm vitest run --coverage`           |
| 2 — Type Safety     | TS errors              | Run `tsc --noEmit` and fix all errors                                   |
| 3 — Linting         | ESLint errors          | Run `pnpm lint` and fix all errors                                      |
| 4 — Code Quality    | SonarCloud failed      | Address Major/Critical issues in SonarCloud dashboard                   |
| 5 — Security        | CVEs/SAST findings     | Fix CVEs: update dependencies; fix SAST findings: address CodeQL issues |
| 6 — QA Bugs         | Open bugs on component | Verify bugs are resolved or schedule separately                         |
| 7 — Debug Artifacts | console.log / debugger | Remove all `console.log`, `debugger`, untracked TODO comments           |

---

## Resolution Criteria

- [ ] Developer fixes all failed gates
- [ ] Developer pushes fixes and runs CI/CD pipeline locally to verify
- [ ] All gates now show 🟢 PASS
- [ ] Developer re-requests review from Tech Lead
- [ ] Tech Lead re-runs scoring checklist, verifies all gates green
- [ ] Tech Lead approves PR and merges

---

## Escalation Path

- **Same gate fails on multiple PRs (systemic issue):** Escalate to Tech Lead → Team discussion on design patterns or testing strategy
- **Developer ignores feedback for >3 days:** Escalate to manager/team lead for coaching
- **Blocker for release deadline:** Escalate to Product Manager for timeline negotiation

---

## Automation

- Trigger: Tech Lead runs 7-gate checklist on PR
- Action: Create GitHub issues for each failed gate + label
- Notification: Slack alert to developer + team channel
- Dashboard: Quality metrics dashboard updated
- Re-trigger: Developer pushes commits → CI runs → Tech Lead re-checks gates
- Auto-escalate: If gates not fixed for 5 business days → escalate to manager

---

## Tech Lead Gate Scoring Template

```markdown
## Code Review Score: [PR Title]

### Gates

| Gate | Criterion                 | Threshold           | Actual        | Status  |
| ---- | ------------------------- | ------------------- | ------------- | ------- |
| 1    | Unit Test Coverage        | ≥ 90%               | 87%           | 🔴 FAIL |
| 2    | Type Safety (tsc)         | 0 errors            | 0             | ✅ PASS |
| 3    | Linting (ESLint)          | 0 errors            | 2             | 🔴 FAIL |
| 4    | Code Quality (SonarCloud) | Quality Gate Passed | Failed        | 🔴 FAIL |
| 5    | Security (CodeQL / CVEs)  | 0 findings          | 1 CVE         | 🔴 FAIL |
| 6    | QA Bugs                   | 0 open              | 0             | ✅ PASS |
| 7    | Debug Artifacts           | 0 found             | 3 console.log | 🔴 FAIL |

### Overall Score

🔴 **BLOCKED FOR MERGE** (5/7 gates passing)

### Issues Raised

- #1234: Gate 1 — Coverage < 90%
- #1235: Gate 3 — ESLint errors
- #1236: Gate 4 — SonarCloud Quality Gate failed
- #1237: Gate 5 — CVE found in dependency
- #1238: Gate 7 — Debug artifacts found

### Next Steps

Developer to fix all failed gates and re-request review.
```
