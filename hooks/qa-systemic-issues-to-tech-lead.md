---
title: Hook — QA Systemic Issues to Tech Lead
description: Trigger for when QA finds repeated failures indicating systemic code quality issues
---

# Hook: QA Systemic Issues → Tech Lead (Code Quality)

## Trigger Condition

**Source Agent:** Automation Testing Engineer  
**Destination Agent:** Tech Lead  
**Event:** Pattern of repeated QA failures indicates systemic code quality issue

**Detection:**
- Same test failing on multiple PRs (not one-off bugs)
- Same component failing different test scenarios
- Same error type (e.g., "undefined property" appearing 5+ times)
- Performance regression appearing across PRs
- A11y violations appearing consistently
- Same issue reopened multiple times

**Severity:**
- 🔴 Critical: Major architectural issue blocking all PRs
- 🟠 High: Multiple PRs failing, needs urgent review
- 🟡 Medium: Recurring issue, should address in team meeting
- 🔵 Low: Minor pattern, track and discuss in retrospective

---

## Trigger Payload

```json
{
  "event": "qa_systemic_issue_detected",
  "severity": "High",
  "issue_type": "memory_leak|architectural|pattern|security|performance",
  "description": "Database connection leaks in 5 different microservices",
  "pattern": "Connections not closed in error handlers (try-finally pattern missing)",
  "affected_components": [
    "users-service",
    "subscriptions-service",
    "payments-service",
    "notifications-service",
    "analytics-service"
  ],
  "occurrences": 5,
  "first_occurrence": "2026-06-10",
  "latest_occurrence": "2026-06-20",
  "root_cause_hypothesis": "No code review guideline for resource cleanup; developers unfamiliar with try-finally",
  "recommendation": "Team training on resource management + add ESLint rule to enforce try-finally",
  "assigned_to": "Tech Lead",
  "created_at": "ISO 8601 timestamp"
}
```

---

## Required Action

1. **QA / Automation Testing Engineer** documents the pattern:
   - What is the issue?
   - Which components/PRs show it?
   - When did it start?
   - Root cause hypothesis?

2. **QA** creates GitHub issue labeled `quality:systemic` + severity

3. **QA** posts to #team Slack:
   ```
   @tech-lead FYI: We're seeing database connection leaks in 5 different services.
   Same pattern: connections not closed in error handlers.
   Likely needs team training on try-finally pattern + ESLint rule.
   GitHub issue: #1234
   ```

4. **Tech Lead** analyzes the systemic issue:
   - Is this an architectural problem?
   - Is this a knowledge gap?
   - Is this a process/tooling problem?

---

## Tech Lead Resolution

### Analysis

**Tech Lead Action Items:**

1. **Root cause analysis:**
   - Is it an architectural issue? (microservice boundary problem?)
   - Is it a knowledge gap? (developers don't know best practice?)
   - Is it a tooling issue? (missing linting rule?)
   - Is it a code review issue? (reviewers not catching it?)

2. **Gather evidence:**
   ```
   SELECT failed_test_count FROM qa_dashboard
   WHERE issue_type = 'connection_leak'
   AND created_at >= '2026-06-10'
   ```

3. **Interview developers:**
   - "Why isn't try-finally used?"
   - "Did you know about this pattern?"
   - "Are there blockers?"

### Solution Options

| Option | Effort | Prevents Recurrence | Choose If |
| ------ | ------ | ------------------- | --------- |
| **Team training** | 2 hours | 80% | Knowledge gap |
| **Add ESLint rule** | 4 hours | 95% | Tooling gap |
| **Code review guideline** | 1 hour | 70% | Process gap |
| **Architectural fix** | 2-5 days | 100% | Architectural issue |
| **Combination** | 3 days | 99% | Multiple causes |

### Implementation

**Action Items for Team:**

- [ ] **P0 — Add ESLint rule for try-finally**
  - Owner: Tech Lead
  - Effort: 2 hours
  - Timeline: Today
  - Blocks all new PRs that don't follow pattern

- [ ] **P0 — Refactor existing code to use try-finally**
  - Owner: Assigned to developers of affected services
  - Effort: 1 day per service
  - Timeline: This sprint
  - Prioritize by severity

- [ ] **P1 — Team training on resource management**
  - Owner: Tech Lead
  - Effort: 1 hour training + 30 min Q&A
  - Timeline: Next team meeting
  - Document in team handbook

- [ ] **P1 — Add connection leak detection to monitoring**
  - Owner: DevOps
  - Effort: 3 hours
  - Timeline: This week
  - Alert if connections > 80% of pool size

---

## Resolution Criteria

- [ ] Root cause identified
- [ ] Solution implemented (ESLint rule added, training given, etc.)
- [ ] Existing code refactored where applicable
- [ ] Next 10 PRs using the new pattern (100% compliance)
- [ ] No new instances of the issue in new code
- [ ] Monitoring/alerts in place to prevent future occurrences

---

## Follow-Up

**After 1 week:**
- [ ] Are new PRs following the pattern?
- [ ] Any resistance or blockers?
- [ ] Should we enforce more strictly?

**After 1 month:**
- [ ] Is the issue completely resolved?
- [ ] Has the team internalized the lesson?
- [ ] Should this be documented in our coding standards?

---

## Escalation Path

- **Systemic issue unfixed >3 days:** Escalate to Engineering Manager + Product Manager (velocity impact)
- **Multiple systemic issues:** Escalate to CTO for broader technical strategy review
- **Indicates team skill gap:** Escalate to manager for training/hiring plan

---

## Automation

- Trigger: QA logs same issue 5+ times in same week
- Action: Create GitHub issue + send summary to Tech Lead
- Notification: Slack alert with pattern analysis
- Reminder: Weekly check-in until resolved
- Metrics: Track time from issue detection to fix deployment
