---
trigger: deployment-failure
from: DevOps / Platform Engineer
to: Tech Lead
severity: critical
---

# DevOps Deployment Failure Feedback Loop

## Trigger Condition

A deployment to any environment (preview or production) fails, or the CI pipeline fails at the build stage after all other gates have passed. The trigger fires immediately on any deployment failure that is not caused by an infrastructure outage outside the team's control.

## Trigger Payload

The DevOps / Platform Engineer must provide the following when firing this hook:

- **Artifact:** A GitHub Issue with label `bug:critical` and the deployment failure log (Vercel build log, GitHub Actions run link)
- **Severity:** Critical (all deployment failures are critical — they block delivery)
- **Affected environment:** `preview` | `production`
- **Affected commit:** SHA and PR number of the failing deployment
- **Failure point:** The step in the pipeline where the failure occurred (build / deploy / health check / rollback)
- **Error output:** The exact error message or log excerpt
- **Impact:** Whether production traffic is affected; whether a rollback was triggered

## Destination Action

### Tech Lead (immediate)

1. Read the bug ticket and the deployment failure log.
2. Determine the root cause category:
   - **Code-level failure:** A build error, test failure, or type error that passed CI but failed in the Vercel build environment — route back to the responsible engineer.
   - **Configuration failure:** A missing environment variable, misconfigured secret, or infrastructure misconfiguration — route back to the DevOps Engineer.
   - **Dependency failure:** A broken package or incompatible runtime version — route to the responsible engineer with the affected package identified.
3. Assign a fix task to the responsible engineer with the failure log attached.
4. If production is affected, confirm whether an immediate rollback is required. Authorise the DevOps Engineer to execute the rollback.

### Responsible Engineer (after Tech Lead routes the task)

1. Reproduce the failure locally using the exact build command: `pnpm build`.
2. Fix the root cause.
3. Open a hotfix PR against `main`: `fix/deployment-[short-description]`.
4. Ensure all CI gates pass before the PR is reviewed.
5. Request expedited review from the Tech Lead.

### DevOps / Platform Engineer (if rollback is authorised)

1. Execute rollback to the last known-good deployment in Vercel.
2. Confirm production traffic is restored and healthy.
3. Document the rollback in the incident log.
4. Monitor for 30 minutes post-rollback before closing the incident.

## Resolution Criteria

This hook is resolved when all of the following are true:

- [ ] The root cause has been identified and fixed.
- [ ] The fix is deployed successfully to the affected environment.
- [ ] Vercel deployment status is green.
- [ ] CI pipeline is fully green (lint → test → type-check → build → deploy).
- [ ] If production was affected: post-incident review notes are written and attached to the GitHub Issue.
- [ ] The GitHub Issue is closed with label `bug:resolved`.

## Escalation

- **Production outage > 15 minutes:** Notify stakeholders immediately. Tech Lead escalates to the Architecture Team if the failure indicates an architectural issue (e.g. service coupling, infrastructure capacity).
- **Recurring failures on the same component (3+ in one sprint):** Architecture Team is brought in to review the deployment strategy for that component.
- **Failed rollback:** Treat as a P0 incident. All engineering work stops until service is restored.
