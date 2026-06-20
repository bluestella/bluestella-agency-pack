---
applyTo: "src/api/**"
title: "API Pattern Standards"
description: "Enforce consistent API route handler structure, validation, responses, and error handling"
---

## Route Handler Pipeline

**Required order** for all endpoints:

```
withAuth() → withRateLimit() → validate(schema) → repository/service → respond()
```

## Validation (Zod)

- **VALIDATE** all request bodies with Zod schemas BEFORE business logic
- Define schemas in `src/schemas/` (centralized)
- Return 400 Bad Request with field-level errors if validation fails
- Example: `schema.parse(req.body)` wrapped in try-catch

## Response Format

**Success (200, 201):**

```json
{
  "success": true,
  "data": {
    /* resource data */
  },
  "meta": { "timestamp": "2026-06-20T14:32:45Z", "request_id": "req_123" }
}
```

**Error (4xx, 5xx):**

```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Human-readable message",
    "details": [{ "field": "email", "message": "Invalid format" }]
  },
  "meta": { "timestamp": "...", "request_id": "..." }
}
```

## Repository Pattern

- **NEVER** query database directly from route handlers
- **USE** repository or service layer for persistence
- Keep business logic in service layer, persistence in repository

Example:

```typescript
// Route handler (handler only routes)
const user = await userRepository.findById(id);
return respond(res, { data: user });

// Repository (persistence only)
async findById(id: string) {
  return db.query('SELECT * FROM users WHERE id = ? AND deleted_at IS NULL', [id]);
}
```

## Data Retention (Soft Delete)

- **Apply soft-delete semantics** for compliance (GDPR, audit trails)
- Add `deleted_at` timestamp column; NULL = active, NOT NULL = deleted
- All queries should filter: `WHERE deleted_at IS NULL`
- **NEVER hard-delete records** (prevents auditing, violates GDPR)

## Error Handling

- **DO NOT expose raw exception messages** to API consumers
- Map errors to standardized codes: VALIDATION_ERROR, NOT_FOUND, CONFLICT, INTERNAL_ERROR, etc.
- **Log full exceptions** server-side (CloudWatch) for debugging
- Return user-friendly messages ("Invalid email format", not "SQL syntax error")

## Rate Limiting

- **Apply rate limiting** after auth (check IP + user)
- Return 429 Too Many Requests with `Retry-After` header
- Example: 100 requests per minute per authenticated user

## Authentication

- **Bearer token** (JWT) in `Authorization` header
- Verify token signature + expiration
- Return 401 Unauthorized if missing or invalid
- Extract `user_id` and `org_id` from token
