---
name: database-schema-design
description: >
  Designs database schemas including ERDs, normalized tables, primary keys, foreign keys,
  indexes, constraints, and data types. Includes data governance, ownership, access control,
  and GDPR compliance considerations. Use when designing a database for a new feature,
  optimizing schema performance, documenting a data model, or ensuring data quality
  and regulatory compliance.
instructions: []
agents:
  - data-architect
  - microservices-engineer
triggers: []
metadata:
  author: bluestella
  version: "1.0"
---

# Database Schema Design

## Overview

This skill produces complete database schema designs for Data Architects and Backend Engineers — covering entity-relationship diagrams, normalized table definitions, indexing strategy, data governance, GDPR compliance, and migration plans. Output is documentation-ready markdown with embedded Mermaid ERDs.

## Steps

1. **Capture business context.** Document the business problem, key entities, and data requirements. Identify multi-tenancy, compliance, and scale constraints upfront.
2. **Draw the ERD.** Use Mermaid `erDiagram` syntax to show entities, relationships (||, |{, }|), and key attributes. Keep it high-level first, detail later.
3. **Define each table.** For every entity: column name, type, constraints (PK, FK, UK, NOT NULL, CHECK), index type, and purpose. Use the table definition format from [`templates/schema-template.md`](templates/schema-template.md).
4. **Design the indexing strategy.** Add indexes for every FK, every WHERE clause column, and every UNIQUE constraint. Document the query pattern each index serves.
5. **Document data governance.** Assign ownership per table, define data retention periods, access control matrix (admin/user/service account), and PII fields requiring encryption.
6. **Address compliance.** GDPR: soft-delete via `deleted_at`, PII fields identified and encrypted, right-to-erasure path documented.
7. **Write the migration plan.** If replacing an existing schema: dual-write phase, data sync verification, cutover steps, rollback plan.
8. **Get sign-off.** Data Architect + Backend Lead + Compliance.

## Output Format

A markdown schema design document:

```
## Business Context        — problem, requirements, constraints
## ERD                     — Mermaid erDiagram
## Table Definitions       — per-table: columns, types, constraints, indexes, notes
## Normalization Analysis   — 3NF assessment, denormalization trade-offs
## Data Governance         — ownership, retention, access control
## Compliance              — GDPR checklist, encryption, audit trail
## Indexing Strategy       — index table with query patterns
## Migration Plan          — if replacing existing schema
## Sign-Off
```

Template: [`templates/schema-template.md`](templates/schema-template.md)

## Examples

**Input:** "Design user and subscription tables for a SaaS platform. Multi-tenant (orgs), GDPR required, financial records must never be hard-deleted."

**Output:** ERD with organizations → users → subscriptions → invoices → charges → audit_log. Table definitions with soft-delete on users/subscriptions, price stored as `integer` (cents), audit_log with `old_values`/`new_values` JSONB and 7-year retention.

**Input:** "Add an audit trail table for compliance."

**Output:** `audit_log` table definition with entity_type, entity_id, action (create/update/delete), old_values/new_values (JSONB), immutable (no soft-delete), 7-year retention policy.

## Edge Cases

- Float/decimal for money: always use `integer` (cents) — never `float`. Document why.
- Multi-tenancy: every table must have `org_id FK` with index on `(org_id, deleted_at)`.
- PII fields: list all PII columns explicitly; specify application-level encryption on top of DB encryption.
- Performance at scale: if expected rows > 10M, flag for partitioning and add EXPLAIN ANALYZE notes.

## References

See [`references/REFERENCE.md`](references/REFERENCE.md) for normalization rules, naming conventions, GDPR compliance checklist, and PostgreSQL-specific guidance.
