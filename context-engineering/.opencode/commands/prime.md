# Prime: Load Project Context

## Purpose

Rebuild project awareness in a new OpenCode session. This command provides the AI coding agent with all necessary context to continue working on the project effectively.

---

## Instructions

### Step 1: Read Core Documents

Read these files in order:

1. **`.opencode/PRD.md`** - Product Requirements Document
   - Understand what we're building and why
   - Review scope, user stories, success criteria
   - Note any constraints or requirements

2. **`.opencode/AGENTS.md`** - AI Agent Rules
   - Understand coding style and conventions
   - Review testing requirements
   - Remember the Questions Policy

3. **`.opencode/progress/current.md`** - Project progress
   - Current phase number
   - What has been completed (human-marked ✅)
   - What is in progress
   - Any blockers

4. **`README.md`** (project root) - if exists
   - Quick overview of the project
   - Setup instructions
   - Key commands

### Step 2: Explore Project Structure

Examine the actual project structure:
- List root directory contents
- Identify key directories (src/, lib/, tests/, etc.)
- Note any configuration files

### Step 3: Review Current State

Check:
- **`.opencode/progress/current.md`** - Current phase, what's done, blockers
- Active plans in `.opencode/plans/`
- Recent changes since last session

### Step 4: Summarize Context

Provide a concise summary to the user covering:
- **Project:** What this project is
- **Current Phase:** Where we are in the workflow
- **Tech Stack:** Main technologies used
- **Next Steps:** What to work on next (if clear)
- **Open Questions:** Any unclear aspects requiring clarification

---

## Expected Output

A structured summary like:

```
## Project Context

**Project:** [Name] - [One-line description]

**Phase:** [Planning / Implementation Phase X]

**Tech Stack:**
- [List key technologies]

**Key Files:**
- PRD: .opencode/PRD.md
- Rules: .opencode/AGENTS.md

**Current Focus:**
- [What should be worked on next]

**Questions to Clarify:**
- [Any unclear aspects]
```

---

## Notes

- This command is designed for **new sessions** - when you start working after a break or in a fresh context
- The goal is to get the AI agent "primed" with project knowledge within 30-60 seconds
- If PRD.md doesn't exist, prompt the user to create it first
- If AGENTS.md doesn't exist, prompt the user to run `/create-rules`
