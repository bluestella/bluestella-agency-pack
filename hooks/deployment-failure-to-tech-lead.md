---
trigger: deployment-failure
from: DevOps / Platform Engineer
to: Tech Lead
severity: critical
---

# Hook: DevOps Deployment Failure → Tech Lead

## Trigger Condition

**Source Agent:** DevOps / Platform Engineer  
**Destination Agent:** Tech Lead  
**Event:** CI/CD pipeline fails during any stage (lint, test, build, deploy)

**Failure Points:**

- Lint stage: ESLint errors
- Test stage: Test failures
- Type-check stage: TypeScript compilation errors
- SonarCloud stage: Quality Gate failed
- CodeQL stage: SAST findings
- Dependabot/CVE stage: Security vulnerabilities
- Build stage: Build failure
- Deployment stage: Vercel deploy rejected or failed

**Severity:**

- 🔴 Critical: Production deployment blocked, rollback required
- 🟠 High: Staging deployment failed, blocks QA testing
- 🟡 Medium: CI check failed, PR cannot merge
- 🔵 Low: Pre-merge check warning

---

## Trigger Payload

```json
{
  "event": "deployment_failure",
  "severity": "Critical|High|Medium|Low",
  "pipeline_stage": "lint|test|type-check|sonarcloud|codeql|dependabot|build|deploy",
  "environment": "preview|production",
  "branch": "main / preview / feature-branch",
  "commit_sha": "abc123def456",
  "pr_number": 1234,
  "failure_reason": "ESLint found 5 errors / Test failure in auth.test.ts / Build timeout",
  "logs": {
    "error": "Error message from CI/CD",
    "output": "Full build/test output",
    "link": "https://github.com/repo/actions/runs/12345"
  },
  "blocked_count": 3,
  "blocking_commits": ["abc123", "def456"],
  "devops_engineer": "Charlie Brown",
  "created_at": "ISO 8601 timestamp"
}
```

---

## Required Action

1. **DevOps Engineer** creates a GitHub issue labeled `devops:deployment-failure` with:
   - Failed pipeline stage and error message
   - Link to full CI/CD logs
   - Commit(s) that caused the failure
   - Affected branch/environment
   - Suggested remediation

2. **DevOps Engineer** posts alert to Slack:
   - **#deployments** channel: Deployment failure summary
   - **#incidents** channel if Critical (with @here mention)
   - Direct message to Tech Lead

3. **DevOps Engineer** assigns issue to Tech Lead

4. **Tech Lead** diagnoses and routes to responsible engineer:
   - **Lint/Type/Build error:** Route to Backend or Frontend engineer
   - **Test failure:** Route to QA or responsible engineer
   - **SonarCloud/CodeQL finding:** Route to Security Engineer or developer
   - **Dependency CVE:** Route to DevOps (update) or developer (code change)

---

## Tech Lead Resolution Actions

**Triage Checklist:**

- [ ] Identify root cause (which commit, which error, which engineer's code)
- [ ] Assess impact (does it block production? staging? merge only?)
- [ ] Create a GitHub issue for the responsible engineer
- [ ] Link issue to the PR or commit
- [ ] Notify responsible engineer via Slack + GitHub mention
- [ ] Establish SLA for fix (Critical: 1 hour, High: 4 hours, Medium: 24 hours)
- [ ] Monitor fix progress and escalate if SLA approaching

**Issue Example:**

```markdown
## Deployment Failure: ESLint errors on main

**Pipeline Stage:** Lint (CI job: ESLint)  
**Severity:** High  
**Environment:** production  
**Branch:** main  
**Commit:** abc123def456 (feat: add OAuth)

**Error:**
```

src/auth.ts:42:10 - error: Unexpected console statement (no-console)

```

**Root Cause:** Developer left console.log in production code.

**Remediation:** Remove console.log statement(s) and push fix to main.

**Assigned To:** Alice Chen (author of commit abc123)

**SLA:** Fix within 4 hours
```

---

## Resolution Criteria

### For Merge/Build Failures (Medium/Low):

- [ ] Root cause identified
- [ ] Fix committed to branch
- [ ] CI/CD pipeline re-runs and passes all stages
- [ ] PR reviewed and approved
- [ ] Merged to main or deployed

### For Production Failures (Critical/High):

- [ ] **Immediate:** Assess if rollback needed
  - If yes: Rollback to last known good commit immediately
  - If no: Proceed to fix
- [ ] Fix implemented and tested locally
- [ ] Fix committed and pushed
- [ ] CI/CD pipeline re-runs and passes all stages
- [ ] **Manual QA verification** in staging environment
- [ ] **Stakeholder sign-off** (Product, Security if applicable)
- [ ] Deploy to production
- [ ] Production monitoring confirms fix (no errors, latency normal)
- [ ] Post-incident review (why did this fail? how to prevent next time?)

---

## Escalation Path

- **Critical failure unfixed >1 hour:** Escalate to Product Manager + On-call incident commander
- **Production data loss or security breach:** Escalate to CEO + Legal + Security
- **Repeated failures (systemic):** Escalate to Tech Lead for architecture review or team training

---

## Automation

- Trigger: CI/CD pipeline detects failure
- Action: Create GitHub issue + label + assign to Tech Lead
- Notification: Slack alert to #deployments, @tech-lead
- Dashboard: CI/CD health dashboard updated
- Retry: For transient failures (network, timeout), auto-retry 2x
- Timeout: If unresolved for SLA duration → escalate to Product Manager
- Metrics: Track failure rate, MTTR (mean time to recovery), rollback frequency

---

## Prevention Checklist

- [ ] All developers run `pnpm lint`, `pnpm test`, `pnpm tsc --noEmit` before pushing
- [ ] Pre-commit hooks enabled (`husky`, `lint-staged`) to catch errors early
- [ ] Branch protection rules: All CI checks must pass before merge
- [ ] Stale PR reviews dismissed (prevents old approvals on new code)
- [ ] Main branch protected: no direct commits, PRs only
- [ ] Deployment dry-run in staging before production deployment

---

## Post-Deployment Validation

After successful deployment:

```markdown
## Post-Deployment Checklist

- [ ] Production monitoring shows normal metrics (latency, error rate, CPU)
- [ ] No spike in error logs (check CloudWatch / DataDog)
- [ ] No increase in support tickets
- [ ] New feature works as expected (manual spot-check)
- [ ] Database migrations completed successfully (if applicable)
- [ ] All scheduled jobs still running
- [ ] Third-party integrations responding normally
- [ ] No performance regression (compare to baseline)
```
