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
**Path:** /api/v1/[endpoint]
**Authentication:** Bearer token (JWT)

**Request Schema:**
```json
{
  "field1": "string (required)",
  "field2": "number"
}
```

**Response Schema (200 OK):**
```json
{
  "status": "accepted",
  "id": "string"
}
```

**Error Responses:**
- 400 Bad Request: Invalid data
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
| [System A] | [Mapping/transform] | [System B] | Eventual consistency (publish event) |

---

## Monitoring & Alerting

| Metric | Threshold | Action |
| ------ | --------- | ------ |
| API response time p95 | > 1s | Alert |
| Error rate | > 5% | Alert |
| Processing latency | > 5 minutes | Alert + manual review |

---

## References & Attachments
- [OpenAPI spec (.yaml)](#)
- [Data flow diagram](#)
- [Performance baselines](#)
