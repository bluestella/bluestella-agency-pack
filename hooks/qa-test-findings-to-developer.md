---
title: Hook — QA Test Findings to Developer
description: Trigger for when Automation Testing Engineer finds code bugs during visual or API testing
---

# Hook: QA Test Findings → Developer

## Trigger Condition

**Source Agent:** Automation Testing Engineer  
**Destination Agent:** Frontend Engineer or Backend Engineer  
**Event:** Test execution completes with failures

**Detection:**

- Visual regression test fails (`Playwright toHaveScreenshot`)
- API contract test fails (request/response mismatch)
- Unit or integration test fails
- Manual QA finds a reproducible bug

**Severity Levels:**

- 🔴 Critical (P0): Feature broken, blocks user flow
- 🟠 High (P1): Feature partially broken, impacts user experience
- 🟡 Medium (P2): Feature works but with issues, workaround exists
- 🔵 Low (P3): Minor issue, cosmetic or edge case

---

## Trigger Payload

```json
{
  "event": "qa_test_failure",
  "severity": "P0|P1|P2|P3",
  "test_type": "visual|api|unit|integration|manual",
  "component": "ComponentName",
  "failure_description": "Expected X but got Y",
  "reproduction_steps": ["Step 1", "Step 2"],
  "evidence": {
    "screenshot": "url_to_screenshot.png",
    "test_output": "error message from test runner",
    "video": "optional_video_link"
  },
  "assigned_to": "Developer Name",
  "created_at": "ISO 8601 timestamp"
}
```

---

## Required Action

1. **Automation Testing Engineer** creates a GitHub issue labeled `bug:critical`, `bug:high`, `bug:medium`, or `bug:low`
2. Issue includes:
   - Reproduction steps
   - Expected vs actual behavior
   - Screenshot/video evidence
   - Failing test name and output
3. Issue is assigned to the responsible Frontend or Backend Engineer
4. Issue is linked to the original User Story or Task

---

## Resolution Criteria

- [ ] Developer acknowledges the bug within 4 hours
- [ ] Bug is fixed and unit tests updated
- [ ] Fix is committed with a reference to the bug issue number
- [ ] All related tests pass (visual, API, unit)
- [ ] QA re-tests the fix and marks the bug as resolved
- [ ] Original User Story / Task acceptance criteria still met

---

## Escalation Path

If the bug is:

- **Critical and unfixed for >4 hours:** Escalate to Tech Lead
- **Found repeatedly in same component:** Flag to Tech Lead as systemic code quality issue
- **Blocks the release:** Escalate to Product Manager for timeline adjustment

---

## Automation

- Trigger: CI/CD pipeline detects test failure
- Action: Create GitHub issue with payload + auto-assign
- Notification: Slack alert to developer + team channel
- Timeout: Auto-escalate to Tech Lead if unacknowledged for 4 hours
