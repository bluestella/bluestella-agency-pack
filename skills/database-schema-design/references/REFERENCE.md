# Database Schema Design — Reference Guide

## Naming Conventions

- **Tables:** plural, snake_case — `users`, `organizations`, `audit_logs`
- **Columns:** singular, snake_case — `user_id`, `created_at`, `deleted_at`
- **PKs:** always named `id` (UUID preferred over auto-increment for distributed systems)
- **FKs:** `{referenced_table_singular}_id` — `user_id`, `org_id`, `subscription_id`
- **Timestamps:** `created_at`, `updated_at`, `deleted_at` (soft-delete)
- **Enums:** store as varchar with CHECK constraint; document valid values in column notes

## Data Type Guidelines

| Use Case       | Type              | Notes                                            |
| -------------- | ----------------- | ------------------------------------------------ |
| Primary key    | uuid              | `gen_random_uuid()` in PostgreSQL 13+            |
| Money          | integer           | Store in cents — never use float for money       |
| Status flags   | varchar + CHECK   | Readable; ADD enum value without migration lock  |
| Timestamps     | timestamp         | Always UTC; no timezone storage in DB            |
| JSON/config    | jsonb             | Indexed; prefer over separate config tables      |
| Text fields    | varchar(N)        | Set max length; use `text` only when unbounded   |

## Normal Forms Cheat Sheet

- **1NF:** No repeating groups; each column has atomic values.
- **2NF:** 1NF + no partial dependencies on composite key.
- **3NF:** 2NF + no transitive dependencies (non-key column depending on another non-key column).
- **BCNF:** Every determinant is a candidate key.

Denormalize intentionally and document why. Common justified exceptions: cached counts, denormalized display names to avoid JOINs in hot paths.

## Soft Delete Pattern

```sql
-- Add to every table that requires GDPR right-to-erasure or audit history
deleted_at TIMESTAMP NULL DEFAULT NULL

-- Filter in all queries:
WHERE deleted_at IS NULL        -- active records
WHERE deleted_at IS NOT NULL    -- deleted records
```

Never hard-delete financial records, user accounts, or audit logs.

## GDPR Compliance Checklist

- [ ] All PII columns identified (name, email, phone, address, tax ID, etc.)
- [ ] PII encrypted at application layer for highly sensitive fields (tax_id, SSN)
- [ ] `deleted_at` soft-delete on all tables containing PII
- [ ] Audit log retains 7 years (compliance requirement in most jurisdictions)
- [ ] Data residency: confirm AWS region or DB host is in required geography
- [ ] DPA signed with all SaaS processors that receive personal data
- [ ] Right-to-erasure path: anonymize user PII on request (don't delete rows — replace with `[DELETED]`)

## Index Design Principles

1. Index every FK column (prevents full table scans on JOINs)
2. Index every column in WHERE clauses of frequent queries
3. Composite indexes: put the most selective column first
4. Index `deleted_at` on soft-delete tables (queries always filter on it)
5. Don't index low-cardinality columns (booleans, status with 2–3 values) unless combined with high-selectivity columns
6. Run `EXPLAIN ANALYZE` on all new queries; look for `Seq Scan` as a warning sign

## External References

- [PostgreSQL Documentation](https://www.postgresql.org/docs/current/)
- [Database Normalization — Wikipedia](https://en.wikipedia.org/wiki/Database_normalization)
- [GDPR Data Protection](https://gdpr-info.eu/)
- [Use the Index, Luke! — Indexing guide](https://use-the-index-luke.com/)
