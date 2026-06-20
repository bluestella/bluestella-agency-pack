---
name: adr
description: Generates Architecture Decision Records (ADRs) documenting major technical decisions with context, options, decision rationale, and consequences. Follows the Markdown ADR format. WHEN: Documenting architecture decisions, choosing between technology options, recording trade-offs, keeping decision history for future teams, architectural retrospectives.
---

# ADR Skill — Architecture Decision Records

## Overview

An **Architecture Decision Record (ADR)** documents a significant architectural decision made by the team — including the context, options considered, the chosen option, and its consequences. ADRs create a decision history that helps current and future teams understand "why" a decision was made, not just "what" was decided.

## When to Use This Skill

- **Scenario 1:** Choose between two database technologies (PostgreSQL vs. DynamoDB)
- **Scenario 2:** Decide on authentication strategy (OAuth 2.0 vs. SAML vs. session-based)
- **Scenario 3:** Choose API style (REST vs. GraphQL)
- **Scenario 4:** Decide on deployment platform (Vercel vs. EC2 vs. ECS)
- **Scenario 5:** Record a reverse decision ("we're switching from X to Y and here's why")

## ADR Template (Markdown Format)

### Status Values

- **Proposed:** Decision proposed but not yet approved
- **Accepted:** Decision approved by tech lead and architecture team
- **Deprecated:** No longer used (but kept for history)
- **Superseded:** Replaced by a newer ADR

### Standard Format

```markdown
# ADR-[Number]: [Title]

**Status:** Accepted | Proposed | Deprecated | Superseded

**Date:** [YYYY-MM-DD]

**Author(s):** [Name(s)]

---

## Context

[Describe the issue or decision that needs to be made. What problem are we trying to solve? Why does this decision matter? Include any relevant background, timeline, business constraints, or technical limitations.]

**Key Constraints:**
- [Constraint 1 — e.g., must support 10,000 req/sec]
- [Constraint 2 — e.g., must fit in $5K/month budget]
- [Constraint 3 — e.g., must comply with GDPR]

---

## Decision

[State the decision clearly. Begin with "We have decided to [action] because [key reason]." This section should be 1-2 sentences.]

**Chosen Option:** [Name of option selected]

---

## Options Considered

### Option 1: [Option Name]

**Pros:**
- [Advantage 1]
- [Advantage 2]
- [Cost: $X/month]

**Cons:**
- [Disadvantage 1]
- [Disadvantage 2]
- [Hidden cost: Y]

**Effort:** [Implementation time estimate]

### Option 2: [Option Name]

[Repeat above]

### Option 3: [Option Name]

[Repeat above]

---

## Rationale

[Explain the reasoning behind the decision. Why is the chosen option better than the alternatives? What trade-offs were accepted? How does it align with business goals and technical constraints? Reference the constraints from the Context section.]

**Decision Matrix:**

| Criterion | Weight | Option 1 | Option 2 | Option 3 |
| --------- | ------ | -------- | -------- | -------- |
| [Criterion 1] | 30% | [Score/X] | [Score/X] | [Score/X] |
| [Criterion 2] | 25% | [Score/X] | [Score/X] | [Score/X] |
| [Criterion 3] | 20% | [Score/X] | [Score/X] | [Score/X] |
| **Total** | **100%** | **[Total]** | **[Total]** | **[Total]** |

---

## Consequences

### Positive

- [Benefit 1 — what becomes easier or better?]
- [Benefit 2]
- [Benefit 3]

### Negative

- [Risk 1 — what becomes harder or riskier?]
- [Risk 2 — lock-in, vendor dependency, learning curve]
- [Risk 3 — hidden costs or maintenance burden]

### Neutral

- [Trade-off 1 — we gain X but lose Y]

---

## Implementation Plan

- [ ] **Phase 1:** [Milestone 1, e.g., "Prototype decision"]
- [ ] **Phase 2:** [Milestone 2, e.g., "Integrate into dev environment"]
- [ ] **Phase 3:** [Milestone 3, e.g., "Deploy to production"]

**Timeline:** [Start date] to [End date]  
**Owner:** [Team/person responsible]  
**Blockers:** [Any dependencies or risks that could delay?]

---

## Related ADRs

- [ADR-001: Initial tech stack](./adr-001-tech-stack.md) — Context for this decision
- [ADR-010: Authentication strategy](./adr-010-auth-strategy.md) — Related decision

---

## Sign-Off

- [ ] Solution Architect: __________ Date: ______
- [ ] Tech Lead: __________ Date: ______
- [ ] Security Architect (if security-related): __________ Date: ______

---

## Notes

[Any additional context, open questions, or follow-up work needed?]

```

---

## Example ADR: PostgreSQL vs. DynamoDB

```markdown
# ADR-003: Database Choice — PostgreSQL vs. DynamoDB

**Status:** Accepted

**Date:** 2026-06-20

**Author:** Bob Smith (Data Architect)

---

## Context

Our SaaS application requires a scalable, cost-effective database solution. Expected growth: 1M users within 2 years, with peak queries of 5,000 req/sec. Must support complex queries (joins, aggregations) for reporting. GDPR compliance required (data residency, right to erasure).

**Key Constraints:**
- Max database cost: $10K/month
- Must support ACID transactions for financial operations
- Must support both operational queries (OLTP) and analytical queries (OLAP)
- GDPR compliance mandatory (EU data residency)

---

## Decision

We have decided to use **PostgreSQL 16** as our primary database because it meets all constraints (cost, performance, compliance) and gives us flexibility for future schema changes without vendor lock-in.

**Chosen Option:** PostgreSQL 16 (RDS Multi-AZ) with read replicas for analytics

---

## Options Considered

### Option 1: PostgreSQL 16 (RDS Multi-AZ)

**Pros:**
- ACID compliance for financial operations
- Complex queries supported (JOINs, aggregations, CTEs)
- GDPR-compliant (can self-manage data residency)
- Cost: ~$5K/month for expected scale (Multi-AZ + read replicas)
- Mature ecosystem, extensive tooling (Drizzle ORM, migrations)
- No vendor lock-in (can migrate if needed)

**Cons:**
- Manual scaling (requires monitoring and intervention)
- Operational overhead (backups, patching, monitoring)
- Less suitable for unstructured data

**Effort:** 2 weeks (schema design, migration tooling)

### Option 2: DynamoDB

**Pros:**
- Serverless scaling (auto-scale to any throughput)
- Low operational overhead
- Cost: ~$3K/month for expected scale
- Built-in backups and disaster recovery

**Cons:**
- Limited query flexibility (no JOINs, complex aggregations hard)
- Eventual consistency model (risky for financial operations)
- GDPR compliance harder (Dynamo export/delete is slow)
- Vendor lock-in (migrating away is expensive)
- Learning curve (different model than relational databases)

**Effort:** 4 weeks (redesign queries, implement eventual consistency patterns)

### Option 3: Aurora PostgreSQL (managed)

**Pros:**
- Managed PostgreSQL (AWS handles scaling)
- Automatic failover and backups
- Cost: ~$7K/month

**Cons:**
- Higher cost than self-managed RDS
- Still some operational overhead
- Vendor lock-in (AWS-specific features)

**Effort:** 1 week (lower overhead than self-managed)

---

## Rationale

We chose PostgreSQL over DynamoDB because:

1. **Complex Queries:** Our reporting requirements (monthly sales summaries, customer lifetime value calculations) need JOINs and aggregations that are awkward in DynamoDB.

2. **ACID Compliance:** Financial transactions must be ACID-compliant. DynamoDB's eventual consistency introduces risk.

3. **GDPR Compliance:** GDPR right-to-erasure is easier with PostgreSQL (single DELETE query). DynamoDB requires complex TTL and export workflows.

4. **Cost:** PostgreSQL + RDS Multi-AZ + read replicas = ~$5K/month, which fits our budget and is comparable to DynamoDB at expected scale.

5. **No Lock-in:** PostgreSQL can be migrated to any cloud or on-premises if needed. DynamoDB is AWS-specific.

6. **Flexibility:** Schema can be updated without major re-architecting. DynamoDB requires careful planning of access patterns upfront.

**Decision Matrix:**

| Criterion | Weight | PostgreSQL | DynamoDB | Aurora |
| --------- | ------ | ---------- | -------- | ------ |
| Query Flexibility | 30% | 10/10 | 3/10 | 10/10 |
| ACID Compliance | 25% | 10/10 | 2/10 | 10/10 |
| GDPR Compliance | 20% | 9/10 | 4/10 | 9/10 |
| Cost | 15% | 9/10 | 10/10 | 6/10 |
| No Vendor Lock-in | 10% | 10/10 | 1/10 | 3/10 |
| **Total (weighted)** | **100%** | **9.35/10** | **3.4/10** | **8.65/10** |

---

## Consequences

### Positive

- Strong ACID guarantees for financial data
- Flexible querying for reporting and analytics
- GDPR compliant with easy data erasure
- Cost-effective scaling
- Mature tooling and community support

### Negative

- Operational overhead: we must manage upgrades, backups, monitoring
- Manual scaling: must monitor and adjust capacity
- Less suitable for unstructured/time-series data (would need separate solution like DynamoDB or TimescaleDB)

---

## Implementation Plan

- [ ] **Phase 1 (Week 1-2):** Design schema, set up RDS Multi-AZ, configure backups and monitoring
- [ ] **Phase 2 (Week 3-4):** Migrate existing data from prototype database, set up read replicas
- [ ] **Phase 3 (Week 5-6):** Deploy to staging, run load tests (5K req/sec), verify GDPR compliance
- [ ] **Phase 4 (Week 7):** Deploy to production, monitor performance

**Timeline:** 2026-06-20 to 2026-08-15  
**Owner:** Data Architect + DevOps  
**Blockers:** RDS provisioning time (~2 hours)

---

## Related ADRs

- [ADR-001: Tech Stack Overview](./adr-001.md) — Initial tech choices
- [ADR-005: Backup & Disaster Recovery Strategy](./adr-005.md) — How we'll back up PostgreSQL
- [ADR-008: Caching Layer (Redis)](./adr-008.md) — Complementary to PostgreSQL

---

## Sign-Off

- [ ] Solution Architect: Bob Smith ✅ 2026-06-20
- [ ] Tech Lead: Alice Chen ✅ 2026-06-20
- [ ] Security Architect: Carol Davis ✅ 2026-06-20

---

## Notes

- Revisit this decision in 12 months when we reach 500K users and can reassess cost/performance
- May need TimescaleDB or ClickHouse for time-series data if analytics volume grows beyond PostgreSQL's comfort zone
- Consider read replicas in different regions for geo-redundancy as we expand internationally
```

---

## Best Practices for ADRs

1. **Write it before or shortly after the decision:** Not months later when memory fades
2. **Include rejected options:** Explain why alternatives were rejected; future teams will ask the same questions
3. **Be honest about trade-offs:** "We chose X but lost Y capability"
4. **Keep it short:** 1-2 pages, not a novel
5. **Use a decision matrix:** Quantify trade-offs when possible
6. **Date everything:** When was this decided? When was it superseded?
7. **Link to related ADRs:** Show decision dependencies
8. **Get sign-off:** Tech lead + relevant architects should agree

---

## ADR Naming Convention

- Store in `docs/adr/` directory
- Name files: `adr-NNN-short-title.md` (e.g., `adr-003-database-choice.md`)
- Number sequentially (ADR-001, ADR-002, ADR-003, ...)
- Keep a master `docs/adr/README.md` listing all ADRs and their status

---

## References

- [ADR GitHub Repository](https://adr.github.io/) — Original ADR format
- [Amazon's Tenets Decision Process](https://aws.amazon.com/blogs/architecture/) — Enterprise decision-making
- [Architecture Decision Records (Joel Spolsky)](https://www.joelonsoftware.com/) — Context and history
