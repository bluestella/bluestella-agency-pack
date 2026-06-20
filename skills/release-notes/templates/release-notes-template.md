# Release Notes — [Product Name] v[X.Y.Z]

**Release Date:** [YYYY-MM-DD]
**Release Type:** Major | Minor | Patch | Security | Beta
**Status:** Stable | Release Candidate | Beta

---

## Summary

[1–2 sentences: What's the headline? Why should users care?]

---

## ⚠️ Breaking Changes _(Major releases only — move this section up if breaking changes exist)_

> **Action required before upgrading.**

### [Breaking Change Title]

**What changed:** [Describe exactly what was removed or changed]

**Impact:** [Who is affected and how]

**Migration:** [What users must do — link to Migration Guide section below]

---

## What's New ✨

### [Feature Name]

**Description:** [What it does and why it matters]

**How to use:**
1. [Step 1]
2. [Step 2]

**Example:**
```
[Code or config example if applicable]
```

---

## Bug Fixes 🐛

### [Component Name]

- **[Bug title]** — [What was broken, what it does now] _(#ticket-id)_
- **[Bug title]** — [What was broken, what it does now] _(#ticket-id)_

---

## Security Updates 🔒 _(Security patches — list this first for CVE releases)_

### [CVE-YYYY-NNNN or Security Fix Title]

- **Severity:** Critical | High | Medium | Low
- **Affected versions:** [vX.Y.Z – vA.B.C]
- **Fixed in:** v[X.Y.Z]
- **Description:** [What vulnerability was fixed]
- **Recommended action:** Upgrade immediately to v[X.Y.Z]

---

## Performance Improvements ⚡

- **[Component]:** [What improved, by how much — e.g., "Query time reduced by 40%"]

---

## Deprecations 🕐

| Deprecated               | Removed in | Use instead              |
| ------------------------ | ---------- | ------------------------ |
| `[old feature/API]`      | v[X+1].0   | `[new feature/API]`      |

---

## Migration Guide _(Breaking changes only)_

### Step 1: [First migration step]

[Instructions]

### Step 2: [Second migration step]

[Instructions]

### Rollback

If the upgrade causes issues:
1. [Rollback step 1]
2. [Rollback step 2]

---

## Known Issues

- **[Issue title]:** [Description and workaround if available] — Fix expected in v[X.Y.Z+1]

---

## Upgrade Checklist

**Before upgrading:**
- [ ] Read Breaking Changes section
- [ ] Back up configuration / data
- [ ] Test upgrade in staging environment

**After upgrading:**
- [ ] Run smoke tests
- [ ] Verify key user flows work correctly
- [ ] Monitor error rates for 30 minutes post-deploy

---

## Full Changelog

See [CHANGELOG.md](./CHANGELOG.md) for a complete list of all changes.

---

## Support

Questions or issues? [Open an issue](https://github.com/org/repo/issues) or contact support@example.com.
