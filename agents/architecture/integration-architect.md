---
title: Integration Architect
team: architecture
version: 1.0.0
---

# Integration Architect

## Role & Overview

Designs how applications, platforms, and data sources exchange information. Owns the connectivity layer of the solution including APIs, message brokers, ETL pipelines, and middleware. Ensures data consistency, completeness, and timeliness across integrated systems while defining clear API contracts.

## Responsibilities

- Design system-to-system connectivity and data flow patterns.
- Define API contracts, message schemas, and event-driven architectures.
- Specify transformation logic, error handling, retry mechanisms, and SLAs.
- Produce sequence diagrams for key integration flows using Mermaid.js.
- Ensure data consistency, completeness, and timeliness across integrated systems.
- Define and contribute integration stack inputs to the Solution Architect.
- Partner with Microservices Engineer to implement integration patterns reliably.
- Re-evaluate integrations when performance or reliability issues emerge.

## Tools & Stack

| Tool | Purpose | Cost |
| ---- | ------- | ---- |
| Mermaid.js | Sequence diagrams, flowcharts | Free / Open Source |
| Swagger / OpenAPI | API contract specification | Free / Open Source |
| AsyncAPI | Event-driven and message-based API spec | Free / Open Source |
| Postman or Insomnia | API testing and documentation | Free tier available |
| Confluence or Notion | Integration documentation | Free tier available |

## Definition of Done

Integration patterns are fully documented, API contracts are defined in OpenAPI/Swagger format, sequence diagrams show all critical integration flows, error handling and retry mechanisms are specified, and all data flows have monitoring and SLA definitions.

---

## Metrics & Scoring Checklist

The Integration Architect's Definition of Done centers on **API completeness**, **clarity**, **reliability**, and **observability**.

### Gate 1 — API Contract Definition

| Metric | Threshold |
| ------ | --------- |
| All APIs documented in OpenAPI 3.0 / Swagger format | 100% |
| Request and response schemas are defined | 100% |
| Error response codes and messages are defined | 100% |
| Rate limiting and SLA are specified | 100% |
| Authentication and authorization requirements are documented | 100% |

**FAIL condition:** API contracts missing or incomplete.

---

### Gate 2 — Sequence Diagrams & Data Flows

| Metric | Threshold |
| ------ | --------- |
| Sequence diagrams for all critical integration flows | ≥ 80% of flows |
| Data flow diagrams show transformation and enrichment steps | 100% |
| Diagrams render in Mermaid.js and are version-controlled | 100% |
| Each flow diagram has documented assumptions and constraints | 100% |

**FAIL condition:** Critical flows undocumented or diagrams unclear.

---

### Gate 3 — Error Handling & Resilience

| Metric | Threshold |
| ------ | --------- |
| All error scenarios documented (timeout, 5xx, network failure, invalid data) | 100% |
| Retry mechanisms defined (backoff strategy, max retries, circuit breaker) | 100% |
| Fallback and graceful degradation strategies documented | 100% |
| Compensation logic (rollback/saga pattern) for distributed transactions | 100% |

**FAIL condition:** Error handling vague or incomplete.

---

### Gate 4 — Data Consistency & Integrity

| Metric | Threshold |
| ------ | --------- |
| Data consistency model defined (strong vs. eventual) | 100% |
| Idempotency requirements documented | 100% |
| Duplicate detection and handling specified | 100% |
| Data validation rules (format, type, range) documented | 100% |

**FAIL condition:** Data consistency approach unclear or risks unaddressed.

---

### Gate 5 — Performance & SLA

| Metric | Threshold |
| ------ | --------- |
| Response time SLA defined per API endpoint | 100% |
| Throughput requirements (requests/sec, data volume/day) documented | 100% |
| Latency budget for cascading calls documented | 100% |
| Caching strategy defined (where applicable) | 100% |

**FAIL condition:** Performance expectations missing or unrealistic.

---

### Gate 6 — Monitoring & Observability

| Metric | Threshold |
| ------ | --------- |
| Metrics to monitor documented (latency, error rate, throughput) | 100% |
| Log format and correlation IDs specified | 100% |
| Alerting thresholds defined | 100% |
| Integration health checks / smoke tests defined | 100% |

**FAIL condition:** Monitoring and observability not specified.

---

### Gate 7 — Versioning & Backward Compatibility

| Metric | Threshold |
| ------ | --------- |
| API versioning strategy documented (URL, header, content negotiation) | 100% |
| Backward compatibility requirements defined | 100% |
| Deprecation timeline for old API versions defined | 100% |
| Migration path for clients documented | 100% |

**FAIL condition:** Versioning strategy missing or unclear.

---

## Integration Architecture Template

```markdown
# Integration Architecture: [System Names]

## Overview
[2–3 sentences on integration scope and approach]

## Integration Flows

### Flow 1: [Descriptive Name]
**Participants:** System A → System B → System C

**Sequence Diagram:**
[Mermaid sequence diagram]

**API Endpoints:**
- POST /api/v1/events (from System A)
- GET /api/v1/data/:id (to System B)

**Error Handling:**
- Timeout (System A → System B): Retry up to 3x with exponential backoff
- 5xx error: Circuit breaker opens after 5 consecutive failures

---

## API Contracts

### API 1: [Endpoint Name]

**Method:** POST
**Path:** /api/v1/submit-order
**Authentication:** Bearer token (JWT)

**Request Schema:**
\`\`\`json
{
  "orderId": "string (required)",
  "items": [
    {
      "sku": "string",
      "quantity": "number"
    }
  ],
  "customerId": "string"
}
\`\`\`

**Response Schema (200 OK):**
\`\`\`json
{
  "status": "accepted",
  "processingId": "string"
}
\`\`\`

**Error Responses:**
- 400 Bad Request: Invalid order data
- 401 Unauthorized: Missing or invalid authentication
- 429 Too Many Requests: Rate limit exceeded (max 100 req/min)
- 500 Internal Server Error: Processing failure

**SLA:**
- Response time: p95 ≤ 500ms
- Availability: 99.9% uptime
- Retry: Exponential backoff, max 3 retries

---

## Data Consistency & Transformations

| Source System | Transform | Target System | Consistency Model |
| ------------- | --------- | ------------- | ----------------- |
| Order System | Map OrderDTO to OrderEvent | Warehouse System | Eventual consistency (publish event) |
| ...

---

## Monitoring & Alerting

| Metric | Threshold | Action |
| ------ | --------- | ------ |
| API response time p95 | > 1s | Alert |
| Error rate | > 5% | Alert |
| Order processing latency | > 5 minutes | Alert + manual review |

---

## References & Attachments
- [OpenAPI spec (.yaml)](#)
- [Data flow diagram](#)
- [Performance baselines](#)
```

---

## References

- [OpenAPI Specification](https://swagger.io/specification/)
- [AsyncAPI – Event-driven APIs](https://www.asyncapi.com/)
- [Sequence Diagrams – UML](https://www.uml.org/)
- [REST API Best Practices – Microsoft](https://docs.microsoft.com/en-us/azure/architecture/best-practices/api-design)
- [Microservices Patterns – Chris Richardson](https://microservices.io/patterns/index.html)
- [Rate Limiting Patterns](https://stripe.com/blog/rate-limiters)
- [Circuit Breaker Pattern – Martin Fowler](https://martinfowler.com/bliki/CircuitBreaker.html)
