# Security Requirement Reference

## Severity Definitions
| Severity | Criteria |
| -------- | -------- |
| Critical | Active exploit, data breach, or auth bypass possible |
| High | Significant vulnerability; exploitable under realistic conditions |
| Medium | Exploitable but requires specific conditions or access |
| Low | Defense in depth; low likelihood or impact |

## Source Categories
- **STRIDE** — Threat model findings (Spoofing, Tampering, Repudiation, Info Disclosure, DoS, Elevation)
- **CodeQL** — Static analysis findings
- **Dependabot** — Vulnerable dependency CVEs
- **OWASP** — Top 10 mapping (A01–A10)

## Key Resources
- [GitHub CodeQL – JS/TS queries](https://docs.github.com/en/code-security/code-scanning/managing-your-code-scanning-configuration/javascript-typescript-built-in-queries)
- [OWASP Top 10 (2023)](https://owasp.org/www-project-top-ten/)
- [GitHub Dependabot](https://docs.github.com/en/code-security/dependabot)
- [STRIDE methodology](https://learn.microsoft.com/en-us/azure/security/develop/threat-modeling-tool-threats)
- [pnpm audit](https://pnpm.io/cli/audit)
