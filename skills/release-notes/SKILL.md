---
name: release-notes
description: >
  Generates release notes summarizing new features, bug fixes, performance improvements,
  security updates, breaking changes, and migration guidance. Use when publishing a release,
  documenting version updates, communicating changes to users, or maintaining a changelog.
instructions: []
agents:
  - devops-engineer
  - tech-lead
  - product-manager
triggers:
  - deployment-failure
metadata:
  author: bluestella
  version: "1.0"
---

# Release Notes

## Overview

This skill produces clear, user-facing release notes for any software release — from patch fixes to major breaking changes. Good release notes tell users what changed, why it matters, and what they need to do. Output follows semantic versioning conventions and covers the full release communication lifecycle.

## Steps

1. **Determine release type.** Major (breaking changes) / Minor (new features, backward-compatible) / Patch (bug fixes) / Security (CVE/vulnerability fix). Release type drives the tone and urgency.
2. **Write the headline summary.** 1–2 sentences: the most important thing users should know about this release.
3. **Document new features.** For each: feature name, what it does, user benefit, how to use it (brief steps or example).
4. **List bug fixes.** Group by component. Each fix: what was broken, what it does now. Reference bug ticket IDs where available.
5. **Call out breaking changes.** Prominent section, not buried. State exactly what breaks and provide a migration path.
6. **Write the migration guide** (for major/breaking releases). Step-by-step upgrade instructions. Include rollback steps.
7. **Note deprecations.** What's deprecated, when it will be removed, what to use instead.
8. **Add security disclosures** (for security patches). CVE ID if applicable, affected versions, fix version, recommended action (upgrade immediately).

## Output Format

A markdown release notes document:

```
# Release Notes — [Product] v[X.Y.Z]
Release Date / Release Type / Status
## Summary              — headline in 1–2 sentences
## What's New           — features with usage guidance
## Bug Fixes            — grouped by component
## Breaking Changes     — prominent, with migration path
## Migration Guide      — step-by-step upgrade instructions
## Deprecations         — what's going away and when
## Security Updates     — CVE disclosures
## Known Issues         — outstanding problems in this release
## Upgrade Checklist    — pre/post-upgrade steps
```

Template: [`templates/release-notes-template.md`](templates/release-notes-template.md)

## Examples

**Input:** "v2.0 — OAuth 2.0 replaces session auth. Breaking change. Old sessions invalidated."

**Output:** Major release notes with prominent "Breaking Changes" section (old auth headers no longer accepted), Migration Guide (step-by-step: install new SDK, update headers, test in staging), and Upgrade Checklist.

**Input:** "v1.4.3 — Security patch for CVE-2026-1234 in dependency X."

**Output:** Patch release notes with "Security Updates" section first, CVE-2026-1234 details, affected versions (v1.0.0–v1.4.2), immediate upgrade recommendation.

## Edge Cases

- No breaking changes in a major version bump: still flag it as major; explain why (new architecture, future deprecations planned).
- Security vulnerabilities: security section goes first, above "What's New". Recommend immediate upgrade for Critical/High CVEs.
- Beta/RC releases: add prominent "NOT FOR PRODUCTION USE" banner. Document known issues explicitly.
- Rollback needed: include explicit rollback steps for every major/breaking release.

## References

See [`references/REFERENCE.md`](references/REFERENCE.md) for semantic versioning rules, changelog conventions, and deprecation policy guidance.
