---
name: release-notes
description: Generates release notes summarizing new features, bug fixes, performance improvements, security updates, breaking changes, and migration guidance. Includes formatting templates and best practices for clear communication. WHEN: Publishing a release, documenting version updates, communicating changes to users, maintaining changelog.
---

# Release Notes Skill — Clear Release Communication

## Overview

**Release Notes** communicate what changed in a software release. They tell users what's new, what's fixed, what's different, and what they need to do to upgrade. This skill helps DevOps engineers and Product managers write clear, organized release notes.

## When to Use This Skill

- **Scenario 1:** Release v2.0 with new authentication (breaking change)
- **Scenario 2:** Release v1.5 with bug fixes and performance improvements
- **Scenario 3:** Security patch: release v1.4.3 with CVE fix
- **Scenario 4:** Beta release: v2.0-beta with experimental features
- **Scenario 5:** Deprecation notice: v1 will sunset in 3 months

---

## Release Notes Template

```markdown
# Release Notes — [Product Name] v[X.Y.Z]

**Release Date:** 2026-06-20  
**Release Type:** Major | Minor | Patch | Security | Beta  
**Status:** Stable | Release Candidate | Beta  

---

## Summary

[1-2 sentences: What's the headline? Why should users care?]

**Example:**
"Version 2.0 brings a complete redesign of the authentication system, OAuth 2.0 integration, and performance improvements. This is a major release with breaking changes — see Migration Guide below."

---

## What's New ✨

### New Features

#### Feature 1: [Feature Name]

**Description:** [What does it do? How does the user benefit?]

**Example:** "Users can now sign up with OAuth 2.0 (Google, GitHub, Microsoft) in addition to email/password. This reduces signup time by 50% and improves security with MFA."

**How to Use:**
```
1. Click "Sign Up with Google"
2. Authorize the app
3. Account created automatically
4. Redirected to dashboard
```

**Documentation:** [Link to help article]

---

#### Feature 2: [Feature Name]

[Repeat above]

---

### Improvements 🚀

#### Performance

- [ ] Database queries optimized: 50% faster user list loading
- [ ] API response time: 200ms p95 → 100ms p95
- [ ] Bundle size reduced by 20% (frontend)
- [ ] Cold start latency improved for serverless functions

#### UX / Design

- [ ] Redesigned dashboard layout for better clarity
- [ ] Improved mobile responsiveness
- [ ] Faster form submission with optimistic updates
- [ ] Better error messages (user-friendly, not technical)

#### Developer Experience

- [ ] Updated TypeScript types for better IDE support
- [ ] Added Swagger UI for API documentation
- [ ] Improved logging for debugging

---

### Bug Fixes 🐛

| Bug | Status | Impact |
| --- | ------ | ------ |
| File upload > 50MB fails silently | Fixed | Users can now upload large files |
| Duplicate email signup allowed in edge case | Fixed | Email uniqueness enforced |
| Dark mode toggle not persisting | Fixed | Theme preference now saved |
| Forgot password email sometimes doesn't send | Fixed | Email delivery reliability 100% |

**Full list:** See GitHub issues [#1234-#1245]

---

## Breaking Changes ⚠️

[Only for major versions. Be explicit about what breaks.]

### Authentication Changes

- **Old:** Session-based authentication (cookies)
- **New:** JWT tokens (OAuth 2.0)
- **Impact:** Frontend must update cookie handling to use Authorization headers
- **Migration:** See Migration Guide below

### API Changes

- [ ] `POST /api/auth/login` removed (use `/oauth/authorize` instead)
- [ ] `GET /users/:id` now requires org context: `GET /orgs/:org_id/users/:id`
- [ ] Response format changed: `user: { ... }` now `data: { user: { ... }, meta: { ... } }`

### Database Changes

- [ ] PostgreSQL 16 required (was 15)
- [ ] `users.session_id` column dropped
- [ ] `users.oauth_provider` column added

---

## Deprecations 🔔

[Announce what's going away and when]

### Deprecated Features

| Feature | Removed In | Status | Replacement |
| ------- | ---------- | ------ | ----------- |
| Session auth | v3.0 (2027-06-20) | Use OAuth 2.0 instead | `/oauth/authorize` |
| Basic auth for APIs | v2.5 (2026-12-20) | Use API keys or OAuth | `X-API-Key` header |
| v1 API endpoints | v2.0 (2026-06-20) | Use v2 API | Update base URL to `/v2` |

**Action Required:** Upgrade before deprecation date to avoid breakage.

---

## Migration Guide 📋

[Step-by-step instructions for users to upgrade]

### For Frontend Teams

**Before:** Using session cookies for auth
```javascript
// Old
localStorage.setItem('session_id', response.sessionId);
fetch('/api/users', {
  credentials: 'include' // Send cookies
});
```

**After:** Using JWT tokens
```javascript
// New
localStorage.setItem('token', response.token);
fetch('/api/users', {
  headers: {
    'Authorization': `Bearer ${token}`
  }
});
```

**Steps:**
1. [ ] Update login endpoint: POST `/oauth/authorize` → returns JWT
2. [ ] Update all API calls to use `Authorization: Bearer {token}`
3. [ ] Remove session cookie logic
4. [ ] Test login flow
5. [ ] Deploy to staging
6. [ ] Test with v2 backend
7. [ ] Deploy to production

**Time Required:** ~2 hours

---

### For Backend Teams

**Database Migration:**
```bash
# 1. Backup current database
pg_dump -U postgres app_db > backup-v1.sql

# 2. Apply migrations
psql -U postgres app_db < migrations/v2.0-migration.sql

# 3. Verify
SELECT COUNT(*) FROM users; -- Should match old table
```

**API Changes:**
- Update response format in all endpoints
- Add JWT validation middleware
- Remove session middleware
- Update tests for new auth

**Testing:**
```bash
pnpm test:integration  # All tests must pass
pnpm test:api         # API contract tests
```

**Deployment:**
1. [ ] Deploy v2.0-beta to staging
2. [ ] Verify frontend compatibility
3. [ ] Load test (1,000 concurrent users)
4. [ ] Run security audit
5. [ ] Get sign-off from tech lead
6. [ ] Deploy to production (blue-green deployment)
7. [ ] Monitor for 24 hours

---

## Security Updates 🔒

[Explicitly mention security fixes]

### CVEs Fixed

| CVE | Severity | Component | Fix |
| --- | -------- | --------- | --- |
| CVE-2026-1234 | High | Dependency: jwt-decode v8.0.2 | Updated to v9.0.0 |
| CVE-2026-5678 | Medium | Custom code: SQLi in search | Input validation added |

### Security Improvements

- [ ] Password hashing upgraded: bcrypt → argon2 (better security)
- [ ] Session timeout reduced: 30 days → 7 days (better security posture)
- [ ] MFA now mandatory for admin accounts
- [ ] API rate limiting added (prevent brute force)
- [ ] Audit logging enabled (track user actions)

**No user action required.** Fixes deployed automatically.

---

## Known Issues / Limitations 🚧

[Be honest about what's not perfect]

| Issue | Workaround | Fix Timeline |
| ----- | ---------- | ------------ |
| OAuth signup slow on first attempt | Retry, or use email signup | v2.1 (optimizing OAuth flow) |
| Dark mode doesn't apply to modals | Refresh page | v2.2 (known design issue) |
| File export in CSV format only | Use API directly | v2.1 (JSON export planned) |

---

## Deprecation Timeline

[When features will be removed]

```
v2.0 (2026-06-20): Session auth deprecated, OAuth 2.0 available
                    ⬇️ 6-month notice period
v2.5 (2026-12-20): Basic auth for APIs deprecated
                    ⬇️ 6-month notice period
v3.0 (2027-06-20): Session auth and Basic auth removed
```

---

## Performance Metrics

[Show improvements]

| Metric | Before | After | Improvement |
| ------ | ------ | ----- | ----------- |
| Database query (user list) | 400ms | 200ms | 50% faster |
| API response p95 | 250ms | 100ms | 60% faster |
| Page load time (Lighthouse LCP) | 3.2s | 2.4s | 25% faster |
| Bundle size (minified + gzipped) | 450KB | 360KB | 20% smaller |
| Cold start (serverless function) | 250ms | 80ms | 68% faster |

---

## Compatibility Matrix

[Who should upgrade?]

| Version | Node.js | PostgreSQL | Browsers |
| ------- | ------- | ---------- | -------- |
| v1.x | 18+ | 14, 15 | All modern browsers |
| v2.0 | 20+ | 16+ | Chrome 100+, Firefox 100+, Safari 15+, Edge 100+ |
| v2.0 (LTS) | 18+ | 15, 16 | Same as v1.x (backport support) |

**Recommendation:** Upgrade to v2.0 for latest features. Stay on v1.x if you need Node 18 support (LTS patch provided until 2027-06-20).

---

## Downloads & Installation

### Docker

```bash
docker pull acme/api:2.0
docker run -e DATABASE_URL=... acme/api:2.0
```

### NPM / Node.js

```bash
npm install acme-sdk@2.0.0
npm update  # Update from v1 to v2
```

### Direct Download

- [acme-2.0.0.tar.gz](https://releases.acme.com/v2.0.0) (SHA256: abc123...)
- [Release Checksum](https://releases.acme.com/v2.0.0.sha256)

---

## Support & Feedback

- **Documentation:** https://docs.acme.com/v2.0
- **GitHub Issues:** https://github.com/acme/acme/issues
- **Slack Community:** https://acme-community.slack.com
- **Email Support:** support@acme.com

---

## Contributors

Thanks to the contributors who made this release possible:

- Alice Chen (@alice-chen)
- Bob Smith (@bob-smith)
- Carol Davis (@carol-davis)
- And 42 other contributors

---

## Changelog

See [full changelog](./CHANGELOG.md) for all changes in v2.0.

---

## Author Notes

[Optional: Personal note from release manager/CEO]

"This release represents 6 months of work from our team. We're excited about OAuth 2.0 integration, performance improvements, and a stronger security foundation. Upgrade soon — we'll be sunsetting v1 in 6 months. Thank you for using Acme!"

— Jane Doe, Product Manager

---

## Sign-Off

- [ ] Product Manager: __________ Date: ______
- [ ] Tech Lead: __________ Date: ______
- [ ] DevOps / Release Manager: __________ Date: ______
```

---

## Release Notes Best Practices

1. **Be scannable:** Use sections, bullets, clear headings
2. **Write for users:** Not technical jargon; explain the value
3. **Be honest:** Include known issues, not just features
4. **Include migration guide:** Especially for breaking changes
5. **Link to docs:** Point users to detailed help articles
6. **Include timelines:** When will deprecated features be removed?
7. **Highlight security:** Security fixes deserve explicit callout
8. **Show before/after:** Performance improvements with numbers
9. **Add examples:** Code snippets for API changes
10. **Plan ahead:** Announce breaking changes 3+ releases in advance

---

## Release Types

| Type | Bump | When | Example |
| ---- | ---- | ---- | ------- |
| Major | X.0.0 | Breaking changes | v1.0.0 → v2.0.0 (OAuth) |
| Minor | 1.X.0 | New features, backward compatible | v2.0.0 → v2.1.0 (new export format) |
| Patch | 1.0.X | Bug fixes only | v2.1.0 → v2.1.1 (security hotfix) |
| Security | 1.0.X | Security-only patch | v2.1.1 → v2.1.2 (CVE fix) |
| Beta | 2.0-beta | Pre-release testing | v2.0-beta.1 (feature preview) |

---

## References

- [Semantic Versioning](https://semver.org/)
- [Keep a Changelog](https://keepachangelog.com/)
- [Release Notes Best Practices](https://wiki.archlinux.org/title/Arch_Linux_release_notes)
