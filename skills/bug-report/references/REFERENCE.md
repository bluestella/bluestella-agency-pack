# Bug Report Reference Guide

## Severity Matrix

| Severity        | Criteria                                                         | Example                                            |
| --------------- | ---------------------------------------------------------------- | -------------------------------------------------- |
| 🔴 Critical      | System down, data loss, security breach, core feature blocked    | Login broken for all users; SQL injection possible |
| 🟠 High          | Core feature broken, many users affected, no easy workaround     | File upload fails for files >50MB                  |
| 🟡 Medium        | Feature works but has issues; workaround exists; low-impact      | Error message has a typo; layout shift on mobile   |
| 🔵 Low           | Cosmetic or minor; no functional impact                          | Button is 1px misaligned; extra whitespace         |

## Bug Report Quality Checklist

Before filing a bug report, verify:
- [ ] Title names the component, condition, and symptom specifically
- [ ] Reproduction steps are numbered and exact — a stranger could follow them
- [ ] Expected and actual behavior are clearly distinct
- [ ] Environment is fully documented (version numbers included)
- [ ] At least one piece of evidence attached (screenshot, log, or video)
- [ ] Severity is accurate — not every bug is Critical
- [ ] One bug per report — don't bundle multiple issues
- [ ] Related tickets are linked

## Security Bugs

For vulnerabilities (XSS, SQLi, auth bypass, data exposure):
- Set severity Critical
- Add label `security` 
- Do **not** create a public GitHub issue — report privately to Security Architect
- Include CVSS score if known
- Reference the STRIDE category (Spoofing / Tampering / Information Disclosure / etc.)

## Intermittent Bugs

When a bug can't be reproduced 100% of the time:
- Document frequency: "Reproduces ~30% of the time under these conditions..."
- Document conditions that increase likelihood: concurrent users, specific data, timing
- Attach logs from multiple occurrences if available

## Bug Labels Convention

| Label           | Meaning                                     |
| --------------- | ------------------------------------------- |
| `bug:critical`  | Critical severity (P0)                      |
| `bug:high`      | High severity (P1)                          |
| `bug:medium`    | Medium severity (P2)                        |
| `bug:low`       | Low severity (P3)                           |
| `security`      | Security vulnerability — handle privately   |
| `regression`    | Was working before, broke in recent release |
| `needs-repro`   | Reporter can't reproduce; needs more info   |
| `duplicate`     | Already reported in another ticket          |

## External References

- [Mozilla: How to Write a Good Bug Report](https://bugzilla.mozilla.org/page.cgi?id=bug-writing-guidelines.html)
- [Google Testing Blog](https://testing.googleblog.com/)
- [Atlassian: Writing Good Bug Reports](https://www.atlassian.com/agile/software-development/bugs)
