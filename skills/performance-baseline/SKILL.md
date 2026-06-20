---
name: performance-baseline
description: >
  Records and tracks performance baselines after each release: Core Web Vitals (LCP, INP, CLS),
  API latency (p95, p99), k6 load test results, and regression comparison against the previous
  release. Use after each release to capture baselines in docs/performance-baselines.md, or when
  investigating a performance regression.
instructions:
  - testing
agents:
  - performance-testing-engineer
  - devops-engineer
  - seo-engineer
triggers:
  - performance-sla-breach
metadata:
  author: bluestella
  version: "1.0"
---

# Performance Baseline

## Overview

This skill produces a performance baseline record for a release. It captures front-end Core Web Vitals, back-end API latency, load test results, and a regression comparison versus the prior release.

## Steps

1. **Capture Core Web Vitals.** Run Lighthouse CI on key pages. Record LCP, INP, CLS.
2. **Capture API latency.** Run k6 or Playwright API tests. Record p95 and p99 per endpoint.
3. **Run load tests.** Execute k6 baseline, stress, and spike scenarios. Record throughput and error rate.
4. **Compare to previous release.** For each key metric, compute delta and flag regressions (> 10% degradation = ⚠️; > 25% = ❌).
5. **Save to `docs/performance-baselines.md`.** Append the new release block.

## Output Format

A markdown block appended to `docs/performance-baselines.md`, following [`templates/performance-baseline-template.md`](templates/performance-baseline-template.md).

## References

See [`references/REFERENCE.md`](references/REFERENCE.md) for metric thresholds and tooling links.
