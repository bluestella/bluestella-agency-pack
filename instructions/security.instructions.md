---
applyTo: "{src/middleware/**,src/auth/**,src/api/**,src/services/**}"
title: "Security Standards"
description: "Enforce authentication, authorization, secrets management, and input sanitization"
---

## Authentication & Authorization

- **REQUIRE** auth middleware on ALL protected routes (no exceptions)
- **VERIFY** JWT token signature and expiration before proceeding
- **EXTRACT** user_id and org_id from token for RBAC checks
- **REJECT** 401 Unauthorized if token missing, invalid, or expired
- **REJECT** 403 Forbidden if user lacks required role/permission

Example:
```typescript
router.get('/users/:id', withAuth(), async (req, res) => {
  // withAuth() verifies JWT and attaches req.user
  const { user_id, org_id } = req.user;
  // Check: Does this user have access to the requested resource?
});
```

## Rate Limiting

- **APPLY** rate limiting on EVERY public endpoint
- **LIMIT** by IP (unauthenticated) or user_id (authenticated)
- **THRESHOLDS:**
  - Login/signup: 5 attempts per 15 minutes
  - API: 100 requests per minute per user
  - Public endpoints: 1000 requests per hour per IP
- **RETURN** 429 Too Many Requests with `Retry-After` header

## Secrets & Sensitive Data Management

### Never Log or Return:
- ❌ Passwords (hashed or plain)
- ❌ JWT tokens, API keys, credentials
- ❌ PII: email, phone, SSN, tax ID, credit card
- ❌ Unencrypted database connection strings
- ❌ API secrets or third-party credentials

### Correct Patterns:
```typescript
// ❌ BAD: Logs plaintext credentials
console.log('Auth token:', token);

// ✅ GOOD: Logs redacted token
console.log('Auth token:', token.substring(0, 10) + '***');

// ❌ BAD: Returns password in response
return { user: { id, email, password: user.password } };

// ✅ GOOD: Omits password
return { user: { id, email } };
```

## Input Sanitization

- **SANITIZE** all user inputs before any database write
- **USE** parameterized queries (never string interpolation)
- **VALIDATE** with Zod schemas
- **TRIM** whitespace, enforce max length
- **CHECK** for SQL injection patterns

Example:
```typescript
// ❌ BAD: SQL injection risk
const query = `SELECT * FROM users WHERE email = '${req.body.email}'`;

// ✅ GOOD: Parameterized query
const query = 'SELECT * FROM users WHERE email = ?';
db.execute(query, [req.body.email]);
```

## Forbidden Patterns

- ❌ **NEVER use `eval()`** — code injection vulnerability
- ❌ **NEVER use dynamic `require()`** — code injection vulnerability  
- ❌ **NEVER use string-interpolated SQL** — SQL injection vulnerability
- ❌ **NEVER hardcode secrets** in code (use environment variables)
- ❌ **NEVER commit `.env` files** to git
- ❌ **NEVER disable HTTPS** in production
- ❌ **NEVER skip CORS validation** for cross-origin requests

## OWASP Top 10 Checklist

| Vulnerability | Prevention |
| ------------- | ----------- |
| Broken Access Control | RBAC checks on all endpoints; least-privilege IAM |
| Cryptographic Failures | Encrypt PII at rest + in transit; TLS 1.2+ |
| Injection (SQL, NoSQL) | Parameterized queries, Zod validation |
| Insecure Design | Threat model (STRIDE) before coding |
| Security Misconfiguration | Security.instructions enforcement, regular audits |
| Vulnerable Dependencies | Dependabot alerts, pnpm audit, CodeQL |
| Authentication Failures | Strong passwords (12+ chars), MFA for admins, JWT expiry |
| Data Integrity Failures | Validate input, use transactions for critical ops |
| Logging Failures | Log security events (login, permission denied); redact PII |
| Supply Chain Risks | Review third-party packages, pin versions, audit dependencies |

## Encryption

- **Passwords:** Argon2 hashing (not bcrypt)
- **At-Rest:** AWS RDS encryption (AES-256)
- **In-Transit:** TLS 1.2 or higher
- **PII Fields:** Application-layer encryption (additional to DB encryption)

## Access Control

- **Principle of Least Privilege:** Only grant minimum permissions needed
- **Role-Based Access Control (RBAC):** admin, member, viewer roles
- **Check in code:** Verify role before granting access (every protected endpoint)
- **Regular audit:** Review IAM policies quarterly
