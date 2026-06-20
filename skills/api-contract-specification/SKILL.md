---
name: api-contract-specification
description: Generates OpenAPI 3.0 specification documents for REST APIs including endpoints, request/response schemas, status codes, error responses, authentication, rate limiting, and versioning strategy. WHEN: Designing API contracts, documenting REST endpoints, ensuring frontend/backend alignment, defining error handling standards, version management strategy.
---

# API Contract Specification Skill — OpenAPI Documentation

## Overview

An **API Contract** is a formal specification defining how the frontend and backend communicate. This skill helps Integration Architects and Backend Engineers document REST APIs using the OpenAPI 3.0 standard, ensuring frontend and backend teams are aligned before development.

## When to Use This Skill

- **Scenario 1:** Design signup API (POST /auth/signup)
- **Scenario 2:** Define error response format for all APIs
- **Scenario 3:** Document authentication (OAuth 2.0, Bearer tokens)
- **Scenario 4:** Specify rate limiting strategy
- **Scenario 5:** Plan API versioning (v1, v2)

---

## OpenAPI 3.0 Contract Template

```yaml
openapi: 3.0.3

info:
  title: "Acme SaaS API"
  description: "REST API for Acme SaaS subscription platform"
  version: "1.0.0"
  contact:
    name: "API Support"
    email: "api-support@acme.com"

servers:
  - url: "https://api.acme.com/v1"
    description: "Production"
  - url: "https://staging-api.acme.com/v1"
    description: "Staging"

security:
  - BearerAuth: []  # Default auth for all endpoints
  - ApiKeyAuth: []  # Alternative: API key auth

components:
  securitySchemes:
    BearerAuth:
      type: "http"
      scheme: "bearer"
      bearerFormat: "JWT"
      description: "JWT token from login endpoint"
    ApiKeyAuth:
      type: "apiKey"
      in: "header"
      name: "X-API-Key"
      description: "API key for service-to-service calls"

  schemas:
    # Standard Response Wrapper
    SuccessResponse:
      type: "object"
      properties:
        success:
          type: "boolean"
          example: true
        data:
          type: "object"
          description: "Response payload"
        meta:
          type: "object"
          properties:
            timestamp:
              type: "string"
              format: "date-time"
            request_id:
              type: "string"
              description: "Correlation ID for debugging"
          example:
            timestamp: "2026-06-20T14:32:45Z"
            request_id: "req_abc123def456"

    ErrorResponse:
      type: "object"
      required: ["success", "error"]
      properties:
        success:
          type: "boolean"
          example: false
        error:
          type: "object"
          required: ["code", "message"]
          properties:
            code:
              type: "string"
              enum: [
                "VALIDATION_ERROR",
                "AUTHENTICATION_FAILED",
                "AUTHORIZATION_FAILED",
                "RESOURCE_NOT_FOUND",
                "CONFLICT",
                "RATE_LIMITED",
                "INTERNAL_ERROR"
              ]
            message:
              type: "string"
              description: "Human-readable error message"
              example: "Invalid email format"
            details:
              type: "array"
              items:
                type: "object"
              description: "Additional error context"
              example:
                - field: "email"
                  message: "Must be a valid email address"
          example:
            code: "VALIDATION_ERROR"
            message: "Request validation failed"
            details:
              - field: "email"
                message: "Must be a valid email address"
        meta:
          type: "object"
          properties:
            timestamp:
              type: "string"
              format: "date-time"
            request_id:
              type: "string"

    # Auth Schemas
    SignupRequest:
      type: "object"
      required: ["email", "password"]
      properties:
        email:
          type: "string"
          format: "email"
          example: "user@example.com"
        password:
          type: "string"
          minLength: 8
          description: "Must be ≥8 chars, ≥1 uppercase, ≥1 number"
          example: "SecurePass123"
        org_name:
          type: "string"
          nullable: true
          description: "Optional: organization name (if creating new org)"

    SignupResponse:
      type: "object"
      properties:
        user:
          type: "object"
          properties:
            id:
              type: "string"
              format: "uuid"
            email:
              type: "string"
            org_id:
              type: "string"
              format: "uuid"
            created_at:
              type: "string"
              format: "date-time"
        token:
          type: "string"
          description: "JWT access token (valid for 1 hour)"
          example: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."

    # Pagination
    PaginatedResponse:
      type: "object"
      properties:
        items:
          type: "array"
          items:
            type: "object"
        pagination:
          type: "object"
          properties:
            total:
              type: "integer"
              description: "Total number of items"
            limit:
              type: "integer"
              description: "Items per page"
            offset:
              type: "integer"
              description: "Offset in results"
            has_more:
              type: "boolean"

paths:
  /auth/signup:
    post:
      summary: "User signup"
      description: "Create a new user account and return JWT token"
      tags: ["Authentication"]
      operationId: "createUser"
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: "#/components/schemas/SignupRequest"
            examples:
              basic:
                summary: "Basic signup"
                value:
                  email: "user@example.com"
                  password: "SecurePass123"
              with_org:
                summary: "Signup with new org"
                value:
                  email: "admin@acme.com"
                  password: "SecurePass123"
                  org_name: "Acme Corp"
      responses:
        201:
          description: "User created successfully"
          content:
            application/json:
              schema:
                allOf:
                  - $ref: "#/components/schemas/SuccessResponse"
                  - type: "object"
                    properties:
                      data:
                        $ref: "#/components/schemas/SignupResponse"
        400:
          description: "Validation error (invalid email, weak password)"
          content:
            application/json:
              schema:
                $ref: "#/components/schemas/ErrorResponse"
              example:
                success: false
                error:
                  code: "VALIDATION_ERROR"
                  message: "Password must be ≥8 characters"
                  details:
                    - field: "password"
                      message: "Password too weak"
        409:
          description: "Email already registered"
          content:
            application/json:
              schema:
                $ref: "#/components/schemas/ErrorResponse"
              example:
                success: false
                error:
                  code: "CONFLICT"
                  message: "Email already registered"
        429:
          description: "Rate limit exceeded (max 5 signups per IP per hour)"
          headers:
            Retry-After:
              schema:
                type: "integer"
              description: "Seconds to wait before retrying"
          content:
            application/json:
              schema:
                $ref: "#/components/schemas/ErrorResponse"
        500:
          description: "Internal server error"
          content:
            application/json:
              schema:
                $ref: "#/components/schemas/ErrorResponse"

  /auth/verify/{token}:
    get:
      summary: "Verify email"
      description: "Verify user email using verification token from signup email"
      tags: ["Authentication"]
      operationId: "verifyEmail"
      parameters:
        - name: "token"
          in: "path"
          required: true
          schema:
            type: "string"
          description: "Verification token from email (valid for 24 hours)"
      responses:
        200:
          description: "Email verified"
          content:
            application/json:
              schema:
                allOf:
                  - $ref: "#/components/schemas/SuccessResponse"
                  - type: "object"
                    properties:
                      data:
                        type: "object"
                        properties:
                          message:
                            type: "string"
                            example: "Email verified successfully"
        404:
          description: "Invalid or expired token"
        500:
          description: "Internal server error"

  /users:
    get:
      summary: "List users in organization"
      description: "Get paginated list of users in your organization (requires authentication)"
      tags: ["Users"]
      operationId: "listUsers"
      security:
        - BearerAuth: []
      parameters:
        - name: "limit"
          in: "query"
          schema:
            type: "integer"
            default: 20
            maximum: 100
          description: "Results per page"
        - name: "offset"
          in: "query"
          schema:
            type: "integer"
            default: 0
          description: "Offset for pagination"
        - name: "role"
          in: "query"
          schema:
            type: "string"
            enum: ["admin", "member", "viewer"]
          description: "Filter by role"
      responses:
        200:
          description: "List of users"
          content:
            application/json:
              schema:
                allOf:
                  - $ref: "#/components/schemas/SuccessResponse"
                  - $ref: "#/components/schemas/PaginatedResponse"
        401:
          description: "Unauthorized (missing or invalid token)"
        500:
          description: "Internal server error"

# ... more endpoints
```

---

## Response Format Standards

### Success Response (2xx)

```json
{
  "success": true,
  "data": {
    "id": "user_abc123",
    "email": "user@example.com",
    "created_at": "2026-06-20T14:32:45Z"
  },
  "meta": {
    "timestamp": "2026-06-20T14:32:45Z",
    "request_id": "req_xyz789"
  }
}
```

### Error Response (4xx, 5xx)

```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Request validation failed",
    "details": [
      {
        "field": "email",
        "message": "Must be a valid email address"
      }
    ]
  },
  "meta": {
    "timestamp": "2026-06-20T14:32:45Z",
    "request_id": "req_xyz789"
  }
}
```

---

## HTTP Status Code Guide

| Status | Meaning | When to Use | Example |
| ------ | ------- | ----------- | ------- |
| 200 OK | Request successful | GET, successful PUT/PATCH | Fetched user |
| 201 Created | Resource created | Successful POST | User signup |
| 400 Bad Request | Invalid request | Validation error | Missing email field |
| 401 Unauthorized | Auth required or failed | Missing/invalid JWT | No bearer token |
| 403 Forbidden | Auth passed but unauthorized | Insufficient permissions | Non-admin accessing admin endpoint |
| 404 Not Found | Resource doesn't exist | ID not found | User ID doesn't exist |
| 409 Conflict | Violates constraint | Duplicate email | Email already registered |
| 429 Too Many Requests | Rate limited | Exceeded rate limit | 6th signup attempt in 1 hour |
| 500 Internal Error | Server error | Unhandled exception | Database connection failed |
| 503 Service Unavailable | Server temporarily down | Maintenance, downtime | Database unavailable |

---

## Authentication & Authorization

```yaml
# Bearer Token (JWT)
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...

# Scope (optional, for OAuth 2.0)
scope: "users:read users:write subscriptions:read"

# Service-to-Service (API Key)
X-API-Key: sk_live_abc123def456xyz789
```

---

## Rate Limiting

```yaml
# Response Headers
X-RateLimit-Limit: 1000           # Requests allowed per hour
X-RateLimit-Remaining: 998        # Requests remaining
X-RateLimit-Reset: 1687270365     # Unix timestamp when limit resets

# 429 Response
HTTP/1.1 429 Too Many Requests
Retry-After: 3600

{
  "success": false,
  "error": {
    "code": "RATE_LIMITED",
    "message": "Rate limit exceeded. Try again in 3600 seconds"
  }
}
```

---

## Versioning Strategy

### Option 1: URL Versioning (Recommended)
```
GET /v1/users    (stable version)
GET /v2/users    (new version with breaking changes)
```

### Option 2: Header Versioning
```
GET /users
API-Version: 1
```

### Option 3: Accept Header
```
GET /users
Accept: application/vnd.acme.v1+json
```

**Recommendation:** Use URL versioning. It's explicit, discoverable, and follows REST conventions.

**Deprecation Policy:**
- v1 released 2026-06-20
- v2 released 2026-12-20 (v1 + breaking changes)
- v1 sunset date: 2027-06-20 (6 months notice)
- Clients must migrate from v1 to v2 by sunset date

---

## Error Codes (Client Guide)

| Code | HTTP Status | Meaning | Action |
| ---- | ----------- | ------- | ------ |
| VALIDATION_ERROR | 400 | Request data invalid | Fix field and retry |
| AUTHENTICATION_FAILED | 401 | Auth failed or missing | Login again, get new token |
| AUTHORIZATION_FAILED | 403 | Not permitted | Contact admin for access |
| RESOURCE_NOT_FOUND | 404 | Resource doesn't exist | Check ID is correct |
| CONFLICT | 409 | Constraint violation | Unique field duplicate or data conflict |
| RATE_LIMITED | 429 | Too many requests | Wait and retry (see Retry-After header) |
| INTERNAL_ERROR | 500 | Server error | Retry after delay; contact support if persists |

---

## API Contract Best Practices

1. **Be consistent:** All endpoints follow same response format
2. **Version from day 1:** Even if v1, plan for v2
3. **Use HTTP status codes correctly:** Not everything is 200 + error in body
4. **Document error responses:** What errors can this endpoint return?
5. **Include timestamps:** Every response should have timestamp for debugging
6. **Request IDs for tracing:** Correlation ID for support requests
7. **Paginate large results:** Never return 1M users in one response
8. **Rate limit APIs:** Prevent abuse, ensure fair usage
9. **Deprecation warnings:** Alert clients of upcoming changes
10. **Test your spec:** Use Postman, Swagger UI, or similar to validate

---

## Tools

- **Swagger Editor:** https://editor.swagger.io/ (visual OpenAPI editor)
- **Postman:** https://www.postman.com/ (API testing, spec generation)
- **OpenAPI Generator:** https://openapi-generator.tech/ (Generate code from spec)
- **Prism Mock Server:** https://stoplight.io/prism/ (Mock your API based on spec)

---

## References

- [OpenAPI 3.0 Specification](https://spec.openapis.org/oas/v3.0.3)
- [HTTP Status Codes](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status)
- [RESTful API Design Best Practices](https://restfulapi.net/)
- [JWT.io](https://jwt.io/) — JWT token debugger
