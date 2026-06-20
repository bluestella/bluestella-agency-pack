---
name: integration-architecture
description: >
  Produces structured Integration Architecture documents covering integration flows, sequence diagrams,
  API contracts (request/response schemas, SLAs, error handling), data consistency models, and monitoring
  strategy. Use when designing integrations between services, defining API contracts, mapping event flows,
  or documenting inter-system dependencies.
instructions:
  - api-patterns
agents:
  - integration-architect
triggers: []
metadata:
  author: bluestella
  version: "1.0"
---

# Integration Architecture

## Overview

This skill produces a structured Integration Architecture document for any set of systems that need to communicate. It covers integration flows, API contracts, consistency models, and observability.

## Steps

1. **Map integration flows.** For each flow, identify participants, draw a sequence diagram (Mermaid), list API endpoints, and define error handling (retries, circuit breakers).
2. **Define API contracts.** For each endpoint: method, path, auth, request/response schema (JSON), error responses, and SLA (latency + availability).
3. **Define data consistency model.** For each source→target pair, specify the transform and consistency model (synchronous, eventual, saga).
4. **Set up monitoring & alerting.** Define metrics, thresholds, and actions for response time, error rate, and processing latency.

## Output Format

A single markdown document following the structure in [`templates/integration-architecture-template.md`](templates/integration-architecture-template.md).

## References

See [`references/REFERENCE.md`](references/REFERENCE.md) for API design and integration pattern resources.
