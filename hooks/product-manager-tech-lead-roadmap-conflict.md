---
title: Hook — Product Manager to Tech Lead (Roadmap Conflict)
description: Trigger for when Product Manager's roadmap conflicts with Tech Lead's technical priorities
---

# Hook: Product Manager ↔ Tech Lead (Roadmap Alignment)

## Trigger Condition

**Source Agent:** Tech Lead or Product Manager  
**Destination Agent:** Product Manager or Tech Lead  
**Event:** Roadmap goals conflict with technical constraints or technical debt

**Conflict Types:**
- Feature request requires architectural changes not on roadmap
- Technical debt is blocking new feature development
- Scaling issues prevent feature deployment
- Security issues need to be fixed before new features
- Performance regression from recent changes needs investigation

**Severity:**
- 🔴 Critical: Technical blocker prevents any feature development
- 🟠 High: Feature delayed, needs timeline adjustment
- 🟡 Medium: Minor technical trade-off, needs decision
- 🔵 Low: Nice-to-have technical improvement

---

## Trigger Payload

```json
{
  "event": "roadmap_technical_conflict",
  "severity": "High",
  "source": "tech_lead",
  "conflicting_items": {
    "feature": "Multi-language support (Q3 roadmap)",
    "technical_blocker": "Database schema doesn't support language-specific content"
  },
  "description": "Current schema uses single 'name' column. Multi-language requires refactoring to support locale-specific values (name_en, name_fr, name_de, etc. or JSONB). Estimated 2 weeks of development.",
  "trade_offs": [
    "Delay feature by 2 weeks for schema refactor",
    "Use workaround approach (less clean, more maintenance)",
    "Defer multi-language support to Q4"
  ],
  "tech_lead_recommendation": "Spend 2 weeks on schema refactor — worth the investment for future maintainability",
  "assigned_to": "Product Manager",
  "created_at": "ISO 8601 timestamp"
}
```

---

## Required Action

1. **Tech Lead** creates issue labeled `planning:roadmap-conflict`

2. **Tech Lead** schedules alignment meeting with Product Manager

3. **Attendees:**
   - Tech Lead
   - Product Manager
   - Solution Architect (for technical input)
   - One affected developer

4. **Meeting Agenda:**
   - Tech: Explain technical blocker
   - PM: Explain business impact of feature
   - Together: Explore trade-offs
   - Decide: Adjust roadmap or timeline

---

## Trade-Off Analysis

### Example: Multi-Language Support

**Option 1: Schema Refactor (Recommended)**
- **Effort:** 2 weeks
- **Benefit:** Clean, scalable, maintainable
- **Timeline:** Feature delayed to late Q3
- **Technical debt:** Reduced (long-term win)
- **Trade-off:** Schedule slip, but better quality

**Option 2: Workaround (Quick)**
- **Effort:** 1 week (add language parameter, no schema change)
- **Benefit:** Feature ships on schedule
- **Downside:** Technical debt accumulates, hard to scale to many languages
- **Trade-off:** Ship fast, pay debt later

**Option 3: Defer Feature**
- **Effort:** 0 weeks (skip Q3)
- **Benefit:** No technical work, roadmap stays clean
- **Downside:** Feature misses customer deadline
- **Trade-off:** Business impact vs. technical investment

---

## Resolution Criteria

- [ ] Tech Lead and Product Manager align on trade-offs
- [ ] Decision documented (Option 1, 2, or 3)
- [ ] Roadmap updated to reflect decision
- [ ] Timeline adjusted if needed
- [ ] Stakeholders informed of change

---

## Decision Framework

**Tech Lead + Product Manager decide using:**

| Factor | Weight | Considerations |
| ------ | ------ | --------------- |
| Customer impact | 40% | Will customers accept delay? Is feature business-critical? |
| Technical impact | 30% | How much technical debt? How much scaling impact? |
| Timeline | 20% | How urgent is the feature? Can we slip Q3 schedule? |
| Resource cost | 10% | Can we hire contractors? Use external library? |

**Decision Rule:** If customer impact + timeline > 60%, choose Option 2 (ship with workaround). Otherwise, choose Option 1 (invest in tech).

---

## Escalation Path

- **Can't reach agreement after 2 hours discussion:** Escalate to VP Product + VP Engineering
- **Customer deadline at risk:** Escalate to CEO for decision
- **Recurring conflicts:** May indicate process breakdown (planning doesn't account for tech reality)

---

## Prevention

### Quarterly Planning

**Before committing to roadmap:**

1. Tech Lead reviews proposed features
2. Tech Lead flags technical constraints early
3. PM and Tech Lead estimate effort including technical work
4. Roadmap includes both feature work AND technical debt work (20/80 split: 20% technical, 80% features)

### Rule of 80/20

- **80% of roadmap:** New features and enhancements
- **20% of roadmap:** Technical debt, infrastructure, security, performance
- **Reason:** Technical work maintains quality, prevents velocity decline

---

## Automation

- Trigger: Tech Lead flags roadmap item as technically blocked
- Action: Create alignment meeting, notify PM
- Notification: Slack alert + calendar invite
- Escalation: If unresolved >3 days, escalate to VP Engineering
