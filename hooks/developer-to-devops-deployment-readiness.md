---
title: Hook — Developer to DevOps (Deployment Readiness)
description: Trigger for when Developer signals feature is ready for DevOps deployment
---

# Hook: Developer → DevOps (Deployment Readiness Check)

## Trigger Condition

**Source Agent:** Frontend Engineer or Backend Engineer  
**Destination Agent:** DevOps / Platform Engineer  
**Event:** Developer marks feature as deployment-ready (all PR reviews complete, tests passing)

**Detection:**

- All PRs merged to main branch
- All CI/CD checks passing (lint, test, build, SonarCloud, CodeQL)
- All tech lead gates passing
- QA sign-off obtained
- Deployment plan documented
- Database migrations ready (if needed)

---

## Trigger Payload

```json
{
  "event": "deployment_ready_notification",
  "feature": "OAuth 2.0 Integration",
  "developer": "Alice Chen",
  "environment": "staging",
  "readiness_checklist": {
    "all_prs_merged": true,
    "ci_passing": true,
    "tech_lead_gates_passing": true,
    "qa_signed_off": true,
    "database_migrations": ["20260620_add_oauth_fields.sql"],
    "rollback_plan": "Roll back to commit abc123def456",
    "traffic_percentage": "10% canary, then 100%"
  },
  "expected_deployment_time": "2026-06-20 15:00 UTC",
  "assigned_to": "DevOps Engineer",
  "created_at": "ISO 8601 timestamp"
}
```

---

## Required Action

1. **Developer** creates deployment readiness checklist:

   ```markdown
   - [ ] All PRs merged to main
   - [ ] All CI checks passing
   - [ ] Tech Lead gates: all green
   - [ ] QA has tested in staging
   - [ ] Performance tested (load, CWV)
   - [ ] Security: CodeQL passing, no CVEs
   - [ ] Database migrations ready
   - [ ] Rollback procedure documented
   - [ ] Runbook updated
   - [ ] On-call briefed on changes
   ```

2. **Developer** posts in #deployments Slack channel:

   ```
   @devops OAuth 2.0 ready for production deployment
   - Feature branch: feat/oauth
   - Staging: verified working
   - Readiness: all gates passing
   - Requested deployment time: 2026-06-20 15:00 UTC
   - Canary: start at 10%, then 100%
   ```

3. **DevOps** reviews checklist:
   - All items checked?
   - Runbook clear?
   - Rollback tested?
   - On-call ready?

4. **DevOps** schedules deployment:
   - Check calendar for conflicts
   - Confirm with on-call engineer
   - Plan deployment window

---

## DevOps Actions

### Pre-Deployment (1 hour before)

- [ ] Verify all code is deployed to staging
- [ ] Verify database migrations in staging
- [ ] Run smoke tests in staging
- [ ] Brief on-call: what's deploying, what to monitor, rollback procedure
- [ ] Check monitoring dashboards baseline

### Deployment

- [ ] Deploy to production (blue-green or canary)
- [ ] Monitor error rate, latency, traffic
- [ ] If issues: prepare rollback
- [ ] Once confident: full traffic

### Post-Deployment (30 min)

- [ ] Monitor metrics: error rate, latency, CPU, memory
- [ ] Check logs for errors
- [ ] Verify feature working (manual spot-check)
- [ ] Get sign-off from developer / tech lead
- [ ] Update status page

---

## Resolution Criteria

- [ ] Feature successfully deployed to production
- [ ] All monitoring metrics normal
- [ ] No error spike or performance regression
- [ ] Developer verified feature working
- [ ] On-call briefed and monitoring
- [ ] Deployment documented in log

---

## Rollback Criteria

Rollback if:

- Error rate increases > 5%
- Response time p95 > 2x baseline
- Critical user-facing bug discovered
- Data inconsistency found

**Command:** `kubectl rollout undo deployment/payment-service` (or similar)

---

## Automation

- Trigger: Developer posts to #deployments with readiness checklist
- Action: Create deployment ticket, tag DevOps engineer
- Notification: Slack alert to on-call engineer + DevOps team
- Monitoring: Auto-capture baseline metrics before deployment
- Alerts: Monitor for error rate spike, latency spike during first 1 hour
