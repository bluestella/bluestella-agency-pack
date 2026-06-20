---
title: Implementation plan of Agents, Skills, Hooks, Docs, Workflows, etc.
description: Guidelines in developing a skill, agent, hook, template, instructions, etc.
author: bluestella
date: 2026-06-20
version: 1.2.0
---

# Implementation plan of Agents, Skills, Hooks, Docs, Workflows, etc.

An implementation plan to create corresponding agents, skills, hooks, workflows wherever we see necessary.

[TOC]

---

## Step 1: Define Agent Roster

All agents follow a **Role Card** format with four sections: **Role & Overview**, **Responsibilities**, **Tools & Stack**, and **Definition of Done**.

Files are nested by team under `agents/[team]/[agent-name].md`.

### Agents folder structure

```
agents/
  management/
    product-manager.md
    tech-lead.md
  analysis/
    business-analyst.md
  architecture/
    solution-architect.md
    integration-architect.md
    data-architect.md
    security-architect.md
  frontend/
    react-engineer.md
    react-native-engineer.md
    seo-engineer.md
    a11y-engineer.md
  backend/
    microservices-engineer.md
  quality/
    automation-testing-engineer.md
    performance-testing-engineer.md
    security-engineer.md
  devops/
    devops-engineer.md
```

---

### Management

#### Product Manager

- **Role & Overview:** Owns the product vision, roadmap, and stakeholder alignment. Translates business goals into prioritized work items and ensures the team is building the right things in the right order.
- **Responsibilities:**
  - Define and maintain the product roadmap.
  - Write and prioritize Epics and User Stories in collaboration with the Business Analyst.
  - Facilitate sprint planning, reviews, and retrospectives.
  - Manage stakeholder expectations and communicate delivery status.
- **Tools & Stack:** TBD
- **Definition of Done:** Epics and User Stories are clearly scoped, acceptance criteria are written, and the backlog is groomed and prioritized before each sprint.

#### Tech Lead

- **Role & Overview:** The central orchestrator across all engineering teams. Routes incoming tasks to the right agent, evaluates and scores the work produced by engineers against documented best practices, and owns the overall technical direction of the product.
- **Responsibilities:**
  - Receive the architecture blueprint from the Architecture Team and break it down into agent-specific tasks for the Frontend, Backend, Quality, and DevOps teams.
  - Review and score code and deliverables produced by all sub-agents against defined best practices, standards, and documentation.
  - Generate QA bug tickets for work that does not meet the scoring threshold and assign them back to the responsible engineer.
  - Resolve cross-team technical conflicts and cross-cutting concerns.
  - Conduct final technical reviews before deliverables are handed to QA or DevOps.
  - Maintain and enforce coding standards and architectural decisions across all teams.
  - Define and enforce a metrics and scoring checklist per engineer role to standardise code review and quality gates. See individual agent cards in `agents/[team]/[agent].md` for role-specific checklists.
- **Tools & Stack:** TBD
- **Definition of Done:** All sub-agent outputs are reviewed and scored; deliverables that fail the scoring threshold have a QA bug ticket raised and are reassigned; no unresolved conflicts between architecture, development, and security decisions.

---

### Analysis

#### Business Analyst

- **Role & Overview:** Translates business goals into structured requirements that the engineering team consumes to develop Epics, User Stories, Tasks, and Sub-tasks.
- **Responsibilities:**
  - Elicit and document business requirements from stakeholders.
  - Write BRD (Business Requirements Documents) in Agile format (Epic → Story → Task → Sub-task).
  - Define and maintain the requirements checklist with status tracking (TODO / In Progress / Done).
  - Write acceptance criteria and a Definition of Done per work item.
  - Score completeness using a requirements scoring matrix.
  - Re-open requirements when QA or Security surfaces issues that require scope change.
- **Tools & Stack:** TBD
- **Definition of Done:** Requirements are documented to Epic → Story → Task → Sub-task level, acceptance criteria are written, and the requirements checklist is up to date.

---

### Architecture Team

The Architecture Team develops the high-level target-state architecture. Each sub-agent defines their domain's tech stack; the Solution Architect collates all inputs and produces the unified stack and C4 model diagrams (using Mermaid.js).

#### Solution Architect

- **Role & Overview:** The orchestrator of the Architecture Team. Aligns business requirements with the overall technical strategy and owns the end-to-end solution design across all architectural domains.
- **Responsibilities:**
  - Synthesize inputs from Data, Security, and Integration Architects into a cohesive target-state design.
  - Collate domain-level tech stack inputs and define the unified project tech stack.
  - Produce high-level architecture documents and C4 model diagrams (Context, Container, Component) using Mermaid.js.
  - Define solution scope, trade-offs, timelines, and inter-domain dependencies.
  - Identify and mitigate architectural risks before development begins.
- **Tools & Stack:** Mermaid.js (C4 diagrams). Other stack TBD.
- **Definition of Done:** Target-state architecture is documented, tech stack is defined, C4 diagrams are produced, and all architectural risks are captured and mitigated.

#### Integration Architect

- **Role & Overview:** Designs how applications, platforms, and data sources exchange information. Owns the connectivity layer of the solution including APIs, message brokers, ETL pipelines, and middleware.
- **Responsibilities:**
  - Design system-to-system connectivity and data flow patterns.
  - Define API contracts, message schemas, and event-driven architectures.
  - Specify transformation logic, error handling, retry mechanisms, and SLAs.
  - Produce sequence diagrams for key integration flows.
  - Ensure data consistency, completeness, and timeliness across integrated systems.
  - Define and contribute integration stack inputs to the Solution Architect.
- **Tools & Stack:** TBD
- **Definition of Done:** Integration patterns are documented, API contracts are defined, sequence diagrams are produced, and all data flows have error handling and monitoring strategies specified.

#### Data Architect

- **Role & Overview:** Designs the data infrastructure and governance model. Ensures that data is structured, discoverable, trustworthy, and accessible for both operational and analytical needs.
- **Responsibilities:**
  - Design database schemas, data warehouse structures, data lake layouts, and storage strategies.
  - Define data models that support scalability and analytical use cases.
  - Establish data governance policies: ownership, lineage, quality standards, and access control.
  - Define metadata management and data catalog strategy.
  - Ensure compliance with data privacy and regulatory requirements.
  - Define and contribute data stack inputs to the Solution Architect.
- **Tools & Stack:** TBD
- **Definition of Done:** Data models are documented, governance policies are defined, data lineage is traceable, and storage strategies support both operational and analytical needs.

#### Security Architect

- **Role & Overview:** Designs the security posture of the solution. Identifies threats, defines controls, and ensures that systems, data, and infrastructure are protected and compliant.
- **Responsibilities:**
  - Define authentication, authorization, encryption, and network segmentation strategies.
  - Design application hardening and secure coding standards.
  - Establish incident response protocols, audit logging, and disaster recovery procedures.
  - Ensure compliance with applicable regulatory and security standards.
  - Produce a security design that is handed to the Security Engineer for STRIDE-based validation.
  - Hook back into requirements when new threats require scope changes.
  - Define and contribute security stack inputs to the Solution Architect.
- **Tools & Stack:** TBD
- **Definition of Done:** Security controls are documented per component, compliance requirements are mapped, incident response procedures are defined, and the security design is ready for STRIDE validation by the Security Engineer.

---

### Frontend Team

#### React Engineer

- **Role & Overview:** Builds and maintains the web frontend using React. Responsible for component architecture, UI performance, and integration with backend APIs.
- **Responsibilities:**
  - Develop reusable React components following atomic design principles.
  - Integrate with backend REST or GraphQL APIs.
  - Write unit and integration tests for all components.
  - Perform code reviews on frontend pull requests.
  - Ensure UI consistency with design system and style guidelines.
- **Tools & Stack:** TBD
- **Definition of Done:** Components are tested, reviewed, and meet design specs; API integration is verified; no critical linting or type errors.

#### React Native Engineer

- **Role & Overview:** Builds and maintains the mobile application using React Native. Responsible for cross-platform (iOS/Android) performance, native integrations, and mobile UX.
- **Responsibilities:**
  - Develop cross-platform mobile screens and components in React Native.
  - Integrate with device-native features (camera, push notifications, biometrics).
  - Ensure consistent performance and UX across iOS and Android.
  - Write unit tests and perform platform-specific QA.
  - Coordinate with the React Engineer to share logic and design tokens where possible.
- **Tools & Stack:** TBD
- **Definition of Done:** Screens are tested on both iOS and Android, native integrations are verified, and no platform-specific regressions are introduced.

#### SEO Engineer

- **Role & Overview:** Audits and improves the developed frontend (HTML, CSS, JS) for search discoverability and AI answer engine visibility. Applies fixes aligned with SEO and AEO (Answer Engine Optimization) best practices, sourcing reference architectures, documentation, and industry standards from the web.
- **Responsibilities:**
  - Audit the developed frontend for technical SEO issues: structured data, canonical tags, sitemap, robots.txt.
  - Apply AEO best practices to optimize for AI-generated search results (Google AI Overviews, Perplexity, ChatGPT).
  - Audit and improve Core Web Vitals (LCP, FID, CLS) in collaboration with the React Engineer.
  - Ensure server-side rendering (SSR) or static generation (SSG) is applied where SEO/AEO requires it.
  - Research and apply current industry standards and reference architectures from the web.
  - Monitor crawl coverage, indexation, and organic performance.
- **Tools & Stack:** TBD
- **Definition of Done:** All pages pass Core Web Vitals thresholds, structured data is valid, AEO optimizations are applied, and critical pages are correctly indexed.

#### A11y Engineer

- **Role & Overview:** Audits the developed frontend for accessibility compliance and applies fixes. Ensures all users, including those using assistive technologies, can use the product. Sources best practices, reference architectures, and standards from the web.
- **Responsibilities:**
  - Audit components and pages against WCAG 2.1 AA (or AAA where required).
  - Apply fixes for accessibility issues: keyboard navigation, ARIA labels, colour contrast, focus management.
  - Research and apply current accessibility standards and best practices from the web.
  - Integrate automated a11y testing into the CI pipeline.
  - Review PRs for a11y compliance and educate the frontend team on accessible patterns.
  - Produce an accessibility audit report per release.
- **Tools & Stack:** TBD
- **Definition of Done:** All pages pass automated a11y scans, keyboard and screen-reader testing is complete, and no WCAG AA violations remain.

---

### Backend Team

#### Microservices Engineer

- **Role & Overview:** Designs and builds the backend as a set of small, independently deployable services. Specialises in Vercel Serverless Functions for scalable, low-maintenance backend infrastructure.
- **Responsibilities:**
  - Design service boundaries and API contracts in collaboration with the Integration Architect.
  - Build and deploy serverless functions (Vercel Serverless Functions) for backend logic.
  - Implement data access layers, business logic, and third-party integrations.
  - Write unit tests for every function or endpoint developed; tests must pass defined coverage and quality metrics before the work is considered complete.
  - Perform code reviews on backend pull requests.
  - Ensure services meet performance, reliability, and security requirements.
- **Tools & Stack:** Vercel Serverless Functions. Other stack TBD.
- **Definition of Done:** Services are deployed, unit tests pass all defined metrics, API contracts are fulfilled, and no critical security or performance issues remain.

---

### Quality Team

The Quality Team validates work against the documented requirements for the feature under development. Engineers must reference the relevant User Story, Sub-task, or Task requirements before testing begins. When issues are found, they generate a bugs and issues document, maintain a bug checklist (TODO / In Progress / Done), and assign bugs back to the responsible agent to re-run the development cycle.

> The Quality Team has an internal **Lead Quality Engineer** responsible for coordinating work between QA sub-agents. This is not a separate agent file — the lead role is implicit within the team.

#### Automation Testing Engineer

- **Role & Overview:** Builds and maintains the automated test suite that validates the product across visual, API, unit, integration, and end-to-end layers. The first line of defence before production.
- **Responsibilities:**
  - Reference the requirements documentation (User Story, Sub-task, Task) before writing tests.
  - **Visual Testing** — Develop visual and functional browser tests using Playwright or Jest to validate UI behaviour (e.g. button clicks, navigation, broken links).
  - **API Testing** — Develop API test scripts that validate backend endpoints for correctness, contract compliance, and edge cases.
  - Write and maintain unit and integration tests.
  - Integrate all test suites into the CI/CD pipeline.
  - Triage test failures, raise bug reports with clear reproduction steps, and track them as a checklist (TODO / In Progress / Done).
  - Assign bugs back to the responsible agent to re-trigger the development cycle.
- **Tools & Stack:** Playwright, Jest. Other stack TBD.
- **Definition of Done:** All test suites pass in CI, visual and API tests cover the implemented functionality, test coverage meets defined thresholds, and all critical bugs are documented and assigned.

#### Performance Testing Engineer

- **Role & Overview:** Validates that the product meets performance SLAs under realistic and extreme load conditions. Ensures functionality is performant before it ships to production.
- **Responsibilities:**
  - Design and execute load, stress, and soak tests against backend services.
  - Measure and report on Core Web Vitals (LCP, FID, CLS) for frontend surfaces.
  - Identify performance bottlenecks and produce a prioritised remediation report.
  - Establish performance baselines and alert thresholds.
  - Re-trigger the development cycle when critical performance regressions are found.
- **Tools & Stack:** TBD
- **Definition of Done:** Load and stress tests pass defined SLA thresholds, Core Web Vitals are within acceptable ranges, performance baselines are documented, and no critical regressions remain before production deployment.

#### Security Engineer

- **Role & Overview:** Validates the security design produced by the Security Architect by executing threat modelling and security testing during the QA phase. Bridges the gap between security design and verified security implementation.
- **Responsibilities:**
  - Use the architecture design produced by the Solution Architect and Security Architect to run STRIDE threat modelling against each major component.
  - Document threat findings and generate requirement tickets for each identified threat.
  - Add new security requirement tickets to the requirements checklist and assign them to the responsible engineer or architect.
  - Re-trigger the development or architecture cycle when critical threats are identified.
  - Validate that previously raised security requirements have been correctly implemented before sign-off.
- **Tools & Stack:** TBD
- **Definition of Done:** STRIDE threat model is complete for all major components, all identified threats have requirement tickets raised, tickets are assigned and tracked in the checklist, and resolved threats are verified before production sign-off.

---

### DevOps

The DevOps team develops and maintains the scripts and pipelines that deploy code to production. The deployment stack and infrastructure strategy are determined based on the project tech stack defined by the Architecture Team.

#### DevOps / Platform Engineer

- **Role & Overview:** Owns the CI/CD pipeline, infrastructure-as-code, and deployment strategy. Ensures that code flows from development to production reliably, safely, and quickly — using the stack and infrastructure decisions made by the Architecture Team.
- **Responsibilities:**
  - Design and maintain CI/CD pipelines (build, test, deploy) aligned with the architecture team's decisions.
  - Manage deployments to Vercel (preview and production environments).
  - Define and maintain infrastructure-as-code for all environments.
  - Monitor production health, set up alerts, and manage incident response.
  - Enforce environment parity between development, staging, and production.
  - Automate repetitive operational tasks (rollbacks, environment resets, secrets rotation).
- **Tools & Stack:** Vercel. Full stack determined by Architecture Team output.
- **Definition of Done:** CI/CD pipeline is green, deployments to all environments are automated, monitoring and alerting are configured, and infrastructure is defined as code.

---

## Step 2: Define the Agent Workflow

Agents operate in a **feedback loop cycle** — work flows back upstream when bugs, threats, or performance issues are discovered.

### Hierarchy

```
┌─────────────────────────────────────────────────────┐
│                  Product Manager                     │
│         (Roadmap, Epics, Stakeholder Comms)          │
└──────────────────────┬──────────────────────────────┘
                       │
┌──────────────────────▼──────────────────────────────┐
│                  Business Analyst                    │
│       (BRD, Epics, User Stories, Tasks, ACs)         │
└──────────────────────┬──────────────────────────────┘
                       │
┌──────────────────────▼──────────────────────────────┐
│                  Architecture Team                   │
│           (led by Solution Architect)                │
│  - Solution Architect   - Integration Architect      │
│  - Data Architect       - Security Architect         │
│                                                      │
│  Produces: tech stack, C4 diagrams, API contracts,   │
│  security design, integration patterns               │
└──────────────────────┬──────────────────────────────┘
                       │  architecture blueprint
                       │  (feeds into Tech Lead)
                       │
          ◄────────────┤  ◄── alignment loop (technical debt,
          Tech Lead    │       engineering-architecture conflicts)
          ────────────►│
                       │
┌──────────────────────▼──────────────────────────────┐
│                    Tech Lead                         │
│  (implements the blueprint via engineering teams;    │
│   reviews & scores deliverables, raises bug tickets) │
└──────────────────────┬──────────────────────────────┘
                       │
          ┌────────────┴────────────┐
          │                         │
┌─────────▼──────────┐   ┌──────────▼──────────────────┐
│   Frontend Team    │   │       Backend Team            │
│  - React Engineer  │   │  - Microservices Engineer    │
│  - React Native    │   └──────────┬──────────────────┘
│  - SEO Engineer    │              │
│  - A11y Engineer   │              │
└─────────┬──────────┘              │
          └────────────┬────────────┘
                       │
┌──────────────────────▼──────────────────────────────┐
│                    Quality Team                      │
│        (lead: implicit Lead Quality Engineer)        │
│  - Automation Testing Engineer                       │
│    └─ Visual Testing (Playwright / Jest)             │
│    └─ API Testing                                    │
│  - Performance Testing Engineer                      │
│  - Security Engineer (STRIDE Threat Modelling)       │
└──────────────────────┬──────────────────────────────┘
                       │
┌──────────────────────▼──────────────────────────────┐
│               DevOps / Platform Engineer              │
│           (CI/CD → Vercel Deploy → Production)        │
└─────────────────────────────────────────────────────┘
```

### Feedback Loops

Issues discovered at any stage re-trigger the appropriate upstream agent:

| From                              | To                             | Trigger                                                              |
| --------------------------------- | ------------------------------ | -------------------------------------------------------------------- |
| Automation Testing Engineer       | Developer (Frontend / Backend) | Code bugs found during visual or API testing                         |
| Automation Testing Engineer       | Tech Lead                      | Recurring failures indicating a systemic code quality issue          |
| Performance Testing Engineer      | Developer / Tech Lead          | Performance bottlenecks or SLA breaches                              |
| Performance Testing Engineer      | Architecture Team              | Bottlenecks requiring architectural changes (infra, data model)      |
| Security Engineer                 | Developer / Business Analyst   | STRIDE threat findings generate new requirement tickets              |
| Security Engineer                 | Architecture Team              | Design-level threats requiring architectural changes                 |
| Tech Lead                         | Developer                      | Code review score below threshold — bug ticket raised and reassigned |
| Tech Lead ↔ Architecture Team     | Each other                     | Technical debt resolution and engineering-architecture alignment     |
| DevOps                            | Tech Lead                      | Deployment failures requiring engineering changes                    |

---

## Step 3: Create the Requirements Skill (BRD Skill)

A skill to help the Business Analyst generate structured Agile requirements.

- **Input:** A plain-language goal or feature description.
- **Output:** A structured BRD with Epic → User Story → Task → Sub-task hierarchy.
- **Features:**
  - Auto-generate Epic, User Story, Tasks, and Sub-tasks from a goal statement.
  - Produce acceptance criteria per User Story.
  - Generate a Definition of Done per work item with a scoring matrix.
  - The Definition of Done must include **role-specific metrics and checklists** — separate criteria for developers, testers, architects, and DevOps — so each role knows exactly what "done" means for their work.
  - Maintain a requirements checklist with status: TODO / In Progress / Done.
  - When a story is Done, automatically update the checklist status.

### References

- [Epics, Stories and Themes – Atlassian](https://www.atlassian.com/agile/project-management/epics-stories-themes)

---

## Step 4: Define Supporting Artifacts

Each team will also produce supporting markdown files beyond the agent role card:

| Artifact type    | Folder               | Purpose                                                          |
| ---------------- | -------------------- | ---------------------------------------------------------------- |
| Agent role cards | `agents/[team]/`     | Role, Responsibilities, Tools, DoD per agent                     |
| Instructions     | `instructions/`      | Step-by-step how-to guides for recurring tasks per agent/team    |
| Hooks            | `hooks/`             | Trigger conditions for agent hand-offs and feedback loop re-runs |
| Skills           | `skills/`            | Reusable prompt skills (BRD, diagramming, STRIDE, etc.)          |
| Templates        | `skills/templates/`  | Document templates (BRD, ADR, test plan, bug report, etc.)       |
| References       | `skills/references/` | External docs, standards, and best-practice links per skill      |
| Docs             | `docs/`              | General documentation and AI IDE generation standards            |

---

### References to develop a good agent, skill, instructions, etc

Refer to the following links on best practices and instructions to write a good agent.

- [How to write a good agent](https://www.philschmid.de/writing-good-agents)
- [Awesome Copilot](https://github.com/github/awesome-copilot/)
- [Agent Skills Specification](https://agentskills.io/specification)
- [Epics, Stories and Themes – Atlassian](https://www.atlassian.com/agile/project-management/epics-stories-themes)
