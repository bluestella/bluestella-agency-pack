---
title: Hook — STRIDE Finding to Requirement Change
description: Trigger for when Security Engineer finds STRIDE threat that requires new business requirement
---

# Hook: Security Finding → Business Analyst (Requirement Change)

## Trigger Condition

**Source Agent:** Security Engineer  
**Destination Agent:** Business Analyst  
**Event:** STRIDE threat modeling identifies security threat that requires new business requirement or epic

**Detection:**
- Security threat cannot be fixed with code changes (requires architecture/process change)
- Threat requires new feature: e.g., MFA, audit logging, encryption key rotation
- Compliance requirement discovered: GDPR, SOC 2, PCI-DSS compliance gap
- Policy requirement: e.g., "All user deletions must be logged"

**Severity:**
- 🔴 Critical: Compliance violation, data breach risk
- 🟠 High: Security risk, should be fixed this quarter
- 🟡 Medium: Security improvement, defer to next quarter
- 🔵 Low: Security hardening, nice-to-have

---

## Trigger Payload

```json
{
  "event": "security_requirement_identified",
  "severity": "Critical|High|Medium|Low",
  "threat_category": "STRIDE category",
  "description": "MFA not required for admin accounts",
  "business_impact": "Admin account takeover leads to data exposure + compliance violation",
  "requirement": "MFA required for all admin users within 90 days",
  "epic_proposal": {
    "title": "Implement MFA for Admin Accounts",
    "business_outcome": "Prevent unauthorized admin access",
    "success_metrics": ["100% of admins using MFA", "0 admin account compromises"]
  },
  "assigned_to": "Business Analyst",
  "created_at": "ISO 8601 timestamp"
}
```

---

## Required Action

1. **Security Engineer** creates GitHub issue labeled `security:requirement-change` + severity
2. Issue includes:
   - STRIDE threat description
   - Business impact
   - Proposed requirement
   - Compliance justification (if applicable)
3. **Business Analyst** reviews issue and decides:
   - Is this a new Epic?
   - Add to existing Epic?
   - Defer to future roadmap?
4. **Business Analyst** creates corresponding Epic or User Story in backlog
5. **Business Analyst** links back to security issue

---

## Epic Creation (Example)

```markdown
# Epic: Implement MFA for Admin Accounts

**Business Outcome:** Prevent unauthorized admin access, achieve SOC 2 compliance

**Success Metrics:**
- 100% of admin accounts have MFA enabled
- 0 admin account compromises (baseline: currently 2 per year)
- Login flow uses TOTP or hardware keys

**User Stories:**
1. Admin can enable MFA in account settings
2. Admin can disable MFA (with recovery codes)
3. Admin required to use MFA on login
4. Audit log tracks MFA events
5. Support can reset MFA for locked-out admins

**Definition of Done:**
- [ ] All user stories complete
- [ ] Security audit: 0 MFA bypass vulnerabilities
- [ ] 100% of admins have MFA enabled (compliance requirement)
- [ ] Documentation updated
- [ ] Support team trained
```

---

## Resolution Criteria

- [ ] Security Engineer and Business Analyst agree on requirement
- [ ] Epic or User Story created in backlog
- [ ] Priority set (P0-P3)
- [ ] Target date assigned
- [ ] Linked to security issue
- [ ] Security team added to Definition of Done verification

---

## Escalation Path

- **Critical compliance gap unfixed >1 week:** Escalate to Product Manager + Legal
- **Regulatory deadline approaching:** Escalate to CEO + Legal
- **Multiple teams blocked by missing security requirement:** Escalate to Product Manager for priority

---

## Automation

- Trigger: Security issue labeled `security:requirement-change` + severity
- Action: Create GitHub epic template + tag Business Analyst
- Notification: Slack alert to Business Analyst + Security team
- Reminder: Weekly check-in until epic created and prioritized
