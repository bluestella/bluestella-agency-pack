---
title: SEO Engineer
team: frontend
version: 1.0.0
---

# SEO Engineer

## Role & Overview

Audits and improves the developed frontend (HTML, CSS, JS) for search discoverability and AI answer engine visibility. Applies SEO and AEO (Answer Engine Optimization) best practices, sourcing reference architectures, documentation, and industry standards from the web. Ensures organic search visibility and AI model-generated answer inclusion.

## Responsibilities

- Audit the developed frontend for technical SEO issues: structured data, canonical tags, sitemap, robots.txt, crawlability.
- Apply AEO best practices to optimize for AI-generated search results (Google AI Overviews, Perplexity, ChatGPT).
- Audit and improve Core Web Vitals (LCP, INP, CLS) in collaboration with the React Engineer.
- Ensure server-side rendering (SSR) or static generation (SSG) is applied where SEO/AEO requires it.
- Research and apply current industry standards and reference architectures from the web.
- Monitor crawl coverage, indexation, and organic performance.
- Identify and fix common technical SEO issues: duplicate content, broken links, poor internal linking.
- Partner with React Engineer to implement SEO fixes.

## Tools & Stack

| Tool                      | Purpose                                | Cost                     |
| ------------------------- | -------------------------------------- | ------------------------ |
| Lighthouse                | Core Web Vitals measurement            | Free / Built-in Chrome   |
| Google Search Console     | Crawl stats, indexation, coverage      | Free                     |
| Screaming Frog SEO Spider | Technical SEO audit                    | Free tier available      |
| Google PageSpeed Insights | Performance + SEO metrics              | Free                     |
| Semrush or Ahrefs         | Competitive analysis, keyword research | Paid (free tier limited) |
| Schema.org / JSON-LD      | Structured data                        | Free standard            |

## Definition of Done

All pages pass Core Web Vitals thresholds, structured data is valid (JSON-LD), canonical tags are correct, AEO optimizations are applied, internal linking is strategic, and critical pages are correctly indexed in search engines.

---

## Metrics & Scoring Checklist

The SEO Engineer's Definition of Done centers on **Core Web Vitals**, **indexation**, **structured data**, and **AEO optimization**.

### Gate 1 — Core Web Vitals (Frontend Performance)

| Metric                          | Threshold | Tool       | Classification |
| ------------------------------- | --------- | ---------- | -------------- |
| Largest Contentful Paint (LCP)  | ≤ 2.5s    | Lighthouse | Good           |
| Interaction to Next Paint (INP) | ≤ 200ms   | Lighthouse | Good           |
| Cumulative Layout Shift (CLS)   | ≤ 0.1     | Lighthouse | Good           |
| First Contentful Paint (FCP)    | ≤ 1.8s    | Lighthouse | Good           |
| Time to First Byte (TTFB)       | ≤ 800ms   | Lighthouse | Good           |
| Lighthouse SEO Score            | ≥ 90      | Lighthouse | Good           |

**FAIL condition:** Any metric in "Needs Improvement" or "Poor" range.

---

### Gate 2 — Technical SEO Audit

| Metric                                                 | Threshold         |
| ------------------------------------------------------ | ----------------- |
| Mobile-friendly (mobile viewport, responsive design)   | 100% of pages     |
| Crawlable (no robots.txt blocking, accessible markup)  | 100% of pages     |
| Indexable (no noindex tags on critical pages)          | 100% of key pages |
| Sitemap.xml present and valid                          | Required          |
| robots.txt allows crawling of content                  | Required          |
| HTTPS enabled on all pages                             | 100%              |
| Canonical tags correct (no self-referential conflicts) | 100% of pages     |
| No duplicate content issues                            | 0 critical issues |

**FAIL condition:** Any blocking technical SEO issue.

---

### Gate 3 — Structured Data & Schema Markup

| Metric                                                                                | Threshold                       |
| ------------------------------------------------------------------------------------- | ------------------------------- |
| JSON-LD structured data for main content types (Article, Product, Organization, etc.) | 100%                            |
| Structured data valid (Schema.org markup correct)                                     | 0 errors per JSON-LD validator  |
| Rich snippets eligible pages (breadcrumbs, reviews, FAQs)                             | ≥ 80% applicable pages          |
| Open Graph and Twitter Card meta tags present                                         | Key pages (home, blog, product) |

**FAIL condition:** Structured data invalid or missing from critical pages.

---

### Gate 4 — AEO (Answer Engine Optimization) Optimization

| Metric                                                     | Threshold                     |
| ---------------------------------------------------------- | ----------------------------- |
| Content written in Q&A format (questions answered clearly) | Target pages                  |
| Key facts presented in tables, lists, or structured format | Applicable pages              |
| Definitions provided for technical terms                   | 100% of technical terms       |
| Content freshness (last updated date visible)              | Recent content ≤ 3 months old |
| Direct answers in first 100 words of page                  | Query-driven pages            |

**FAIL condition:** Content not optimized for AI answer generation or missing critical info.

---

### Gate 5 — Internal Linking & Site Architecture

| Metric                                                                 | Threshold              |
| ---------------------------------------------------------------------- | ---------------------- |
| Strategic internal links from high-authority pages to key target pages | All priority pages     |
| Anchor text is descriptive (not "click here")                          | 100% of links          |
| Orphaned pages (no internal links)                                     | 0                      |
| Internal link depth (clicks from homepage)                             | ≤ 3 clicks to any page |
| Related content links present                                          | ≥ 3 per page           |

**FAIL condition:** Poor internal linking reduces page authority and discoverability.

---

### Gate 6 — Crawl Coverage & Indexation

| Metric                                      | Threshold          | Tool |
| ------------------------------------------- | ------------------ | ---- |
| Coverage in Google Search Console           | ≥ 95% of all pages |
| Crawl errors                                | 0 in GSC           |
| Mobile usability issues                     | 0 critical issues  |
| AMP or mobile-specific issues               | 0 blocks           |
| Indexed pages matching submitted in sitemap | ≥ 90%              |

**FAIL condition:** Pages not indexed or crawl errors present.

---

### Gate 7 — SEO Monitoring & Reporting

| Metric                                                    | Threshold      |
| --------------------------------------------------------- | -------------- |
| Core Web Vitals baseline documented                       | Pre-launch     |
| Organic search metrics tracked (impressions, clicks, CTR) | Monthly review |
| Crawl stats monitored in GSC                              | Weekly check   |
| Ranking for target keywords tracked                       | Monthly        |
| Performance regressions detected and actioned             | Within 48h     |

**FAIL condition:** No monitoring or reporting in place.

---

## SEO Self-Check Commands

```bash
# Core Web Vitals
lighthouse https://yoursite.com --chrome-flags="--headless"

# Technical SEO audit
screaming-frog-seo-spider --spider yoursite.com

# Structured data validation
# Use Google Rich Results Test: https://search.google.com/test/rich-results
curl -X POST https://schema.org/validator \
  -H "Content-Type: application/json" \
  -d '{"jsonldUrl":"https://yoursite.com"}'

# Check indexation
# Visit https://search.google.com/search-console → Coverage report
```

---

## SEO Checklist Template

**Pre-Launch Checklist:**

- [ ] Core Web Vitals all "Good" on key pages
- [ ] Structured data valid for main content types
- [ ] Sitemap.xml created and submitted to GSC
- [ ] robots.txt allows crawling
- [ ] Canonical tags correct (no conflicts)
- [ ] Internal linking strategy in place
- [ ] 404 pages return proper status code
- [ ] Redirects for moved pages in place (301 redirects)

---

## References

- [Google Search Central – Technical SEO Guide](https://developers.google.com/search/docs)
- [Web Vitals by Google](https://web.dev/vitals/)
- [Schema.org Markup Guide](https://schema.org/)
- [Answer Engine Optimization (AEO) Guide](https://www.searchenginejournal.com/answer-engine-optimization/)
- [SERP Features & Rich Snippets – Moz](https://moz.com/learn/seo/rich-snippets)
- [Internal Linking Best Practices – Yoast SEO](https://yoast.com/internal-linking/)
- [Google Search Console Help – Coverage Report](https://support.google.com/webmasters/answer/7440203)
