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

**[Pipeline Name] Pipeline:**
1. [Source] → [Ingestion service]
2. [Service] processes → [Table] in [Database]
3. ETL job transforms → [Analytics warehouse]
4. [BI tool] queries → dashboards

---

## Compliance Mapping

| Regulation | Requirement | Technical Control |
| ---------- | ----------- | ----------------- |
| GDPR | Data retention limit | Automated purge job after 2 years |
| GDPR | Right to deletion | Soft-delete flag; restore from backup within 30 days |
| CCPA | Data minimization | Only collect required fields |

---

## Backup & DR

**RTO:** [e.g., 4 hours]
**RPO:** [e.g., 1 hour]

**Backup Schedule:**
- Daily incremental backups (retained 7 days)
- Weekly full backups (retained 4 weeks)
- Monthly backups (retained 1 year)

**Restore Testing:** [Frequency and environment]

---

## References & Attachments
- [Full ERD in Lucidchart](#)
- [Compliance checklist](#)
- [Performance benchmarks](#)
