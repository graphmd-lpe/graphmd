# Development Journal

Keep recent entries (last 5-10), archive older ones.

---

## 2025-01-15 15:30

**Working on:** Step 3.3 - Implement user CRUD endpoints

**Progress:**
- Completed authentication endpoints (3.1, 3.2)
- Started user CRUD operations
- GET /users and GET /users/:id working

**Decisions made:**
- Using JWT tokens with 24hr expiry (per security requirements)
- Storing hashed passwords with bcrypt (cost factor 12)
- Implementing soft deletes for user records (helps with audit trail)

**Challenges:**
- Password validation regex needed tweaking (see commit abc1234)
- Decided to add email uniqueness check at DB level

**Next:**
- Complete POST /users endpoint
- Add PUT /users/:id endpoint
- Add DELETE /users/:id (soft delete)
- Write tests for all CRUD operations

**Files modified:**
- implementation/src/routes/users.js
- implementation/src/models/User.js

---

## 2025-01-15 14:00

**Working on:** Step 3.2 - Create authentication endpoints

**Progress:**
- Setup Express server structure
- Added JWT middleware
- Completed /login and /register endpoints

**Decisions made:**
- Using express-validator for input validation
- JWT stored in httpOnly cookies (more secure than localStorage)
- Refresh token mechanism with 7-day expiry

**Next:**
- Move to user CRUD operations (3.3)

**Files created:**
- implementation/src/routes/auth.js
- implementation/src/middleware/auth.js
- implementation/src/utils/jwt.js

---

## 2025-01-15 12:30

**Working on:** Step 3.1 - Setup Express server

**Progress:**
- Initialized Express app
- Configured middleware (cors, body-parser, helmet)
- Setup error handling
- Added basic health check endpoint

**Decisions made:**
- Using Express 4.x (latest stable)
- Port 3000 for development, configurable via env
- Structured as MVC pattern

**Next:**
- Start authentication implementation (3.2)

---

## Context Refresh Template

When context refreshes, add entry like:

## YYYY-MM-DD HH:MM - CONTEXT REFRESH

**Current status:**
- Last completed: [task] (see DEV-CHANGELOG.md)
- Currently on: [task] from DEV-BACKLOG.md
- Read: Last 2-3 journal entries above and recent DEV-CHANGELOG entries

**Quick context:**
- Key decisions: [summary]
- Important files: [list]

**Continuing with:** [next task]

