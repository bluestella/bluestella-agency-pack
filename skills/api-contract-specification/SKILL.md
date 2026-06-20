---
name: api-contract-specification
description: >
  Generates OpenAPI 3.0 specification documents for REST APIs including endpoints,
  request/response schemas, status codes, error responses, authentication, rate limiting,
  and versioning strategy. Use when designing API contracts, documenting REST endpoints,
  ensuring frontend/backend alignment, defining error handling standards, or planning
  API version management.
metadata:
  author: bluestella
  version: "1.0"
---

# API Contract Specification

## Overview

An API Contract is a formal specification defining how frontend and backend communicate. This skill produces OpenAPI 3.0 YAML documents that align teams before development begins — preventing integration failures, mismatched schemas, and undefined error states.

## Steps

1. **Establish the contract skeleton.** Use [`templates/openapi-template.yaml`](templates/openapi-template.yaml) as the base. Set `info`, `servers` (production + staging), and global `security` schemes.
2. **Define shared schemas.** In `components/schemas`, add: `SuccessResponse`, `ErrorResponse`, and all domain models (User, Subscription, etc.) with required fields and validation constraints.
3. **Document each endpoint.** For every route: path, method, description, request body (with schema ref), and all expected responses (200/201, 400, 401, 403, 404, 409, 429, 500).
4. **Specify authentication.** Choose Bearer JWT or API key. Document which endpoints are public (no auth) vs protected. Describe token format and expiry.
5. **Define rate limiting.** Document rate limit headers (`X-RateLimit-Limit`, `X-RateLimit-Remaining`, `Retry-After`) and per-endpoint limits.
6. **Add versioning strategy.** URL-based versioning (`/v1/`, `/v2/`). Document deprecation policy for old versions.
7. **Review with both teams.** Integration Architect + Frontend lead + Backend lead must sign off before implementation starts.

## Output Format

An OpenAPI 3.0 YAML file (`openapi.yaml`) structured as:

```
info + servers + security
components/
  securitySchemes   — auth methods
  schemas           — reusable data models
  responses         — reusable error responses
paths/
  /endpoint         — per-route: summary, request body, responses
```

Template: [`templates/openapi-template.yaml`](templates/openapi-template.yaml)

## Examples

**Input:** "Document the signup endpoint: POST /auth/signup with email + password."

**Output:** OpenAPI path entry with `requestBody` referencing `SignupRequest` schema (email: string/format:email required, password: string/minLength:8 required), and responses for 201 (user created), 400 (validation error), 409 (duplicate email), 429 (rate limited).

**Input:** "Define a standard error response format used by all endpoints."

**Output:** `ErrorResponse` schema in `components/schemas` with fields: `success: false`, `error.code` (enum of error codes), `error.message` (string), `error.details` (array for field-level validation errors), `meta.timestamp`, `meta.request_id`.

## Edge Cases

- No existing API contract: start from the template and define error schemas first (every endpoint uses them).
- Legacy API with undocumented endpoints: document as-is first, then annotate with `deprecated: true` for endpoints to be replaced.
- GraphQL instead of REST: this skill targets REST only; use a separate schema SDL approach for GraphQL.
- Breaking changes (v2): maintain v1 contract with `deprecated` tags; publish v2 as a new spec file.

## References

See [`references/REFERENCE.md`](references/REFERENCE.md) for OpenAPI 3.0 spec details, error code conventions, auth patterns, and versioning guidance.
