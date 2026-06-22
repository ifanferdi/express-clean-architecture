# Express Clean Architecture

A boilerplate REST API built with **Express.js + TypeScript**, structured using the **Clean Architecture** pattern (entities, use-cases, repositories, adapters). A solid starter project for backends that need a clean, scalable, and testable structure.

This repo has two branches with the same core stack, differing only in runtime:

| Branch | Runtime | Description |
|--------|---------|------------|
| `main` | Node.js | Standard Node.js version |
| `bun`  | [Bun](https://bun.sh) | Lighter & faster version, same features and structure as `main` |

## ✨ Features

- **Clean Architecture** — clear separation between `domain`, `use-cases`, `repositories`, and `adapters` (HTTP, WebSocket, events)
- **Auth & Authorization** — JWT-based sign in/out, refresh token, role & permission based access control
- **Real-time** — Socket.IO for WebSocket communication (chat handler)
- **Message Queue** — RabbitMQ (with delayed message exchange) for async processing
- **Caching** — Redis for permission & session caching
- **File Storage** — storage abstraction, supports Local Filesystem and AWS S3 / S3-compatible (MinIO for local)
- **Search** — Elasticsearch integration with seeder & mapping
- **Database** — PostgreSQL via Prisma ORM (driver adapter `@prisma/adapter-pg`)
- **Error Monitoring** — Sentry
- **Validation** — Zod schema validation per module

## 🏗️ Architecture
<img width="80%" alt="clean_architecture_layers_white_bg" src="https://github.com/user-attachments/assets/3e670de0-f2c2-4a1c-8f72-cfba426242b0" />

<br/>
<br/>

```
src/
├── adapters/           # HTTP controllers, routes, webserver setup, WebSocket, event handlers
├── config/              # Environment config: app, auth, database, storage configuration, etc
├── constants/           # HTTP status & message constants
├── domain/               # Entities, enums, types (core application contracts)
├── helpers/              # Utility functions (jwt, password, pagination, axios, etc.)
├── infrastructure/       # Technical connections: Prisma, Redis, RabbitMQ, Elasticsearch, Nodemailer
├── repositories/         # Data access implementations (database, redis, filesystem, api, rabbitmq)
├── use-cases/            # Business logic per domain (auth, user, role, permission, common)
├── validations/          # Zod validation schema per module
├── bootstrap.ts          # Dependency wiring (repositories → use-cases → controllers)
└── app.ts                # Entry point
```

The dependency flow follows Clean Architecture: `controller → use-case → repository → infrastructure`, with `domain` as the contract layer that doesn't depend on any other layer.

## 🧱 Tech Stack

- **Runtime**: Node.js (`main`) / Bun (`bun`)
- **Framework**: Express.js
- **Language**: TypeScript
- **Database**: PostgreSQL + Prisma ORM
- **Cache**: Redis
- **Message Broker**: RabbitMQ
- **Search Engine**: Elasticsearch
- **Realtime**: Socket.IO
- **Storage**: AWS S3 SDK / Local filesystem
- **Auth**: JWT (jsonwebtoken) + Argon2 (password hashing)
- **Validation**: Zod
- **Containerization**: Docker & Docker Compose

## 📦 Database Schema

Main models (Prisma):

- `User`, `Profile`
- `Role`, `Permission`
- `RoleHasPermission`, `UserHasRole` (many-to-many relations)

## 🔌 API Endpoints

Base path: `/api/v1`

| Endpoint | Description |
|----------|------------|
| `GET /dashboard` | Dashboard summary |
| `/auth/*` | Sign in, sign out, refresh token |
| `/users/*` | User CRUD, profile image upload |
| `/roles/*` | Role CRUD, assign permission to role |
| `/permissions/*` | Permission CRUD |

## 🚀 Getting Started

### Prerequisites

- [Docker](https://www.docker.com/) & Docker Compose (recommended — all services are already configured)
- Node.js ≥ 18 (`main` branch) **or** [Bun](https://bun.sh) ≥ 1.2 (`bun` branch)

### 1. Clone the repo

```bash
git clone https://github.com/ifanferdi/express-clean-architecture.git
cd express-clean-architecture

# choose the branch matching the runtime you want
git checkout main   # Node.js
# or
git checkout bun    # Bun
```

### 2. Set up environment variables

```bash
cp .env.example .env
```

> Docker Compose also has its own env file at `docker/.env` — adjust the DB, RabbitMQ, and MinIO credentials there.

### 3. Run with Docker Compose (recommended)

```bash
cd docker
docker compose up -d
```

This compose setup automatically provisions:
- PostgreSQL (`db`)
- Redis Stack (`redis`)
- RabbitMQ with delayed message plugin (`rabbitmq`)
- MinIO as S3-compatible storage (`minio`)
- App container (`app`) — listening on `:3000`

### 4. Or run locally (without Docker for the app)

**`main` branch (Node.js):**

```bash
npm install
npm run db:fresh:seed   # migrate + seed database
npm run dev
```

**`bun` branch:**

```bash
bun install
bun run db:fresh:seed
bun run dev
```

### Database scripts (available on both branches)

```bash
npm run db:migrate       # run migration
npm run db:fresh         # reset + re-migrate
npm run db:seed          # seed data
npm run db:fresh:seed    # reset + migrate + seed in one go
```

## 📁 Docker Structure

```
docker/
├── Dockerfile              # Image for the app
├── Dockerfile-rabbitmq     # RabbitMQ image + delayed message plugin
├── docker-compose.yaml     # Orchestration for all services
└── .env                    # Env specific to Docker Compose
```

## 🤝 Contributing

Pull requests and issues are welcome. Please make sure your code follows the existing clean architecture conventions (keep logic in the right layer: domain, use-case, repository, adapter).

## 📄 License

ISC
