---
trigger: stride-threat-finding
from: Security Engineer
to: Developer
severity: critical
---

# Hook: Security Findings → Developer/Architect

## Trigger Condition

**Source Agent:** Security Engineer  
**Destination Agents:** Developer (for code-level fixes) or Security Architect (for design changes)  
**Event:** Security audit or STRIDE threat model identifies vulnerabilities

**Detection:**

- CodeQL SAST scan finds a security issue
- Dependency audit (`pnpm audit`) detects a CVE
- Manual security review finds a threat
- STRIDE threat model identifies unmitigated threats

**Threat Categories (STRIDE):**

- 🔴 **Critical:** Unauthenticated access, data exfiltration, RCE, SQLi
- 🟠 **High:** Authenticated privilege escalation, malware vectors, DoS
- 🟡 **Medium:** Information disclosure, weak encryption, input validation
- 🔵 **Low:** Missing logging, deprecated algorithms, non-security code quality

---

## Trigger Payload

```json
{
  "event": "security_finding",
  "severity": "Critical|High|Medium|Low",
  "threat_category": "Spoofing|Tampering|Repudiation|InformationDisclosure|DenialOfService|ElevationOfPrivilege",
  "component": "ComponentName",
  "description": "Threat description and impact",
  "affected_code": "File path(s) and line numbers",
  "cvss_score": "7.5",
  "mitigation": "Recommended fix or design change",
  "evidence": {
    "tool": "CodeQL|pnpm audit|manual review",
    "output": "Raw scan output or details"
  },
  "destination": "developer|architect",
  "assigned_to": "Name",
  "created_at": "ISO 8601 timestamp"
}
```

---

## Required Action

### If Destination = Developer (code-level fix)

1. Security Engineer creates a GitHub issue labeled `security:critical`, `security:high`, etc.
2. Issue includes:
   - STRIDE threat category
   - Affected code with line numbers
   - Reproduction proof or exploit scenario
   - Recommended mitigation
   - Links to security best practice docs
3. Issue is assigned to the responsible engineer
4. Issue is added to the current sprint as P0/P1 work

### If Destination = Architect (design change)

1. Security Engineer escalates to Security Architect
2. Security Architect determines if threat requires:
   - New architecture pattern (e.g., add API gateway, mTLS)
   - Infrastructure change (e.g., WAF, network segmentation)
   - Requirement change (e.g., MFA mandate)
3. If requirement change needed:
   - Security Architect creates a new epic in the requirements backlog
   - Business Analyst writes corresponding User Stories
   - Flow loops back to Business Analyst

---

## Resolution Criteria

- [ ] Security Engineer reviews the fix/change
- [ ] Code passes CodeQL SAST scan (0 findings at issue severity level)
- [ ] Dependency audit passes (`pnpm audit --audit-level=[level]`)
- [ ] Threat is mitigated (verification details in issue)
- [ ] No regression in other security controls
- [ ] Unit/integration tests added for the fix
- [ ] Tech Lead reviews and approves

---

## Escalation Path

- **Critical threat unfixed >24 hours:** Escalate to Tech Lead → Product Manager
- **Design-level threat:** Escalate to Security Architect for architecture review
- **Compliance violation:** Escalate to Product Manager + Legal/Compliance team

---

## Automation

- Trigger: CodeQL / Dependabot / manual security review
- Action: Create GitHub issue + assign + label
- Notification: Slack alert to security team + developer/architect
- Dashboard: Security scorecard updated with threat count
- Timeout: Auto-escalate if unacknowledged for 24 hours
