---
title: Hook — Architecture to Integration Architect (API Design)
description: Trigger for when Integration Architect receives APIs that don't match architecture spec
---

# Hook: Architecture Enforcement — API Compliance Check

## Trigger Condition

**Source Agent:** Integration Architect (or Solution Architect reviewing backend PR)  
**Destination Agent:** Backend Developer or API Designer  
**Event:** Implemented API contract doesn't match architecture specification

**Detection:**

- API endpoint doesn't match OpenAPI spec
- Request/response schema deviates from spec
- Missing error handling defined in spec
- Authentication method different from spec
- Rate limiting not implemented as specified
- Response format inconsistent with architectural standard

**Severity:**

- 🔴 Critical: Breaking API contract, frontend can't consume
- 🟠 High: Deviates from spec, requires frontend workaround
- 🟡 Medium: Minor deviation, adds technical debt
- 🔵 Low: Edge case, documentation issue

---

## Trigger Payload

```json
{
  "event": "api_spec_compliance_issue",
  "severity": "High",
  "api_endpoint": "POST /api/v1/auth/signup",
  "issue": "Response format doesn't match OpenAPI spec",
  "spec_expects": {
    "format": "{ success: true, data: { user, token }, meta: { timestamp, request_id } }"
  },
  "implementation_returns": {
    "format": "{ user: { ... }, token: '...' }"
  },
  "impact": "Frontend expecting { success, data, meta } but received flat structure",
  "pr_link": "https://github.com/acme/api/pull/1234",
  "assigned_to": "Backend Developer",
  "created_at": "ISO 8601 timestamp"
}
```

---

## Required Action

1. **Integration Architect** reviews PR and checks compliance:
   - Does endpoint match OpenAPI spec?
   - Do request/response match spec?
   - Is error handling implemented?
   - Is rate limiting correct?

2. **Integration Architect** leaves PR comment with compliance checklist:

   ````markdown
   ## API Compliance Check: ❌ NEEDS FIXES

   ### Issues Found:

   - [ ] Response format doesn't match spec (missing `success` and `meta` fields)
   - [ ] Error response doesn't follow standard error format
   - [ ] Missing Retry-After header on rate limit response

   ### Expected Response:

   ```json
   {
     "success": true,
     "data": { "user": { ... }, "token": "..." },
     "meta": { "timestamp": "...", "request_id": "..." }
   }
   ```
   ````

   ### Actual Response:

   ```json
   {
     "user": { ... },
     "token": "..."
   }
   ```

   ### Action Required:
   - [ ] Update response to match spec
   - [ ] Add error response format
   - [ ] Verify in OpenAPI tests

   Please fix and re-request review.

   ```

   ```

3. **Backend Developer** fixes the API to match spec

4. **Integration Architect** re-reviews and approves

---

## Prevention

### Code Review Checklist

**Integration Architect must verify:**

- [ ] All endpoints match OpenAPI spec
- [ ] All request/response schemas match spec
- [ ] Error responses follow standard format
- [ ] Authentication matches spec
- [ ] Rate limiting implemented
- [ ] Response headers (Retry-After, X-RateLimit-\*, etc.) included
- [ ] Pagination implemented for list endpoints
- [ ] Timestamps in UTC, ISO 8601 format

### Testing

**Before submitting PR, Backend Developer runs:**

```bash
# Generate OpenAPI spec from code
pnpm run openapi:generate

# Validate against spec
pnpm run openapi:validate

# Test against frontend contract tests
pnpm run test:api-contracts
```

---

## Resolution Criteria

- [ ] API matches OpenAPI spec exactly
- [ ] Integration tests pass (frontend can consume)
- [ ] Error responses follow standard format
- [ ] Rate limiting headers included
- [ ] Integration Architect approves
- [ ] All API tests passing

---

## Architecture Benefits

This hook ensures:

- ✅ Frontend and backend teams aligned before dev
- ✅ No surprises during integration
- ✅ Consistent API patterns across microservices
- ✅ Specification is source of truth
- ✅ Prevents architectural drift

---

## Escalation Path

- **API deviates from spec >2x:** Escalate to Solution Architect (spec may need updating)
- **Backend team consistently deviates:** Escalate to Tech Lead (team training needed)
- **Spec is unachievable:** Escalate to Solution Architect + Tech Lead (design flaw)

---

## Automation

- Trigger: OpenAPI validation fails in CI/CD
- Action: Block PR merge until spec-compliant
- Validation: Run OpenAPI validator in CI/CD pipeline
- Notification: Slack alert to Integration Architect
- Auto-check: Generate OpenAPI from code, compare to spec
