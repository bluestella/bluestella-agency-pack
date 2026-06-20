---
trigger: technical-debt-architectural-review
from: Tech Lead
to: Solution Architect
severity: medium
---

# Hook: Tech Lead ↔ Architecture Team — Technical Debt & Alignment

## Trigger Condition

**Source Agent:** Tech Lead  
**Destination Agent:** Solution Architect (or specific domain architect)  
**Event:** Tech Lead identifies technical debt or engineering-architecture misalignment during code reviews

**Detection:**

- Multiple PRs failing code review for same architectural reason
- Developer requests architectural change during implementation
- Performance bottleneck traced to architectural choice
- Security vulnerability related to system design
- Scaling issues (can't handle expected load)

**Severity:**

- 🔴 Critical: Blocks feature delivery, security risk, scalability risk
- 🟠 High: Impacts multiple teams, affects future velocity
- 🟡 Medium: Accumulating technical debt, should address in next quarter
- 🔵 Low: Nice-to-have improvements, low priority

---

## Trigger Payload

```json
{
  "event": "technical_debt_identified",
  "severity": "Critical|High|Medium|Low",
  "source": "tech_lead",
  "category": "architectural|scalability|security|performance|maintainability",
  "description": "Multiple PRs failing because microservice boundary unclear",
  "affected_components": ["users-service", "subscriptions-service"],
  "evidence": [
    "PR #234 — Shared responsibility between users and subscriptions",
    "PR #245 — API contract conflict between services",
    "PR #256 — Duplicate business logic in both services"
  ],
  "recommendation": "Architecture review needed to clarify service boundaries",
  "assigned_to": "Solution Architect",
  "created_at": "ISO 8601 timestamp"
}
```

---

## Required Action

1. **Tech Lead** creates GitHub issue labeled `debt:architectural` with severity tag
2. Issue includes:
   - Problem statement (what's the debt?)
   - Evidence (which PRs/code show the problem?)
   - Impact (how many teams affected? velocity loss?)
   - Recommendation (what should we do?)
3. Issue is assigned to Solution Architect
4. Issue is added to backlog for next architecture review meeting

---

## Architecture Team Response

1. **Solution Architect** schedules review meeting (within 1 week)
2. Attendees: Solution Architect, affected domain architects, Tech Lead, 1-2 affected developers
3. Analyze the debt:
   - Root cause: Why did this architectural choice lead to debt?
   - Scope: How much of the system is affected?
   - Options: What are possible solutions?
4. Decision: Fix now vs. defer vs. accept
5. If fix: Create ADR (Architecture Decision Record) documenting the decision
6. If defer: Create ticket for future work with priority

---

## Resolution Criteria

- [ ] Architecture review meeting completed
- [ ] Root cause analysis documented in GitHub issue
- [ ] Decision made (fix, defer, accept)
- [ ] If fix: ADR created with implementation plan
- [ ] If defer: Ticket created with target date
- [ ] If accept: Risk documented with mitigation
- [ ] Tech Lead and Solution Architect aligned

---

## Escalation Path

- **Critical debt unfixed >2 weeks:** Escalate to CTO / VP Engineering
- **Systemic debt (many PRs failing):** Escalate to Product Manager for timeline/roadmap impact
- **Security debt:** Escalate to Security Architect + CTO

---

## Automation

- Trigger: Tech Lead labels PR as `debt:architectural`
- Action: Create GitHub issue + assign to Solution Architect
- Notification: Slack alert to architecture team
- Escalation: If issue open >2 weeks without Architecture response, auto-escalate
