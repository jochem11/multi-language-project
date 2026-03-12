# Multi-Language Microservices Learning Project

## Overview

This repository contains a **learning project** where a system is built using **multiple programming languages in a microservice architecture**.

The goal of the project is to explore how different technologies can work together in a distributed system while experimenting with modern infrastructure, communication patterns, and development workflows.

The application itself is a **lending and inventory tracking system**. It allows tracking items, their locations, and whether they are currently assigned to a user.

Examples of items include:

* laptops
* tools
* books
* shared equipment
* other lendable resources

An item can either:

* exist at a **specific location**
* be **assigned to a user**
* be **lent out and returned**

The focus of the project is **architecture and experimentation**, rather than building a full production system.

---

## Learning Goals

This project explores:

* building **polyglot microservices**
* designing **event-driven systems**
* combining **synchronous and asynchronous communication**
* exposing APIs through a **GraphQL gateway**
* deploying services with **Kubernetes**
* improving developer workflows with **Tilt**
* building a **modern frontend** using SolidJS

---

## Architecture

The system uses a **hybrid communication model**.

### Client Communication

Clients communicate with the backend through a **GraphQL gateway**, which aggregates data from multiple services.

### Gateway to Services

The **GraphQL Gateway communicates with backend services using gRPC** for fast synchronous requests.

### Service to Service Communication

Services communicate with each other **asynchronously through a message broker** using events.

This allows services to remain loosely coupled and react to system events.

```text
                Web Client
                    │
                    ▼
           GraphQL Gateway (Go)
                    │
                    │ gRPC
                    ▼
        ┌───────────┼───────────┐
        ▼           ▼           ▼
 Users Service   Items Service   Mail Service
   (Python)        (Java)         (Rust)
        │              │             │
        └─────── Message Broker ────┘
                    │
                    ▼
                Event System
```

---

## Services

| Service         | Language | Responsibility                              |
| --------------- | -------- | ------------------------------------------- |
| GraphQL Gateway | Go       | Entry point for clients and API aggregation |
| Users Service   | Python   | User management                             |
| Items Service   | Java     | Item and lending management                 |
| Mail Service    | Rust     | Sending notifications                       |

---

## Event Driven Communication

Service-to-service communication uses **events** sent through a message broker.

Examples of events include:

* `user_created`
* `item_created`
* `item_lent`
* `item_returned`

For example:

1. The **Items Service** emits an `item_lent` event.
2. The **Mail Service** listens for that event.
3. The Mail Service sends a notification email.

This pattern helps keep services **loosely coupled and scalable**.

---

## Frontend

The frontend will be built using **SolidJS**.

The web application will allow users to:

* browse available items
* lend items
* return items
* track item locations
* see which user currently has an item

The frontend communicates with the backend through the **GraphQL Gateway**.

---

## Repository Structure

```
.
├── services
│   ├── graphql-gateway
│   ├── users-service
│   ├── items-service
│   └── mail-service
│
├── web
│   └── frontend (SolidJS)
│
├── infra
│   ├── dev
│   │   ├── docker
│   │   ├── k8s
│   │   └── tilt
│   └── prod
│
├── build
├── docs
└── Tiltfile
```

---

## Technologies Used

### Backend

* Go
* Java
* Python
* Rust

### Frontend

* SolidJS

### Communication

* GraphQL
* gRPC
* Message Broker (event-based communication)

### Infrastructure

* Docker
* Kubernetes
* Tilt

---

## Development Workflow

Local development is handled using **Tilt**, which automatically builds and deploys services to a local Kubernetes cluster.

Start the development environment:

```bash
tilt up
```

Tilt will:

* build services
* deploy them
* stream logs
* update services automatically when code changes

This enables fast development across multiple services.

---

## Project Status

This project is **actively evolving** and is used as a learning environment to explore distributed system concepts.

Future additions may include:

* observability
* distributed tracing
* centralized logging
* authentication and authorization
* CI/CD pipelines
