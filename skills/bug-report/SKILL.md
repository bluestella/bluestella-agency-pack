---
name: bug-report
description: Generates standardized bug reports with clear reproduction steps, expected vs. actual behavior, severity classification, environment details, and attached evidence (screenshots, videos). Includes templates and best practices for effective bug communication. WHEN: Reporting bugs, creating QA tickets, communicating issues to developers, tracking quality issues, building bug databases.
---

# Bug Report Skill — Effective Bug Reporting

## Overview

A **Bug Report** documents a defect in the system, including how to reproduce it, what happened, what should have happened, and its impact. Good bug reports are clear, reproducible, and include enough context for developers to fix the issue quickly.

## When to Use This Skill

- **Scenario 1:** QA finds a crash when uploading files
- **Scenario 2:** Feature works on desktop but not mobile
- **Scenario 3:** Performance regression: page load time doubled
- **Scenario 4:** Data missing after user action
- **Scenario 5:** Error message doesn't match expected behavior

---

## Bug Report Template

### Standard Format

```markdown
# Bug: [Clear, descriptive title]

**Severity:** Critical | High | Medium | Low

**Status:** New | Acknowledged | In Progress | Fixed | Verified | Closed

**Reported By:** [Name]  
**Date:** [YYYY-MM-DD]  
**Related Ticket:** [Feature/Story link]

---

## Summary

[1-2 sentences: What's the issue? What does the user experience?]

**Example:** "When uploading a file larger than 50MB, the upload succeeds but the file is not stored in S3. User sees success message but file is missing from dashboard."

---

## Environment

- **Browser/App:** Chrome 126, Firefox 125, Safari 17, React Native iOS 17
- **OS:** macOS 14, Windows 11, iOS 17, Android 13
- **Device:** Desktop, Mobile (iPhone 14), Tablet (iPad Air)
- **Network:** WiFi, 4G LTE, 3G (if relevant)
- **App Version:** v1.2.3
- **Backend Version:** v2.1.0
- **Database:** PostgreSQL 16

---

## Steps to Reproduce

[Numbered list of exact steps to trigger the bug]

1. Navigate to `/upload` page
2. Click "Choose file" button
3. Select a file > 50MB (e.g., video.mp4, 120MB)
4. Click "Upload"
5. Wait for upload to complete
6. Observe: Success message appears, but file not in S3 bucket

---

## Expected Behavior

[What should happen according to requirements/acceptance criteria?]

- [ ] File is uploaded to S3 bucket
- [ ] Database record created with file metadata (name, size, URL)
- [ ] File appears in user's dashboard file list
- [ ] Success message shows: "File uploaded successfully"
- [ ] User can download the file from dashboard

---

## Actual Behavior

[What actually happened instead?]

- [ ] File upload appears to complete (success message shown)
- [ ] File does NOT appear in S3 bucket (verified with AWS console)
- [ ] Database record shows NULL for s3_url
- [ ] User's dashboard file list does NOT include uploaded file
- [ ] Error message does NOT appear (silent failure)

---

## Evidence

### Screenshots

[Attach 2-3 screenshots showing the bug]

1. Screenshot 1: Upload dialog with selected file
2. Screenshot 2: Success message after upload
3. Screenshot 3: Dashboard showing file list (file is missing)

### Video Recording

[Video walkthrough is especially valuable for timing-sensitive or hard-to-reproduce bugs]

- Link: [URL to video on Loom, Gyazo, or similar]

### Log Excerpts

**Browser Console (F12 → Console tab):**
```
[ERROR] Upload failed: Network error 500
[INFO] Retry attempt 1 of 3...
[ERROR] Still failing on retry
```

**Server Logs:**
```
2026-06-20 14:32:45 ERROR [upload-handler] S3PutObjectFailed: Access Denied (403)
2026-06-20 14:32:45 ERROR [upload-handler] No fallback, marking upload as complete
```

---

## Additional Context

[Any other information that helps understand the bug?]

- File types tested: `.mp4`, `.mov`, `.zip` (all > 50MB)
- File types NOT tested: `.pdf`, `.doc` (but assuming same issue)
- Frequency: Happens 100% of the time with large files, 0% with files < 50MB
- Related: See ADR-012 for large-file handling strategy
- Possible cause: S3 credentials may be expired or have insufficient permissions
- Impact: Users cannot upload training videos (critical for our use case)

---

## Severity Assessment

**Severity: HIGH**

- **Impact:** Feature is broken for large file uploads
- **Scope:** Affects ~20% of user base (those with 50MB+ files)
- **Workaround:** Upload file in chunks (not documented, trial-and-error)
- **Data Loss:** No; file metadata isn't corrupted, just not uploaded

| Severity | Criteria | Example |
| -------- | -------- | ------- |
| 🔴 Critical | Blocks entire feature, data loss, security breach | Login broken, data deleted, SQL injection |
| 🟠 High | Feature partially broken, workaround exists | File upload fails, but admin can upload via API |
| 🟡 Medium | Feature works but has issues, low impact | Typo in error message, layout shift |
| 🔵 Low | Cosmetic or minor issue | Button color not exact, extra whitespace |

---

## Acceptance Criteria for Fix

- [ ] File upload succeeds for files up to 1GB
- [ ] File stored correctly in S3 bucket
- [ ] Database record created with correct S3 URL
- [ ] File appears in user's dashboard within 5 seconds
- [ ] Clear success or error message shown to user
- [ ] Tested with: .mp4, .mov, .zip, .pdf files
- [ ] Tested on: Chrome, Firefox, Safari, mobile browsers

---

## Attached Files

- `bug-evidence-screenshot-1.png` — Upload dialog
- `bug-evidence-screenshot-2.png` — Success message
- `bug-evidence-screenshot-3.png` — Missing file in dashboard
- `bug-reproduction-video.mp4` — Full walkthrough (2 min)
- `server-logs-2026-06-20.txt` — Error logs from production

---

## For Developer

**Potential Root Causes:**
1. S3 credentials expired (check IAM token)
2. S3 bucket permissions insufficient (check CORS, bucket policy)
3. Upload timeout before S3 finishes (increase timeout)
4. Race condition: DB record created before S3 confirmation

**Investigation Steps:**
1. Check CloudWatch logs for S3 errors (403, 503, timeout)
2. Verify S3 bucket policy allows PutObject
3. Check upload handler timeout settings
4. Review recent deployment changes to upload service

**Suggested Fix:**
1. Implement retry logic for S3 failures
2. Add exponential backoff for transient errors (503, timeout)
3. Log all S3 errors to CloudWatch + Sentry
4. Return error to user if all retries fail (don't silently fail)

---

## Linked Issues

- Duplicates: [#1234] (if this bug has been reported before)
- Related: [#5678] Large file streaming feature
- Blocked By: [#9999] S3 credentials rotation task
- Blocks: [#1111] Release of v2.0 (this bug must be fixed first)

---

## Follow-Up Actions

After the fix is deployed:

- [ ] QA re-tests all reproduction steps (sign-off)
- [ ] Regression test added to prevent future regressions
- [ ] Root cause analysis completed (postmortem)
- [ ] Monitoring alerts added for S3 upload failures
- [ ] Documentation updated if applicable

---

## Comments / Discussion

[Space for team discussion]

**Developer Comment (2026-06-20):** "Found the issue! S3 IAM credentials expired 5 days ago. Rotating now."

**QA Comment (2026-06-21):** "Verified on staging with expired creds — confirmed the issue. Testing with rotated creds now."

**Tech Lead Comment (2026-06-21):** "Good catch. Add monitoring alert for credential expiration in future. Also, improve error messaging so users know what went wrong."

---

## Sign-Off

- [ ] QA Verified: __________ Date: ______
- [ ] Developer Fixed: __________ Date: ______
- [ ] QA Regression Tested: __________ Date: ______

```

---

## Bug Report Best Practices

1. **Title is specific:** Not "File upload broken" but "File upload > 50MB fails silently with S3 403 error"
2. **Reproduction is clear:** Someone should be able to reproduce the bug by following steps exactly
3. **Include environment details:** OS, browser, network all matter
4. **One bug per report:** Don't lump multiple issues together
5. **Include evidence:** Screenshots/video are invaluable (saves time and confusion)
6. **Expected vs. Actual:** Crystal clear what went wrong
7. **Severity is accurate:** Not every bug is Critical
8. **Potential causes included:** Developer can use your investigation
9. **Logs attached:** Server logs, browser console errors help
10. **Linked to tickets:** Reference related features, blocked work, etc.

---

## Severity Guide

### Critical (🔴)
- System is down or unusable
- Data loss or corruption
- Security breach
- Blocking entire feature
- Example: "Login page returns 500 error for all users"

### High (🟠)
- Core feature is broken
- Affects many users
- No easy workaround
- Example: "File upload fails for files > 50MB"

### Medium (🟡)
- Feature works but has issues
- Workaround exists or impacts few users
- Low business impact
- Example: "Error message typo: 'Pasword' instead of 'Password'"

### Low (🔵)
- Cosmetic or minor
- No impact on functionality
- Nice-to-have fix
- Example: "Logo is 1px too small on mobile"

---

## References

- [Mozilla Bug Report Template](https://bugzilla.mozilla.org/page.cgi?id=bug-writing-guidelines.html)
- [Google Testing Blog: Bug Reports](https://testing.googleblog.com/)
- [Atlassian: Writing Good Bug Reports](https://www.atlassian.com/)
