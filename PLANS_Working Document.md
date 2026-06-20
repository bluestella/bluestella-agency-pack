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
  - The role develops the High-level target architecture
    - Each sub agents defines their tech stack. Primarily it should be collated from different architects and developed by the Solution Architect.
    - Define the target state architecture using c4 model.
      - Draw diagram using mermaidjs
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
- Technical Lead
  - Serves as the orchestrator for frontend and backend engineers and its sub-agents.
  - It evaluates the codes that were written by the agents and sub-agents. Reviews it. Scores it based on best practices and documentations done for each of its roles.
  - **NOTE**: We need to create a metrics and checklist to cross-check the work of each engineers. Generate a QA bug ticket to send it back to the assigned engineer to work it again.
- Frontend Engineer
  - **Sub-agents**
    - React Engineer
    - React Native Engineer
    - SEO Engineer
      - The role audits the developed frontend (html,css,js) functionality.
      - The role applies fixes in relation to SEO and AIO/GIO best practices in the industry. Get reference architecture, documentation, and standards in the internet.
    - A11y Enineer
      - The role audits the developed frontend functionality.
      - The role applies fixes in relation to accessibility. Get best practices, reference architectures, documentations, standards in the internet.
- Backend Engineer
  - **Sub-agents**
    - Microservices Engineer
      - An _agent (person)_ who knows to do a Vercel Serverless Functions.
      - Use **Vercel Serverless Functions** as one of this engineer's capability.
      - The developer should create a unit testing of the functionality. It should pass the relevant metrics for the function or endpoint developed.
- Quality Engineer
  - The quality engineers should refer to the requirements of the feature been developed by the developers. It should check the requirements documentation of either user story, sub-task, or task.
  - When there are issues seen by QA. Generate a bugs and issues documentation. List down all the bugs as a checklist. Monitor or track the progress status which are todo, in progress, and done.
  - Assign the bugs back the to agent to run the cycle again.
  - **Sub-agents**
    - Automation Testing Engineer
      - **Sub-skills**
        - Visual Testing
          - Playwright or Jest framework.
          - The skill develops visual testing to check on the functionality on the browser whether a button can be clicked and does not have any broken links/issues as an example.
        - API Testing
          - The skill develops an API testing script that checks on the backend APIs developed.
    - Performance Testing Engineer
      - The role develops a performance testing scripts such as for core web vitals, load testing, and stress testing. It should ensure that the functionality is performant before it ships to production.
    - Security Engineer
      - This role uses the architecture design created by **Solution Architect** and runs a Threat Modelling using STRIDE framework.
      - The result of the threat model assessment will generate a requirement ticket and adds to the checklist and will be assigned to the respective engineers to develop.
- DevOps
  - The role develops scripts that deploys the code to a hosting application like vercel. Stack should depend on the project overview and tech stack that was developed by the architecture team.

## Orchestrator Agents

### DO

- Create an orchestrator agents based from the descriptions and statements above.
- Maintain the heirarchy. All requirements and project documentations will come from Product Manager, develop requirement by Business Analyst, develops architecture by Architecture Teams orchestrated by Solution Architect. Technical Lead orchestrates the work between different frontend and backend engineers. Lead Quality Engineer orchestrates the work between different quality engineers.

## Instructions to develop a skill to document requirements.

- This should create a streamlined and simple BRD document that can suffice for an Agile work setup.
- This should be formatted in Epic, User Story, Task, Sub-task level.
- When I give a new goal or feature to work on, it should automatically create an epic, user story, and a sub-task. It should be on that same heirarchy.
- Generate different instructions and template for epic, user story, sub-task, and task.
- Generate a checklist of all requirements develop so we could track which are TODO, In-progress, and Done.
- Generate a definition of done that can be understandable by each agents above. Add scoring matrix to know whether the goal for the epic, user story, sub-task, or task is done or not. When Done, it should update the **requirements checklist** of its status.
- The definition of done should have different metrics and checklist per role like for developers and testers. It will also be referred by these roles.

### References to develop a good agent, skill, instructions, etc

Refer to the following links on best practices and instructions to write a good agent.

- [Epics, Stories and Themes](https://www.atlassian.com/agile/project-management/epics-stories-themes)
- [How to write a good agent](https://www.philschmid.de/writing-good-agents)
- [Awesome Copilot Github](https://github.com/github/awesome-copilot/)
- [Writing agent skills specs](https://agentskills.io/specification)
