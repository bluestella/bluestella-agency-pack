---
trigger: stride-threat-found
from: Security Engineer
to: Business Analyst | Developer | Architecture Team
severity: critical | high | medium | low
---

# Security Finding Feedback Loop

## Trigger Condition

The Security Engineer identifies a threat during STRIDE threat modelling (Spoofing, Tampering, Repudiation, Information Disclosure, Denial of Service, Elevation of Privilege) against a component from the Solution Architect's design. The trigger fires once per threat finding and once per unresolved CodeQL or dependency CVE finding.

## Trigger Payload

The Security Engineer must provide the following when firing this hook:

- **Artifact:** A new GitHub Issue with label `security:threat` and the relevant STRIDE category tag (`stride:spoofing` | `stride:tampering` | `stride:repudiation` | `stride:info-disclosure` | `stride:dos` | `stride:elevation`)
- **Severity:** Critical | High | Medium | Low
- **Affected component:** The architectural component, service, or data flow where the threat applies
- **Threat description:** What the threat is and what it enables an attacker to do
- **STRIDE category:** One or more of S, T, R, I, D, E
- **Destination routing:**
  - Design-level threat → route to Security Architect and Solution Architect
  - Implementation-level threat → route to the responsible Developer
  - Requirement gap → route to Business Analyst to raise a new requirement ticket

## Destination Action

### If routed to Architecture Team (design-level threat)

1. Security Architect reviews the threat against the existing security design.
2. Security Architect proposes a control or architectural change to mitigate the threat.
3. Solution Architect updates the affected C4 diagram or API contract to incorporate the control.
4. Architecture Team produces updated artifacts and hands back to the Security Engineer for re-validation.

### If routed to Developer (implementation-level threat)

1. Developer reads the GitHub Issue and the STRIDE finding.
2. Developer implements the required security control (e.g. input sanitisation, rate limiting, RBAC check).
3. Developer writes a unit test that validates the control is in place.
4. Developer opens a PR; the PR body must reference the security GitHub Issue.
5. Tech Lead performs a security-focused code review before merging.

### If routed to Business Analyst (requirement gap)

1. Business Analyst creates a new requirement ticket (User Story or Task) in the requirements checklist.
2. The new ticket is added to the relevant Epic with status TODO.
3. The ticket is assigned to the responsible agent for implementation.
4. The Security Engineer monitors the ticket until it reaches Done status.

## Resolution Criteria

This hook is resolved when all of the following are true:

- [ ] The GitHub Issue for the threat finding is closed with label `security:resolved`.
- [ ] The Security Engineer has re-run the relevant STRIDE check and confirmed the threat is mitigated.
- [ ] If a code change was required: the fix PR is merged and CI is green.
- [ ] If an architectural change was required: updated C4 diagram or contract is committed.
- [ ] If a new requirement was raised: the requirement ticket status is Done.

## Escalation

- **Critical threats:** Block deployment immediately. Escalate to Tech Lead and notify stakeholders within 4 hours.
- **High threats:** Block the affected feature from shipping. Resolve within the current sprint.
- **Medium threats:** Address within the current sprint; block production deployment if unresolved.
- **Low threats:** Track in the security register; address in the next sprint.
