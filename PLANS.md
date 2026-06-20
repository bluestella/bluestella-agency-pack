---
title: Implementation plan of Agents, Skills, Hooks, Docs, Workflows, etc.
description: Guidelines in developing a skill, agent, hook, template, instructions, etc.
author: bluestella
date: 2026-06-20
version: 1.0.0
---

# Implementation plan of Agents, Skills, Hooks, Docs, Workflows, etc.

An implementation plan to create corresponding agents, skills, hooks, workflows wherever we see necessary.

[TOC]

## Step 1: Create all agents

Generate all agents based on their roles. Create their skills, instructions, references and templates.

- Business Analyst
  - An _agent (person)_ that writes business requirements that the team consumes to develop an epic, user story, a task, or a sub-task.
- Architecture Team
  - **Sub-agents**
    - Solution Architect
      - **Orchestrate architecture across domains:** Align business requirements with technical strategy by synthesizing input from data, security, and integration architects into a cohesive target state design.
      - **Own end-to-end solution delivery:** Define solution scope, trade-offs, timelines, and dependencies; ensure all architectural domains work together and risks are identified and mitigated.
    - Integration Architect
      - **Design system connectivity and data flow:** Plan how applications, platforms, and data sources exchange information using APIs, message brokers, ETL processes, and middleware; balance performance, latency, and throughput requirements.
      - **Ensure reliable data movement:** Define transformation logic, error handling, retry mechanisms, and monitoring to maintain data consistency, completeness, and timeliness across integrated systems.
    - Data Architect
      - **Design data infrastructure and models:** Create database schemas, data warehouse structures, data lake layouts, and storage strategies that support analytical and operational needs while enabling scalability.
      - **Establish data governance and quality:** Define data ownership, lineage tracking, quality standards, metadata management, and access policies to ensure data trustworthiness and regulatory compliance.
    - Security Architect
      - **Design security controls and threat mitigation:** Define authentication, authorization, encryption, network segmentation, and application hardening strategies to protect systems, data, and infrastructure from threats.
      - **Ensure resilience and compliance:** Establish incident response protocols, audit logging, disaster recovery procedures, and security policies that meet regulatory requirements and enable rapid threat detection and response.
- Frontend Engineer
  - **Sub-agents**
    - React Engineer
    - React Native Engineer
    - SEO Engineer
    - A11y Enineer
- Backend Engineer
  - **Sub-agents**
    - Microservices Engineer
      - An _agent (person)_ who knows to do a Vercel Serverless Functions.
      - Use **Vercel Serverless Functions** as one of this engineer's capability.
- Quality Engineer
  - **Sub-agents**
    - Automation Testing Engineer
    - Performance Testing Engineer

## Skill to document my requirements.

- This should create a streamlined and simple BRD document that can suffice for an Agile work setup.
- This should be formatted in Epic, User Story, Task, Sub-task level.
- When I give a new goal or feature to work on, it should automatically create an epic, user story, and a sub-task. It should be on that same heirarchy.
- Generate different instructions and template for epic, user story, sub-task, and task.
- Generate a checklist of all requirements develop so we could track which are TODO, In-progress, and Done.
- Generate a definition of done that can be understandable by each agents above. Add scoring matrix to know whether the goal for the epic, user story, sub-task, or task is done or not. When Done, it should update the **requirements checklist** of its status.

### See Also

- [Epics, Stories and Themes](https://www.atlassian.com/agile/project-management/epics-stories-themes)

---

## High-level descriptions and work instructions.

- Business Analyst
- Archi, Dev, Test Agent
  - Architecture
    - High-level architecture
      - Define the tech stack.
      - Define the target state architecture using c4 model.
        - Draw diagram using mermaidjs
    - Define sequence diagram of each
  - Security
    - Threat Modelling using STRIDE
    - Hook back to generate a requirement and then run the cycle again.
  - Frontend development
    - Write a code
    - Do a code review
  - Backend development
    - Write a code
    - Do a code review
  - QA Testing
    - Visual Testing
    - Unit Testing
    - Integration Testing
    - API Testing
    - Performance Testing
      - Load
      - Stress
      - Frontend Core Web Vitals
    - When there are issues seen by QA. Generate a bugs and issues documentation. List down all the bugs as a checklist. Monitor or track the progress status which are todo, in progress, and done.
    - Assign the bugs back the to agent to run the cycle again.
  - DevOps
    - Deploy to Vercel App.
