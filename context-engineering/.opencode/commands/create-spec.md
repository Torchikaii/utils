# Create SPEC: Generate Technical Specification

## Purpose

Generate a detailed technical specification document for engineering implementation.

---

## Output

Write to: `$ARGUMENTS` (default: `.opencode/SPEC.md`)

---

## SPEC Template

### 1. Overview
- System/component name
- Purpose and scope
- Dependencies

### 2. Architecture

**High-level diagram/structure:**
```
<directory or component structure>
```

**Data flow:**
- How data moves through the system
- Key interfaces

### 3. API Specification

**Endpoints:**

| Method | Path | Request | Response |
|--------|------|---------|----------|
| GET | /api/... | {...} | {...} |

### 4. Data Models

**Entity: Name**
```typescript
interface Name {
  field: type;
}
```

### 5. Configuration
- Environment variables
- Config files

### 6. Security
- Authentication
- Authorization
- Data handling

### 7. Error Handling
- Error codes
- Logging strategy

### 8. Testing Strategy
- Unit test coverage
- Integration tests

### 9. Deployment
- Infrastructure
- Rollback plan

---

## Instructions

### Step 1: Analyze
- Review existing PRD or requirements
- Identify technical constraints

### Step 2: Design
- Propose architecture
- Define interfaces

### Step 3: Document
- Use tables for APIs
- Use code blocks for schemas

### Step 4: Review
- Are all dependencies documented?
- Is error handling complete?
