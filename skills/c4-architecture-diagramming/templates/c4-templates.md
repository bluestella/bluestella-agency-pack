# C4 Diagram Templates (Mermaid.js)

## Level 1 — System Context

```mermaid
graph TB
    User["👤 [User Role]<br/>[e.g., End User]"]
    ExternalA["📧 [External System A]<br/>[e.g., Email Service / SendGrid]"]
    ExternalB["💳 [External System B]<br/>[e.g., Payment Processor / Stripe]"]

    System["🎯 [System Name]<br/>[Short description]"]

    User -->|[Action — e.g., Signs up]| System
    System -->|[Action — e.g., Sends verification email]| ExternalA
    System -->|[Action — e.g., Processes payment]| ExternalB
    ExternalA -->|[Response — e.g., Confirms email]| User
    ExternalB -->|[Response — e.g., Payment status]| System
```

**Questions answered by this diagram:**
- Who are the main users or actor types?
- What external systems does this integrate with?
- What are the primary data flows in and out?

---

## Level 2 — Container Architecture

```mermaid
graph TB
    User["👤 User"]

    subgraph System ["[System Name]"]
        FE["[Frontend Container]<br/>[Technology — e.g., React SPA]"]
        BE["[Backend Container]<br/>[Technology — e.g., Next.js API]"]
        DB["[Database]<br/>[Technology — e.g., PostgreSQL 16]"]
        Cache["[Cache]<br/>[Technology — e.g., Redis]"]
        Queue["[Queue]<br/>[Technology — e.g., BullMQ / SQS]"]
    end

    ExternalA["[External Service A]<br/>[e.g., SendGrid]"]
    ExternalB["[External Service B]<br/>[e.g., Stripe]"]

    User -->|"HTTPS requests"| FE
    FE -->|"REST API calls"| BE
    BE -->|"SQL queries"| DB
    BE -->|"Cache reads/writes"| Cache
    BE -->|"Enqueue jobs"| Queue
    Queue -->|"Process jobs"| BE
    BE -->|"Send emails"| ExternalA
    BE -->|"Charge card"| ExternalB
```

**Questions answered by this diagram:**
- What are the major technical building blocks?
- What technology does each container use?
- How do containers communicate (HTTP, SQL, queue)?

---

## Level 3 — Component (within one container)

```mermaid
graph TB
    subgraph API ["[Container Name] — [Technology]"]
        Router["Router<br/>[Routes requests]"]
        AuthMiddleware["Auth Middleware<br/>[Validates JWT]"]
        Controller["[Domain] Controller<br/>[Business logic]"]
        Service["[Domain] Service<br/>[Orchestration]"]
        Repository["[Domain] Repository<br/>[Data access]"]
    end

    DB["[Database]<br/>[PostgreSQL]"]
    ExternalService["[External Service]"]

    Router -->|"Validates token"| AuthMiddleware
    AuthMiddleware -->|"Routes request"| Controller
    Controller -->|"Calls service"| Service
    Service -->|"Reads/writes"| Repository
    Repository -->|"SQL queries"| DB
    Service -->|"API call"| ExternalService
```

**Questions answered by this diagram:**
- What are the internal modules/layers of this container?
- How do components depend on each other?
- Which component touches the database or external services?

---

## Level 4 — Code (Class / Sequence — use sparingly)

```mermaid
classDiagram
    class UserRepository {
        +findById(id: string) User
        +findByEmail(email: string) User
        +create(data: CreateUserDto) User
        +softDelete(id: string) void
    }

    class UserService {
        -repo: UserRepository
        -emailService: EmailService
        +signup(dto: SignupDto) User
        +verifyEmail(token: string) void
    }

    class UserController {
        -service: UserService
        +POST_signup(req, res)
        +POST_verify(req, res)
    }

    UserController --> UserService
    UserService --> UserRepository
```

**Use Level 4 when:**
- Onboarding new developers to complex domain logic
- Documenting a critical class hierarchy
- Otherwise, let the IDE generate this (e.g., VS Code class diagrams extension)
