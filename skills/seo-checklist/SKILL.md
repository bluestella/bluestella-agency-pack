---
name: seo-checklist
description: >
  Produces a structured SEO Pre-Launch Checklist covering Core Web Vitals, structured data,
  sitemap, robots.txt, canonical tags, redirects, internal linking, meta tags, and Lighthouse
  sign-off. Use before launching a new page, feature, or release to verify all SEO requirements
  are met.
instructions: []
agents:
  - seo-engineer
triggers: []
metadata:
  author: bluestella
  version: "1.0"
---

# SEO Checklist

## Overview

This skill produces a pre-launch SEO checklist that verifies technical SEO, content, and linking requirements before a page or release goes live.

## Steps

1. **Verify Core Web Vitals.** Run Lighthouse or PageSpeed Insights. All key pages must score "Good" (LCP ≤ 2.5s, INP ≤ 200ms, CLS ≤ 0.1).
2. **Validate structured data.** Use Google's Rich Results Test to confirm schema.org markup is error-free.
3. **Check crawlability.** Verify `sitemap.xml` is submitted to GSC and `robots.txt` allows crawling of indexable paths.
4. **Audit canonical and redirect setup.** Confirm canonical tags are correct and all moved/deleted pages have 301 redirects.
5. **Review content metadata.** Check page titles (50–60 chars), meta descriptions (150–160 chars), H1 uniqueness, and image alt text.
6. **Sign off.** Lighthouse SEO score ≥ 90; no critical crawl errors in GSC.

## Output Format

A filled checklist following [`templates/seo-checklist-template.md`](templates/seo-checklist-template.md).

## References

See [`references/REFERENCE.md`](references/REFERENCE.md) for SEO tooling and best practice links.
