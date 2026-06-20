---
name: database-schema-design
description: Designs database schemas including entity-relationship diagrams (ERDs), normalized tables, primary keys, foreign keys, indexes, constraints, and data types. Includes data governance, ownership, access control, and compliance considerations. WHEN: Designing database for a new feature, optimizing schema performance, documenting data model, ensuring data quality and compliance.
---

# Database Schema Design Skill — Data Model Architecture

## Overview

A **Database Schema** is the blueprint for how data is organized in the database. This skill helps Data Architects and Backend Engineers design normalized, performant, compliant data models that support both operational and analytical needs.

## When to Use This Skill

- **Scenario 1:** Design user and subscription tables for SaaS application
- **Scenario 2:** Add audit trail table for compliance (GDPR, SOC 2)
- **Scenario 3:** Optimize slow queries by adding indexes and denormalization
- **Scenario 4:** Design schema for multi-tenancy (data isolation)
- **Scenario 5:** Plan soft-delete strategy for financial records

---

## Schema Design Template

### 1. Business Context

```markdown
## Schema Design: [Feature Name]

**Version:** 1.0  
**Date:** 2026-06-20  
**Owner:** Data Architect  
**Related Ticket:** [Feature link]

---

## Business Context

[Describe the business problem and data requirements]

**Example:**
"We're building a SaaS subscription platform. Users can sign up for monthly or annual plans. Each user belongs to an organization. Organizations have multiple users with different roles (admin, member). We need to track subscription history, charges, and refunds."

---

## Key Requirements

- [ ] Support multi-tenancy (organizations, role-based access)
- [ ] GDPR compliance (right to erasure, data residency)
- [ ] Audit trail (who changed what and when)
- [ ] Soft deletes (never hard-delete financial records)
- [ ] Performance at scale (1M users, 1B transactions)
- [ ] Analytics (revenue reporting, churn analysis)
```

### 2. Entity-Relationship Diagram (ERD)

```markdown
## Data Model (ERD)

[Mermaid ERD diagram or ASCII art]

### Example (Mermaid):

erDiagram
    ORGANIZATIONS ||--o{ USERS : contains
    USERS ||--o{ SUBSCRIPTIONS : has
    SUBSCRIPTIONS ||--o{ INVOICES : generates
    INVOICES ||--o{ CHARGES : contains
    ORGANIZATIONS ||--o{ AUDIT_LOG : tracks
    
    ORGANIZATIONS {
        uuid id PK
        string name
        string slug UK "Unique slug for subdomain"
        string country
        string tax_id
        timestamp created_at
        timestamp deleted_at
    }
    
    USERS {
        uuid id PK
        uuid org_id FK
        string email UK
        string password_hash
        string first_name
        string last_name
        enum role "admin|member|viewer"
        timestamp email_verified_at
        timestamp created_at
        timestamp deleted_at
    }
    
    SUBSCRIPTIONS {
        uuid id PK
        uuid org_id FK
        enum status "active|paused|cancelled"
        enum plan "starter|pro|enterprise"
        enum billing_interval "monthly|annual"
        decimal price_cents
        timestamp started_at
        timestamp renews_at
        timestamp cancelled_at
        timestamp created_at
        timestamp deleted_at
    }
    
    INVOICES {
        uuid id PK
        uuid subscription_id FK
        uuid org_id FK
        decimal amount_cents
        string status "draft|sent|paid|failed"
        timestamp due_date
        timestamp paid_at
        timestamp created_at
    }
    
    CHARGES {
        uuid id PK
        uuid invoice_id FK
        uuid org_id FK
        string stripe_charge_id UK
        decimal amount_cents
        string status "pending|succeeded|failed"
        string failure_reason
        timestamp created_at
    }
    
    AUDIT_LOG {
        uuid id PK
        uuid org_id FK
        uuid user_id FK
        string entity_type "users|subscriptions|..."
        uuid entity_id
        enum action "create|update|delete"
        jsonb old_values
        jsonb new_values
        timestamp created_at
    }
```

### 3. Table Definitions

```markdown
## Table Schemas

### organizations

| Column | Type | Constraints | Index | Purpose |
| ------ | ---- | ----------- | ----- | ------- |
| id | uuid | PK | ✅ (PK) | Unique org identifier |
| name | varchar(255) | NOT NULL | ❌ | Organization name |
| slug | varchar(100) | NOT NULL, UK | ✅ (UK) | URL-safe identifier (e.g., acme-corp) |
| country | varchar(2) | FK → countries | ✅ (FK) | ISO 3166 country code (for tax) |
| tax_id | varchar(50) | NULL | ✅ | Tax ID / VAT number (GDPR: PII) |
| created_at | timestamp | NOT NULL, DEFAULT NOW() | ✅ | Record creation |
| deleted_at | timestamp | NULL | ✅ | Soft delete timestamp |

**Indexes:**
- PRIMARY KEY (id)
- UNIQUE (slug)
- INDEX (deleted_at) — For queries excluding soft-deleted orgs

**Constraints:**
- CHECK (slug LIKE '[a-z0-9-]+') — Alphanumeric + dashes only
- FOREIGN KEY (country) REFERENCES countries(code)

**Notes:**
- Slug is immutable once set (for URL stability)
- deleted_at is nullable; NULL means active. NOT NULL means soft-deleted.
- tax_id is PII; must be encrypted at rest (see Compliance section)

---

### users

| Column | Type | Constraints | Index | Purpose |
| ------ | ---- | ----------- | ----- | ------- |
| id | uuid | PK | ✅ (PK) | Unique user identifier |
| org_id | uuid | NOT NULL, FK | ✅ (FK) | Organization membership |
| email | varchar(255) | NOT NULL, UK | ✅ (UK) | Email (case-insensitive) |
| password_hash | varchar(255) | NOT NULL | ❌ | Bcrypt/Argon2 hash, never plain text |
| first_name | varchar(100) | NOT NULL | ❌ | User first name (PII) |
| last_name | varchar(100) | NOT NULL | ❌ | User last name (PII) |
| role | enum | NOT NULL, DEFAULT 'member' | ✅ | RBAC: admin / member / viewer |
| email_verified_at | timestamp | NULL | ❌ | Null until email verified |
| created_at | timestamp | NOT NULL, DEFAULT NOW() | ✅ | Record creation |
| deleted_at | timestamp | NULL | ✅ | Soft delete (GDPR right-to-erasure) |

**Indexes:**
- PRIMARY KEY (id)
- UNIQUE (org_id, email) — One email per org (but same email across orgs is OK)
- INDEX (org_id, deleted_at) — Fast lookup of active users in an org
- INDEX (email_verified_at) — Unverified users for periodic cleanup

**Constraints:**
- FOREIGN KEY (org_id) REFERENCES organizations(id) ON DELETE CASCADE
- CHECK (email LIKE '%@%.%') — Basic email validation in DB
- CHECK (role IN ('admin', 'member', 'viewer'))

**Notes:**
- Password never stored in plain text; always hashed
- email_verified_at is nullable; used for email verification workflow
- deleted_at triggers soft-delete for GDPR compliance
- role determines API permissions (checked at application layer)

---

### subscriptions

| Column | Type | Constraints | Index | Purpose |
| ------ | ---- | ----------- | ----- | ------- |
| id | uuid | PK | ✅ (PK) | Unique subscription identifier |
| org_id | uuid | NOT NULL, FK | ✅ (FK) | Organization (for soft-delete cascade) |
| status | enum | NOT NULL, DEFAULT 'active' | ✅ | active / paused / cancelled |
| plan | enum | NOT NULL | ✅ | Pricing tier: starter / pro / enterprise |
| billing_interval | enum | NOT NULL | ❌ | monthly / annual |
| price_cents | integer | NOT NULL | ❌ | Price in cents (never use floats for money!) |
| started_at | timestamp | NOT NULL | ✅ | Subscription start date |
| renews_at | timestamp | NOT NULL | ✅ | Next billing date |
| cancelled_at | timestamp | NULL | ❌ | When subscription was cancelled |
| created_at | timestamp | NOT NULL, DEFAULT NOW() | ✅ | Record creation |
| deleted_at | timestamp | NULL | ✅ | Soft delete timestamp |

**Indexes:**
- PRIMARY KEY (id)
- INDEX (org_id, status) — Fast lookup of active subscriptions per org
- INDEX (renews_at) — Find subscriptions due for renewal

**Constraints:**
- FOREIGN KEY (org_id) REFERENCES organizations(id) ON DELETE CASCADE
- CHECK (status IN ('active', 'paused', 'cancelled'))
- CHECK (plan IN ('starter', 'pro', 'enterprise'))
- CHECK (billing_interval IN ('monthly', 'annual'))
- CHECK (price_cents > 0)
- CHECK (renews_at > started_at)

**Notes:**
- price_cents is integer (e.g., $9.99 = 999 cents); avoids float rounding errors
- renews_at is calculated from started_at + interval (monthly/annual)
- cancelled_at is used to calculate churn metrics; never hard-delete

---

### audit_log (Compliance / GDPR)

| Column | Type | Constraints | Index | Purpose |
| ------ | ---- | ----------- | ----- | ------- |
| id | uuid | PK | ✅ (PK) | Log entry ID |
| org_id | uuid | NOT NULL, FK | ✅ (FK) | Organization (for access control) |
| user_id | uuid | NOT NULL, FK | ✅ (FK) | User who made the change |
| entity_type | varchar(50) | NOT NULL | ✅ | Table name: users / subscriptions / ... |
| entity_id | uuid | NOT NULL | ✅ | ID of changed record |
| action | enum | NOT NULL | ❌ | create / update / delete |
| old_values | jsonb | NULL | ❌ | Previous column values (before update) |
| new_values | jsonb | NULL | ❌ | New column values (after update) |
| created_at | timestamp | NOT NULL, DEFAULT NOW() | ✅ | Immutable timestamp |

**Indexes:**
- PRIMARY KEY (id)
- INDEX (org_id, entity_type, entity_id, created_at) — Compliance queries
- INDEX (user_id, created_at) — User activity history

**Constraints:**
- FOREIGN KEY (org_id) REFERENCES organizations(id)
- FOREIGN KEY (user_id) REFERENCES users(id)
- CHECK (action IN ('create', 'update', 'delete'))
- CHECK (old_values IS NOT NULL OR new_values IS NOT NULL) — At least one should have values

**Notes:**
- Immutable: never update or soft-delete audit records
- old_values/new_values stored as JSON for flexibility
- Retention policy: keep for 7 years (compliance requirement)
- DO NOT log passwords or sensitive fields in old/new_values
```

### 4. Normalization & Denormalization

```markdown
## Normalization Analysis

This schema is in **Third Normal Form (3NF)**:
- ✅ No transitive dependencies
- ✅ Every non-key column depends on the primary key
- ✅ Data redundancy minimized

**Denormalization Opportunities:**
- Consider caching `org.name` in users table for fast display (denormalized; trade-off between normalization and query speed)
- Consider materialized view for monthly revenue (avoid re-calculating from invoices + charges every query)

**Query Performance Trade-offs:**
- JOIN users + subscriptions + invoices = slower (3 table join)
- Alternative: cache subscription price in invoice.price_cents (denormalized, but faster reports)
```

### 5. Data Governance

```markdown
## Data Governance

### Ownership

- **organizations:** Data Architect (governance), Finance team (business rules)
- **users:** Product team (user management), Security team (authentication)
- **subscriptions:** Finance team (billing)
- **audit_log:** Compliance / Legal team (audit trail)

### Quality Standards

- [ ] org.slug is always lowercase, alphanumeric + dashes, no trailing dashes
- [ ] user.email is normalized to lowercase (case-insensitive)
- [ ] user.password_hash is always hashed; never plain text in logs
- [ ] subscription.price_cents is always > 0
- [ ] All timestamps are in UTC (never store timezone)
- [ ] Soft-deleted records (deleted_at IS NOT NULL) are excluded from most queries

### Access Control

| Table | Admin | User | Service Account |
| ----- | ----- | ---- | --------------- |
| organizations | Full | Read own org only | Read |
| users | Full | Read own + org members | Read |
| subscriptions | Full | Read own org only | Read + Update |
| audit_log | Full | Read own org only | Read |

### Data Retention

| Table | Retention | Policy |
| ----- | --------- | ------ |
| organizations | Forever | Never delete (soft-delete only) |
| users | 7 years post-deletion | Soft-delete, keep for GDPR compliance |
| subscriptions | Forever | Never delete (financial records) |
| audit_log | 7 years | Compliance requirement |
| old_values/new_values in audit_log | 7 years | Never delete; immutable |
```

### 6. Compliance & Security

```markdown
## Compliance & Security

### GDPR Compliance

- ✅ Right to erasure: soft-delete users (deleted_at timestamp)
- ✅ Right to data portability: query audit_log to reconstruct user history
- ✅ PII identified: first_name, last_name, email, tax_id (encrypted at rest)
- ✅ Data processing agreement (DPA): signed with all third parties (Stripe, AWS)
- ✅ Data residency: All data stored in EU region (ireland)
- ❌ Automated decisions: N/A (no ML/profiling)

### Encryption

- **At-Rest:** All tables encrypted with AWS RDS encryption (AES-256)
- **In-Transit:** All database connections use SSL/TLS
- **PII Fields:** tax_id field encrypted with application-level encryption (additional layer)

### Secrets Management

- Database credentials stored in AWS Secrets Manager
- Never commit DB credentials to git
- Rotate credentials every 90 days

### Audit Trail

- audit_log table tracks all changes to sensitive tables
- Retention: 7 years (compliance requirement)
- Used for: Security investigations, compliance audits, support troubleshooting
```

### 7. Performance Optimization

```markdown
## Indexing Strategy

### Indexes Created

| Table | Index | Reason |
| ----- | ----- | ------ |
| organizations | PRIMARY KEY (id) | PK lookup |
| organizations | UNIQUE (slug) | Query by slug |
| organizations | INDEX (deleted_at) | Exclude soft-deleted orgs |
| users | PRIMARY KEY (id) | PK lookup |
| users | UNIQUE (org_id, email) | Unique email per org |
| users | INDEX (org_id, deleted_at) | List active users in org |
| users | INDEX (email_verified_at) | Find unverified users |
| subscriptions | PRIMARY KEY (id) | PK lookup |
| subscriptions | INDEX (org_id, status) | Active subscriptions per org |
| subscriptions | INDEX (renews_at) | Find subscriptions due for renewal |
| audit_log | INDEX (org_id, entity_type, entity_id, created_at) | Compliance queries |

### Slow Queries to Avoid

❌ BAD: `SELECT * FROM users WHERE email LIKE '%example.com%'` (full table scan)  
✅ GOOD: `SELECT * FROM users WHERE email = 'user@example.com'` (uses UNIQUE index)

❌ BAD: `SELECT * FROM subscriptions` (no org_id filter; returns 1M rows)  
✅ GOOD: `SELECT * FROM subscriptions WHERE org_id = ? AND deleted_at IS NULL` (uses index, fast)

### Monitoring

- Set up CloudWatch alerts for slow queries (> 1 second)
- Run `EXPLAIN ANALYZE` on all new queries in development
- Periodically rebuild indexes (weekly for high-activity tables)
```

### 8. Backup & Disaster Recovery

```markdown
## Backup & DR

- **RDS Automated Backups:** Daily, retained 35 days
- **Read Replicas:** Multi-AZ standby in different AWS region
- **RTO (Recovery Time Objective):** < 1 hour
- **RPO (Recovery Point Objective):** < 5 minutes (can lose up to 5 min of data)
- **Testing:** Restore from backup monthly to staging environment
```

### 9. Migration Strategy (from Old Schema)

```markdown
## Migration Plan

If migrating from old schema to new:

1. **Phase 1 — Preparation (Week 1):**
   - [ ] Create new schema in staging environment
   - [ ] Write migration scripts
   - [ ] Load copy of production data
   - [ ] Test migration scripts (≥ 3 times)

2. **Phase 2 — Dual-Write (Week 2-3):**
   - [ ] Deploy code that writes to BOTH old and new schema
   - [ ] Verify data consistency
   - [ ] Identify and fix discrepancies

3. **Phase 3 — Switchover (Week 4):**
   - [ ] Stop applications
   - [ ] Final sync of old → new schema
   - [ ] Verify data integrity
   - [ ] Redirect application to read from new schema
   - [ ] Monitor for 24 hours
   - [ ] Celebrate! 🎉

4. **Phase 4 — Cleanup (Week 5):**
   - [ ] Remove old schema (after 30-day safety period)
   - [ ] Remove dual-write code
   - [ ] Update documentation
```

### 10. Sign-Off

```markdown
- [ ] Data Architect: __________ Date: ______
- [ ] Backend Lead: __________ Date: ______
- [ ] DBA: __________ Date: ______
- [ ] Compliance: __________ Date: ______
```
```

---

## Schema Design Best Practices

1. **Normalize by default:** Only denormalize when you have proven performance issues
2. **Use surrogate keys:** UUID or auto-increment, not business keys (emails, usernames)
3. **Never use floats for money:** Always use integers (cents) or DECIMAL
4. **Soft-delete for compliance:** deleted_at timestamp instead of hard deletes
5. **Index for your queries:** Create indexes based on WHERE clauses, not all columns
6. **Use constraints:** NOT NULL, UNIQUE, CHECK, FK constraints catch data errors early
7. **Document everything:** Why this column? Why this index? Future you will thank present you
8. **Version your schema:** Keep a history of schema changes in version control
9. **Encrypt PII at rest:** Additional layer of security beyond DB encryption
10. **Test migrations:** Never deploy a migration without testing on production-like data

---

## References

- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Database Normalization](https://en.wikipedia.org/wiki/Database_normalization)
- [GDPR Compliance for Data Storage](https://gdpr-info.eu/)
- [ERD Diagram Tool](https://www.lucidchart.com/) — Visual schema design
