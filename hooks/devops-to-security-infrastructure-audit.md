---
trigger: infrastructure-security-misconfiguration
from: DevOps / Platform Engineer
to: Security Architect
severity: high
---

# Hook: DevOps → Security Architect (Infrastructure Audit)

## Trigger Condition

**Source Agent:** DevOps / Platform Engineer  
**Destination Agent:** Security Architect  
**Event:** DevOps discovers security misconfiguration or risk in infrastructure

**Detection:**

- S3 bucket publicly accessible (world-readable)
- Security group allows unrestricted access (0.0.0.0/0)
- Secrets stored in plain text in config files
- SSL/TLS certificate expired or misconfigured
- Database backup unencrypted or publicly accessible
- IAM permissions too permissive (principle of least privilege violated)
- Logging disabled (CloudTrail, VPC Flow Logs)
- MFA not enforced for production access

**Severity:**

- 🔴 Critical: Data breach or compliance violation risk
- 🟠 High: Security risk, should fix within 24 hours
- 🟡 Medium: Security improvement, fix within 1 week
- 🔵 Low: Security hardening, fix within 1 month

---

## Trigger Payload

```json
{
  "event": "infrastructure_security_issue",
  "severity": "Critical",
  "resource": "s3://app-backups-prod",
  "issue": "S3 bucket publicly readable (BlockPublicAccess = false)",
  "risk": "Production database backups exposed to internet (contains customer PII)",
  "compliance_impact": "GDPR violation, SOC 2 Type II failed control",
  "remediation": "Enable S3 BlockPublicAccess, encrypt bucket contents with KMS",
  "effort": "30 minutes",
  "assigned_to": "Security Architect",
  "created_at": "ISO 8601 timestamp"
}
```

---

## Required Action

1. **DevOps** creates GitHub issue labeled `security:infrastructure` + severity

2. **DevOps** documents the issue:
   - What resource is affected?
   - What is the security risk?
   - How to reproduce?
   - Recommended fix?

3. **DevOps** posts to #security Slack channel:

   ```
   🚨 CRITICAL: S3 backup bucket publicly accessible
   - Bucket: app-backups-prod
   - Risk: Production database backups exposed (customer PII)
   - Compliance: GDPR violation
   - Fix: Enable BlockPublicAccess + KMS encryption
   - ETA: 1 hour

   GitHub: #5678
   ```

4. **Security Architect** reviews and categorizes:
   - Is this an immediate threat?
   - Are customers affected?
   - What's the required fix timeline?

5. **DevOps** + **Security Architect** collaborate to fix:
   - Agree on remediation steps
   - Implement fix
   - Verify remediation
   - Update infrastructure-as-code

---

## Common Findings & Fixes

| Finding                         | Fix                                                | Effort  |
| ------------------------------- | -------------------------------------------------- | ------- |
| S3 bucket publicly readable     | Enable `BlockPublicAccess`, restrict bucket policy | 15 min  |
| Security group allows 0.0.0.0/0 | Restrict to specific IP ranges / VPN               | 10 min  |
| Secrets in .env file            | Move to AWS Secrets Manager                        | 1 hour  |
| Certificate expired             | Renew certificate, verify renewal automation       | 30 min  |
| DB backup unencrypted           | Enable RDS encryption, re-encrypt old backups      | 2 hours |
| IAM policy too permissive       | Audit and apply least-privilege principle          | 1 hour  |
| CloudTrail disabled             | Enable CloudTrail, set up log retention            | 30 min  |
| MFA not required for prod       | Add IAM policy to mandate MFA                      | 1 hour  |

---

## Resolution Criteria

- [ ] Security risk identified and categorized
- [ ] Remediation plan agreed
- [ ] Fix implemented
- [ ] Fix verified (manual test + monitoring)
- [ ] Infrastructure-as-code updated
- [ ] Preventive monitoring alert added
- [ ] Security Architect and DevOps sign-off

---

## Prevention

### Infrastructure Scanning

- [ ] Weekly: Run AWS Security Hub scan
- [ ] Daily: Check for public S3 buckets, open security groups
- [ ] Continuous: Check for unencrypted storage, disabled logging
- [ ] Monthly: IAM policy audit for least-privilege compliance

### Code Review

Before deploying infrastructure changes (Terraform, CloudFormation):

- [ ] Does it follow least-privilege principle?
- [ ] Are secrets used (not hardcoded)?
- [ ] Is encryption enabled where required?
- [ ] Is logging enabled for compliance?
- [ ] Is MFA enforced for sensitive resources?

---

## Escalation Path

- **Critical security issue unfixed >1 hour:** Escalate to CTO + CISO
- **Compliance violation (GDPR, SOC 2):** Escalate to CEO + Legal
- **Multiple infrastructure issues:** Escalate to VP Engineering for root cause (process breakdown)

---

## Automation

- Trigger: AWS Security Hub detects finding, or DevOps runs audit
- Action: Create GitHub issue + assign to Security Architect
- Notification: Slack alert to security team + DevOps team
- Scan: Weekly automated infrastructure security scan
- Dashboard: Track open security findings by severity
- SLA: Critical findings must be resolved within 1 hour
