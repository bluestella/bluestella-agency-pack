---
title: Hook — Performance Bottleneck to Developer/Architect
description: Trigger for when Performance Testing Engineer finds SLA breaches or bottlenecks
---

# Hook: Performance Bottleneck → Developer/Architect

## Trigger Condition

**Source Agent:** Performance Testing Engineer  
**Destination Agents:** Developer (for code-level optimization) or Architecture Team (for infrastructure changes)  
**Event:** Performance test or monitoring detects SLA breach

**Detection:**

- Load test: response time exceeds SLA (p95 > 500ms or p99 > 1s)
- Stress test: system degrades ungracefully (error rate > 1%)
- Core Web Vitals: Lighthouse metrics exceed thresholds (LCP > 2.5s, INP > 200ms, CLS > 0.1)
- Production monitoring: latency spike or throughput drop
- Soak test: memory leak detected after 30 minutes

**Severity:**

- 🔴 Critical: Blocks feature launch or user sign-ups affected
- 🟠 High: Impacts user experience, SLA breached
- 🟡 Medium: Approaching SLA limits, needs optimization
- 🔵 Low: Minor inefficiency, optimization opportunity

---

## Trigger Payload

```json
{
  "event": "performance_bottleneck",
  "severity": "Critical|High|Medium|Low",
  "metric": "response_time|throughput|memory|cpu|core_web_vital",
  "component": "ComponentName",
  "baseline": "500ms p95",
  "current": "2500ms p95",
  "sla_threshold": "500ms p95",
  "sla_breach": true,
  "test_type": "load|stress|soak|cwv|production_monitoring",
  "findings": {
    "bottleneck": "Database query N+1 problem / Single-threaded bottleneck / Network latency",
    "affected_endpoint": "/api/v1/search",
    "query_count": 150,
    "duration": "2500ms total, 1500ms in DB"
  },
  "recommendation": "Add database index / Implement caching / Scale horizontally",
  "destination": "developer|architect",
  "assigned_to": "Name",
  "created_at": "ISO 8601 timestamp"
}
```

---

## Required Action

### If Destination = Developer (code-level optimization)

1. Performance Engineer creates GitHub issue labeled `perf:critical`, `perf:high`, etc.
2. Issue includes:
   - Baseline vs. current metrics
   - Test results (k6 script output, Lighthouse report, profiler trace)
   - Bottleneck analysis and recommendations
   - Instructions to reproduce (load test command, endpoint, parameters)
3. Issue is assigned to responsible engineer
4. Issue is prioritized as P0/P1 work

**Developer Actions:**

- Profile the code (use profiling tools: Node.js profiler, Chrome DevTools, etc.)
- Identify root cause
- Implement fix (optimize query, add caching, reduce payload, etc.)
- Run performance test to verify fix meets SLA

### If Destination = Architect (infrastructure change)

1. Performance Engineer escalates to Solution Architect or specific domain architect
2. Options may include:
   - Horizontal scaling (add more instances, load balancer)
   - Vertical scaling (larger machine)
   - Infrastructure upgrade (CDN, edge caching, WAF)
   - Data model optimization (add indices, denormalization, sharding)
3. Architect updates the target-state architecture
4. Flows back to Business Analyst to create requirement epic if needed

---

## Resolution Criteria

- [ ] Code optimized and profiler confirms improvement
- [ ] Load test re-run shows metrics now meet SLA
- [ ] p95 ≤ 500ms, p99 ≤ 1s, error rate < 1%
- [ ] Core Web Vitals: LCP ≤ 2.5s, INP ≤ 200ms, CLS ≤ 0.1
- [ ] No regression in other metrics (memory, CPU, throughput)
- [ ] Baseline documentation updated
- [ ] Monitoring/alerting updated to catch future regressions

---

## Escalation Path

- **High SLA breach unfixed >48 hours:** Escalate to Tech Lead → Product Manager
- **Requires architectural change:** Escalate to Solution Architect
- **Systemic issue (repeated bottlenecks):** Escalate to Tech Lead for review of design patterns

---

## Automation

- Trigger: k6 load test / Lighthouse CI / production monitoring alert
- Action: Create GitHub issue + assign + label
- Notification: Slack alert to performance team + developer
- Dashboard: Performance dashboard updated with breach status
- Timeout: Auto-escalate if unresolved for 48 hours (high) or 1 week (medium)
