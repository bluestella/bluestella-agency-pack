# API Contract Specification — Reference Guide

## OpenAPI 3.0 Spec Structure

```
openapi: 3.0.3
info          — title, description, version, contact
servers       — production + staging URLs
security      — global auth default
components/
  securitySchemes  — BearerAuth, ApiKeyAuth
  schemas          — reusable data models
  responses        — reusable error responses
paths/
  /endpoint        — GET/POST/PUT/DELETE with request + responses
```

Full spec: https://spec.openapis.org/oas/v3.0.3

## Standard Error Codes

| Code             | HTTP Status | When to Use                                      |
| ---------------- | ----------- | ------------------------------------------------ |
| VALIDATION_ERROR | 400         | Request body fails schema validation             |
| UNAUTHORIZED     | 401         | Missing or invalid JWT token                     |
| FORBIDDEN        | 403         | Valid token but insufficient permissions         |
| NOT_FOUND        | 404         | Resource ID doesn't exist                        |
| CONFLICT         | 409         | Duplicate unique field (email, slug, etc.)       |
| RATE_LIMITED     | 429         | Exceeded request rate                            |
| INTERNAL_ERROR   | 500         | Unhandled server error — never expose raw errors |

## Rate Limiting Headers

Always include on rate-limited endpoints:
```
X-RateLimit-Limit: 100         # Requests allowed per window
X-RateLimit-Remaining: 95      # Requests remaining in current window
X-RateLimit-Reset: 1718900400  # Unix timestamp when window resets
Retry-After: 60                # Seconds to wait (on 429 only)
```

## Authentication Patterns

**User-facing endpoints:** Bearer JWT in `Authorization: Bearer <token>` header
- Token expiry: 1 hour (short-lived for security)
- Refresh token: 30 days, rotated on use
- Store: httpOnly cookie (web) or secure storage (mobile)

**Service-to-service endpoints:** API key in `X-API-Key` header
- Keys stored in Secrets Manager, never in code
- Rotate every 90 days

**Public endpoints:** Set `security: []` to explicitly mark as unauthenticated

## Versioning Strategy

- URL versioning: `/v1/`, `/v2/` (explicit, clear, cacheable)
- One spec file per major version: `openapi-v1.yaml`, `openapi-v2.yaml`
- Deprecation: add `deprecated: true` to old endpoints, include `x-sunset` date header
- Support previous major version for minimum 6 months after new version release

## Common Schema Validation Rules

```yaml
email:    { type: string, format: email }
password: { type: string, minLength: 8, maxLength: 128 }
uuid:     { type: string, format: uuid }
datetime: { type: string, format: date-time }
enum:     { type: string, enum: [value1, value2] }
money:    { type: integer, minimum: 1, description: "Amount in cents" }
```

## API Design Principles

- **Idempotent by design:** PUT and DELETE must be idempotent; POST uses idempotency keys for payments.
- **Consistent naming:** snake_case for JSON fields; kebab-case for URL paths.
- **Pagination:** Use cursor-based pagination (`cursor`, `limit`, `hasMore`) not offset for large datasets.
- **Soft-delete semantics:** `DELETE /resource/{id}` sets `deleted_at`, does not erase the record.
- **Never expose internals:** No SQL errors, stack traces, or internal field names in error responses.

## External References

- [OpenAPI 3.0 Specification](https://spec.openapis.org/oas/v3.0.3)
- [Swagger Editor](https://editor.swagger.io/) — Validate YAML visually
- [API Design Guidelines — Microsoft REST API Guidelines](https://github.com/microsoft/api-guidelines)
- [Stoplight: OpenAPI Best Practices](https://stoplight.io/openapi)
