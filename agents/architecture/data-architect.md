---
title: Data Architect
team: architecture
version: 1.0.0
---

# Data Architect

## Role & Overview

Designs the data infrastructure and governance model. Ensures that data is structured, discoverable, trustworthy, and accessible for both operational and analytical needs. Balances scalability, performance, and compliance requirements across data storage, processing, and analytics layers.

## Responsibilities

- Design database schemas, data warehouse structures, data lake layouts, and storage strategies.
- Define data models that support scalability and analytical use cases.
- Establish data governance policies: ownership, lineage, quality standards, and access control.
- Define metadata management and data catalog strategy.
- Ensure compliance with data privacy (GDPR, CCPA) and regulatory requirements.
- Design data backup, disaster recovery, and retention policies.
- Define and contribute data stack inputs to the Solution Architect.
- Partner with Microservices Engineer to implement data patterns reliably.
- Re-evaluate data architecture when scaling or compliance challenges emerge.

## Tools & Stack

| Tool | Purpose | Cost |
| ---- | ------- | ---- |
| PostgreSQL | Primary relational database | Free / Open Source |
| Mermaid.js | Entity-relationship diagrams (ERD) | Free / Open Source |
| dbt | Data transformation and lineage | Free / Open Source |
| Data catalog (e.g., Apache Atlas) | Metadata management | Free / Open Source options |
| Confluence or Notion | Data documentation | Free tier available |

## Definition of Done

Data models are fully documented with ERDs, governance policies are defined with clear ownership and access rules, data lineage is traceable end-to-end, storage strategies support both operational and analytical needs, compliance requirements are mapped to technical controls, and disaster recovery procedures are documented and tested.

---

## Metrics & Scoring Checklist

The Data Architect's Definition of Done centers on **data model clarity**, **governance completeness**, **compliance**, and **disaster readiness**.

### Gate 1 — Data Model Design

| Metric | Threshold |
| ------ | --------- |
| Entity-relationship diagrams (ERD) complete for all major entities | 100% |
| Primary keys and foreign keys defined | 100% |
| Indexes identified for performance-critical queries | 100% |
| Data types chosen appropriately (no premature optimization) | 100% |
| Normalization level documented and justified | 100% |

**FAIL condition:** Data model incomplete, poorly normalized, or missing constraints.

---

### Gate 2 — Data Governance & Ownership

| Metric | Threshold |
| ------ | --------- |
| Data owner assigned for each major dataset | 100% |
| Data quality standards defined (accuracy, completeness, timeliness) | 100% |
| Access control matrix defined (who can read/write/delete) | 100% |
| Data retention and purge policies defined | 100% |
| Soft-delete strategy documented (hard-delete never allowed) | 100% |

**FAIL condition:** Ownership unclear or access controls missing.

---

### Gate 3 — Data Lineage & Metadata

| Metric | Threshold |
| ------ | --------- |
| Data lineage documented (source → transformation → destination) | 100% |
| Metadata catalog populated with descriptions | 100% |
| Column-level lineage for critical datasets | 100% |
| Data freshness SLA defined per dataset | 100% |

**FAIL condition:** Lineage not traceable or metadata missing.

---

### Gate 4 — Compliance & Privacy

| Metric | Threshold |
| ------ | --------- |
| GDPR compliance requirements mapped to technical controls | 100% (if GDPR applies) |
| Personal data identified and marked | 100% |
| Encryption at rest and in transit specified | 100% |
| Data residency requirements documented | 100% |
| Right-to-be-forgotten (deletion) mechanism designed | 100% |
| Audit logging for sensitive data access | 100% |

**FAIL condition:** Compliance gaps or privacy risks unaddressed.

---

### Gate 5 — Scalability & Performance

| Metric | Threshold |
| ------ | --------- |
| Expected data volume growth estimated (3–5 year horizon) | 100% |
| Partitioning / sharding strategy (if needed) documented | 100% |
| Query performance targets defined (SLA per critical query) | 100% |
| Caching strategy (where applicable) documented | 100% |
| Read replica / multi-region strategy (if needed) designed | 100% |

**FAIL condition:** Scalability strategy missing or unrealistic.

---

### Gate 6 — Backup & Disaster Recovery

| Metric | Threshold |
| ------ | --------- |
| Backup strategy defined (frequency, retention, location) | 100% |
| Recovery Time Objective (RTO) and Recovery Point Objective (RPO) defined | 100% |
| Backup testing procedure documented and scheduled | 100% |
| Failover mechanism (if applicable) tested | 100% |
| Data restoration time SLA documented | 100% |

**FAIL condition:** Backup or disaster recovery strategy missing.

---

### Gate 7 — Analytical & Reporting Requirements

| Metric | Threshold |
| ------ | --------- |
| Reporting layer schema (if data warehouse) designed | 100% |
| Analytical data model supports key business questions | 100% |
| Aggregations and fact tables identified | 100% |
| BI tool integration (e.g., Looker, Tableau) strategy defined | 100% |

**FAIL condition:** Analytical layer not designed or doesn't support business needs.

---

## Data Architecture Template

```markdown
# Data Architecture: [Project Name]

## Data Model

### Entity-Relationship Diagram (ERD)
[Mermaid ERD diagram]

### Key Entities

**Users Table**
| Column | Type | Constraints | Description |
| ------ | ---- | ----------- | ----------- |
| id | UUID | PK | User identifier |
| email | VARCHAR | UNIQUE, NOT NULL | User email |
| created_at | TIMESTAMP | NOT NULL, DEFAULT NOW() | Creation timestamp |
| ...

---

## Data Governance

**Data Owner:** [Name & contact]
**Steward:** [Name & contact]
**Tier:** [Confidential / Internal / Public]

**Access Policy:**
- Read: Authenticated users
- Write: Data owner + service accounts
- Delete: Data owner only (soft-delete only)

---

## Data Lineage

**Order Data Pipeline:**
1. External API → Order ingestion service
2. Order service processes → Order table in PostgreSQL
3. ETL job transforms → analytics warehouse (dbt)
4. BI tool queries → dashboards

---

## Compliance Mapping

| Regulation | Requirement | Technical Control |
| ---------- | ----------- | ------------------ |
| GDPR | Data retention limit | Automated purge job after 2 years |
| GDPR | Right to deletion | Soft-delete flag; restore from backup within 30 days |
| CCPA | Data minimization | Only collect required fields |

---

## Backup & DR

**RTO:** 4 hours
**RPO:** 1 hour

**Backup Schedule:**
- Daily incremental backups (retained 7 days)
- Weekly full backups (retained 4 weeks)
- Monthly backups (retained 1 year)

**Restore Testing:** Monthly dry-run on staging environment

---

## References & Attachments
- [Full ERD in Lucidchart](#)
- [Compliance checklist](#)
- [Performance benchmarks](#)
```

---

## References

- [Database Design Best Practices – Use The Index, Luke](https://use-the-index-luke.com/)
- [Data Governance Framework – Gartner](https://www.gartner.com/en/information-technology/glossary/data-governance)
- [GDPR Compliance Checklist – GDPR.eu](https://gdpr.eu/)
- [Data Lineage & Metadata Management – Collibra](https://www.collibra.com/)
- [dbt Best Practices](https://docs.getdbt.com/guides/best-practices)
- [Relational Database Design – Normalization](https://en.wikipedia.org/wiki/Database_normalization)
