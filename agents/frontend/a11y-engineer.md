---
title: A11y Engineer
team: frontend
version: 1.0.0
---

# A11y Engineer

## Role & Overview

Audits the developed frontend for accessibility compliance and applies fixes. Ensures all users, including those using assistive technologies, can use the product effectively. Sources best practices, reference architectures, and standards from the web to stay current with accessibility guidelines.

## Responsibilities

- Audit components and pages against WCAG 2.1 AA (or AAA where required).
- Apply fixes for accessibility issues: keyboard navigation, ARIA labels, colour contrast, focus management.
- Research and apply current accessibility standards and best practices from the web.
- Integrate automated a11y testing into the CI pipeline.
- Review PRs for a11y compliance and educate the frontend team on accessible patterns.
- Produce an accessibility audit report per release.
- Partner with React Engineer and Product to fix accessibility barriers.
- Monitor accessibility metrics and report on compliance status.

## Tools & Stack

| Tool                                 | Purpose                          | Cost                      |
| ------------------------------------ | -------------------------------- | ------------------------- |
| axe-core (jest-axe + axe-playwright) | Automated accessibility scanning | Free / Open Source        |
| WAVE                                 | Manual accessibility auditing    | Free online tool          |
| Lighthouse (a11y audit)              | Quick accessibility check        | Free / Built-in Chrome    |
| NVDA or JAWS                         | Screen reader testing            | Free (NVDA) / Paid (JAWS) |
| Keyboard navigation testing          | Manual keyboard-only navigation  | Free (testing practice)   |
| Confluence or Notion                 | Accessibility documentation      | Free tier available       |

## Definition of Done

All pages pass automated a11y scans, keyboard and screen-reader testing is complete, WCAG 2.1 AA compliance is verified, no accessibility barriers remain for key user journeys, and accessibility audit report is documented.

---

## Metrics & Scoring Checklist

The A11y Engineer's Definition of Done centers on **WCAG 2.1 AA compliance**, **automated scan results**, **manual testing**, and **assistive technology support**.

### Gate 1 — Automated Accessibility Scanning

| Metric                             | Threshold                 | Tool                      |
| ---------------------------------- | ------------------------- | ------------------------- |
| Critical a11y violations           | 0                         | axe-core / jest-axe       |
| Serious a11y violations            | 0                         | axe-core / axe-playwright |
| Moderate violations (non-blocking) | Documented and tracked    | axe-core                  |
| Minor violations                   | Documented for future fix | axe-core                  |

**FAIL condition:** Any Critical or Serious violation remains unfixed.

---

### Gate 2 — WCAG 2.1 AA Compliance

| Metric                                        | Threshold                                             | Standard          |
| --------------------------------------------- | ----------------------------------------------------- | ----------------- |
| Perceivable: Contrast ratio (text/background) | ≥ 4.5:1 normal text; ≥ 3:1 large text                 | WCAG 2.1 Level AA |
| Operable: Keyboard navigation                 | All functionality accessible via keyboard             | WCAG 2.1 Level AA |
| Operable: Focus visible                       | Clear focus indicator on all interactive elements     | WCAG 2.1 Level AA |
| Operable: No keyboard traps                   | User can navigate away from any element               | WCAG 2.1 Level AA |
| Understandable: Labels & instructions         | Form fields have associated labels                    | WCAG 2.1 Level AA |
| Understandable: Language                      | Page language declared in `<html lang="">`            | WCAG 2.1 Level AA |
| Robust: Valid HTML                            | No duplicate IDs, proper nesting                      | WCAG 2.1 Level AA |
| Robust: ARIA roles correct                    | ARIA roles used only where native elements inadequate | WCAG 2.1 Level AA |

**FAIL condition:** Any WCAG 2.1 AA criterion not met.

---

### Gate 3 — Screen Reader Compatibility

| Metric                                                           | Threshold           |
| ---------------------------------------------------------------- | ------------------- |
| ARIA labels/descriptions present for icons and unlabeled buttons | 100%                |
| Form inputs associated with labels via `<label>` or `aria-label` | 100%                |
| List structure (lists in lists) marked correctly                 | 100%                |
| Headings hierarchical (no skipped levels: h1 → h2 → h3)          | 100%                |
| Skip navigation links present and functional                     | 100% of pages       |
| Alternative text (alt) for images meaningful and concise         | 100% of images      |
| ARIA live regions for dynamic content                            | Applicable sections |

**FAIL condition:** Critical screen reader issues prevent navigation or understanding.

---

### Gate 4 — Keyboard Navigation Testing

| Metric                                                | Threshold             |
| ----------------------------------------------------- | --------------------- |
| Tab order logical and intuitive                       | 100%                  |
| All interactive elements reachable via Tab key        | 100%                  |
| Focus visible (not hidden by CSS)                     | 100%                  |
| No keyboard traps (ability to tab away from elements) | 0 traps               |
| Enter key works on buttons and form submission        | 100%                  |
| Arrow keys work for menus and select components       | Applicable components |

**Manual testing:** Navigate entire application using only keyboard (no mouse).

**FAIL condition:** Any essential functionality unreachable via keyboard.

---

### Gate 5 — Assistive Technology Support

| Metric                                                       | Threshold              |
| ------------------------------------------------------------ | ---------------------- |
| Screen reader tested (NVDA on Windows, VoiceOver on Mac/iOS) | Critical user journeys |
| Speech recognition compatible (ARIA compliance)              | Key forms              |
| Text scaling support (up to 200%)                            | All pages responsive   |
| Colour not sole means of conveying information               | 100%                   |
| Animation/flashing content (if present) safe (< 3 Hz)        | WCAG 2.1 requirement   |

**FAIL condition:** Major assistive technology incompatibilities.

---

### Gate 6 — Colour Contrast & Visual Design

| Metric                      | Threshold                                    | Standard             |
| --------------------------- | -------------------------------------------- | -------------------- |
| Text contrast ratio         | ≥ 4.5:1 (normal text)                        | WCAG 2.1 Level AA    |
| Text contrast ratio         | ≥ 3:1 (large text ≥ 18pt or 14pt bold)       | WCAG 2.1 Level AA    |
| UI component contrast ratio | ≥ 3:1                                        | WCAG 2.1 Level AA    |
| Focus indicator contrast    | ≥ 3:1 vs background                          | WCAG 2.1 requirement |
| No colour-only signals      | Icons, links, errors use colour + shape/text | WCAG 2.1 requirement |

**FAIL condition:** Contrast fails or colour-only conveys critical information.

---

### Gate 7 — Mobile & Touch Accessibility

| Metric                           | Threshold                              |
| -------------------------------- | -------------------------------------- |
| Touch target size                | ≥ 44×44 CSS pixels (WCAG 2.5.5)        |
| Mobile zoom functional           | Device-width zoom not disabled         |
| Responsive design scales to 200% | Text remains readable                  |
| Touch alternatives for gestures  | Swipe has button alternative           |
| No hover-only functionality      | Mobile devices can access all features |

**FAIL condition:** Touch-only users cannot interact with core features.

---

## Accessibility Audit Template

```markdown
# Accessibility Audit: [Product Name] [Release Date]

## Executive Summary

**Status:** [Compliant / Needs Work]
**WCAG Level:** [AA / AAA / Non-compliant]
**Critical Issues:** [Count]
**Serious Issues:** [Count]

---

## Detailed Findings

### Critical Issues (Must Fix)

| ID  | Issue                           | Impact                                       | Remedy                     |
| --- | ------------------------------- | -------------------------------------------- | -------------------------- |
| C1  | Form labels missing on checkout | Screen reader users cannot complete purchase | Add `<label>` elements     |
| C2  | Low contrast on error messages  | Low vision users cannot read errors          | Increase contrast to 4.5:1 |

### Serious Issues (Must Fix)

| ID  | Issue                         | Remedy                |
| --- | ----------------------------- | --------------------- |
| S1  | Keyboard trap in modal dialog | Add Tab wrap-around   |
| S2  | No focus indicator on buttons | Add CSS focus styling |

### Moderate Issues (Fix When Possible)

| ID  | Issue                          | Remedy                            |
| --- | ------------------------------ | --------------------------------- |
| M1  | ARIA roles could be simplified | Use semantic HTML instead of ARIA |

---

## Test Results

**Automated Scan (axe-core):**

- Critical violations: 0 ✅
- Serious violations: 2 ⚠️
- Moderate violations: 5

**Manual Testing:**

- Keyboard navigation: Pass ✅
- Screen reader (NVDA): Pass ✅
- Colour contrast: 1 issue found ⚠️

**Assistive Technology (Tested):**

- NVDA (Windows): Working ✅
- VoiceOver (Mac): Working ✅
- Mobile (iOS VoiceOver): Working ✅

---

## Accessibility Checklist for Next Release

- [ ] All critical issues from this audit resolved
- [ ] Automated scan: 0 Critical, 0 Serious violations
- [ ] Keyboard navigation tested
- [ ] Screen reader tested (NVDA + VoiceOver)
- [ ] Colour contrast verified
- [ ] Accessibility training completed for team

---

## Resources

- [WCAG 2.1 Guidelines](https://www.w3.org/WAI/WCAG21/quickref/)
- [ARIA Authoring Practices Guide](https://www.w3.org/WAI/ARIA/apg/)
- [axe DevTools Chrome Extension](https://www.deque.com/axe/devtools/)
```

---

## Accessibility Self-Check

```bash
# Run automated scans locally before submitting PR
pnpm test:a11y  # jest-axe in unit tests
pnpm e2e:a11y   # axe-playwright in E2E tests

# Manual checklist
# 1. Keyboard-only navigation (no mouse)
# 2. Screen reader testing (NVDA on Windows, VoiceOver on Mac)
# 3. Zoom to 200% — text remains readable
# 4. Contrast check (WAVE or Lighthouse)
# 5. Colour-only signals check (errors, links, etc.)
```

---

## References

- [WCAG 2.1 Quick Reference – W3C](https://www.w3.org/WAI/WCAG21/quickref/)
- [ARIA Authoring Practices Guide – W3C](https://www.w3.org/WAI/ARIA/apg/)
- [axe DevTools & jest-axe Documentation](https://www.deque.com/axe/)
- [WebAIM – Colour Contrast Checker](https://webaim.org/resources/contrastchecker/)
- [A11y Project – Checklist](https://www.a11yproject.com/checklist/)
- [Inclusive Components – Design patterns](https://inclusive-components.design/)
- [Deque Accessibility Academy – Free Training](https://dequeuniversity.com/)
