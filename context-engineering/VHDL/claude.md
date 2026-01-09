# Agent Workflow Guide - VHDL Projects

This document defines workflows and commands that any AI agent should understand and execute for VHDL hardware development.

## Command Structure

All commands follow the pattern:
```
/$WORKFLOW:$COMMAND $ARGUMENTS
```

Where:
- `$WORKFLOW` — Workflow category (core_piv_loop, validation, github_bug_fix, etc.)
- `$COMMAND` — Specific action within workflow
- `$ARGUMENTS` — Optional parameters (module names, feature names, etc.)

---

## Core PIV Loop Workflow

**Purpose:** Prime, Implement, Validate loop for hardware module development

### `/core_piv_loop:prime`

**What it does:** Load project context and establish shared understanding

**Expected behavior:**
1. Read and parse `prime.md` (technical context)
2. Read and parse `PRD.md` (requirements)
3. Read project structure and key VHDL files
4. Summarize understanding of:
   - Module hierarchy and interfaces
   - Signal naming conventions
   - Simulation and synthesis tools
   - Timing constraints and clock domains
   - Key design patterns and idioms
5. Ask clarifying questions if needed
6. Confirm readiness to proceed

**Example:**
```
/core_piv_loop:prime
```

---

### `/core_piv_loop:plan-feature $MODULE_NAME`

**What it does:** Create comprehensive implementation plan with codebase analysis

**Arguments:**
- `$MODULE_NAME` — Module to implement (e.g., "SPI Slave", "Timer Core", "Packet Decoder")

**Expected behavior:**
1. Analyze existing VHDL modules for related patterns
2. Identify affected modules and interfaces
3. Create step-by-step implementation plan
4. Specify:
   - VHDL files to create/modify
   - Entity/architecture structure
   - Signal interfaces and dependencies
   - Testbench approach
   - Timing and resource considerations
5. Present plan for approval before proceeding

**Example:**
```
/core_piv_loop:plan-feature "SPI Slave Interface"
```

---

### `/core_piv_loop:execute $PLAN_REFERENCE`

**What it does:** Execute implementation plan step-by-step

**Arguments:**
- `$PLAN_REFERENCE` — Reference to approved plan (e.g., "SPI Slave plan", or step number)

**Expected behavior:**
1. Execute plan steps sequentially
2. After each step:
   - Show VHDL code changes
   - Explain architecture decisions
   - Validate against requirements
3. Ask for confirmation before proceeding to next step
4. Handle errors and suggest fixes
5. Generate summary upon completion

**Example:**
```
/core_piv_loop:execute "SPI Slave plan"
/core_piv_loop:execute step-2
```

---

## Validation Workflow

**Purpose:** Comprehensive testing, synthesis, and quality assurance

### `/validation:validate`

**What it does:** Run full validation suite

**Expected behavior:**
1. Run all testbenches (behavioral simulation)
2. Run timing simulation (if applicable)
3. Verify synthesis (check for warnings/errors)
4. Verify timing closure (setup/hold times)
5. Check code coverage (>80% target)
6. Run linting checks (VHDL style)
7. Generate validation report with:
   - Simulation pass/fail status
   - Synthesis resource utilization
   - Timing analysis results
   - Coverage metrics
   - Any warnings or issues
   - Recommendations

**Example:**
```
/validation:validate
```

---

### `/validation:code-review`

**What it does:** Technical code review on changed VHDL files

**Expected behavior:**
1. Identify all modified VHDL files since last commit
2. Review for:
   - VHDL style and naming conventions
   - Potential timing issues (metastability, clock domains)
   - Synthesis warnings
   - Logic errors or edge cases
   - Adherence to project patterns
   - Resource efficiency
3. Generate findings with:
   - File and line number
   - Issue severity (Critical, High, Medium, Low, Info)
   - Description and suggested fix
4. Prioritize by severity

**Example:**
```
/validation:code-review
```

---

### `/validation:code-review-fix`

**What it does:** Fix issues found in code review

**Expected behavior:**
1. Read code review findings
2. For each issue:
   - Explain the fix
   - Apply the fix to VHDL code
   - Validate fix doesn't break testbenches
3. Generate summary of fixes applied
4. Re-run code review to confirm issues resolved

**Example:**
```
/validation:code-review-fix
```

---

### `/validation:execution-report`

**What it does:** Generate report after implementing a module

**Expected behavior:**
1. Summarize what was implemented
2. List all VHDL files created/modified
3. Show simulation results and coverage
4. Report synthesis resource usage
5. Highlight any deviations from plan
6. Document lessons learned
7. Provide recommendations for next steps

**Example:**
```
/validation:execution-report
```

---

### `/validation:system-review`

**What it does:** Analyze implementation vs plan for process improvements

**Expected behavior:**
1. Compare actual implementation to original plan
2. Identify:
   - What went well
   - What took longer than expected
   - Unexpected timing or resource issues
   - Opportunities for optimization
3. Suggest process improvements
4. Update prime.md if new patterns discovered

**Example:**
```
/validation:system-review
```

---

## Bug Fix Workflow

**Purpose:** Structured approach to identifying and fixing hardware bugs

### `/github_bug_fix:rca $ISSUE_ID`

**What it does:** Create root cause analysis document for a GitHub issue

**Arguments:**
- `$ISSUE_ID` — GitHub issue number or description

**Expected behavior:**
1. Understand the bug from issue description
2. Analyze VHDL code and testbenches to find root cause
3. Create RCA document with:
   - Bug description and symptoms
   - Root cause analysis (timing, logic, synthesis issue)
   - Affected modules/files
   - Reproduction steps (testbench scenario)
   - Proposed fix approach
4. Present RCA for review before implementing

**Example:**
```
/github_bug_fix:rca #42
/github_bug_fix:rca "Timer interrupt not firing"
```

---

### `/github_bug_fix:implement-fix $RCA_REFERENCE`

**What it does:** Implement fix based on RCA document

**Arguments:**
- `$RCA_REFERENCE` — Reference to RCA document

**Expected behavior:**
1. Read RCA document
2. Implement fix in VHDL code following proposed approach
3. Add testbench case that reproduces original bug
4. Verify test now passes
5. Run full validation suite
6. Generate fix summary with:
   - Files changed
   - Simulation results
   - Verification steps

**Example:**
```
/github_bug_fix:implement-fix "Timer interrupt RCA"
```

---

## Utility Workflows

### `/commit $MESSAGE`

**What it does:** Create atomic commit with appropriate tag

**Arguments:**
- `$MESSAGE` — Commit message (feature description)

**Expected behavior:**
1. Determine commit type based on changes:
   - `feat:` — New module or feature
   - `fix:` — Bug fix
   - `docs:` — Documentation
   - `refactor:` — Code refactoring
   - `test:` — Testbench additions
2. Create commit with format: `$TYPE: $MESSAGE`
3. Show commit hash and summary

**Example:**
```
/commit "Add SPI slave interface module"
/commit "Fix timer interrupt timing issue"
```

---

### `/init-project`

**What it does:** Setup development environment and verify tools

**Expected behavior:**
1. Check prerequisites (VHDL compiler, simulator, synthesis tool)
2. Verify tool versions match project requirements
3. Create necessary directories (sim, synth, build)
4. Compile VHDL libraries if needed
5. Verify testbenches compile
6. Provide tool setup instructions and next steps

**Example:**
```
/init-project
```

---

### `/create-prd`

**What it does:** Generate Product Requirements Document from conversation

**Expected behavior:**
1. Analyze conversation history
2. Extract requirements, features, constraints
3. Generate PRD.md with sections:
   - Project Overview
   - Value Proposition
   - Core Features
   - Technical Specifications
   - Functional Requirements
   - Non-Functional Requirements
   - Architecture Overview
   - Success Criteria
   - Testing Strategy
4. Save to project root
5. Ask for review and refinements

**Example:**
```
/create-prd
```

---

## Command Execution Rules

**All agents should follow these rules:**

1. **Context Loading**
   - Always load `prime.md` and `PRD.md` before starting work
   - Ask for clarification if context is incomplete

2. **Planning Before Implementation**
   - Never skip the planning step
   - Get approval before implementing
   - Break large modules into smaller steps

3. **Validation After Changes**
   - Always run testbenches after code changes
   - Check synthesis for warnings
   - Verify timing closure
   - Check for regressions

4. **Communication**
   - Show VHDL code changes clearly
   - Explain architecture and timing decisions
   - Flag potential metastability or timing issues
   - Ask for confirmation on ambiguous decisions

5. **Error Handling**
   - If a command fails, explain why
   - Suggest alternative approaches
   - Ask for additional information if needed

6. **Documentation**
   - Update relevant documentation after changes
   - Keep prime.md current with new patterns
   - Document decisions in commit messages

---

## Workflow Examples

### Example 1: Implement New Module

```
User: /core_piv_loop:prime
Agent: [Loads context, summarizes understanding]

User: /core_piv_loop:plan-feature "Packet Decoder"
Agent: [Creates detailed plan, asks for approval]

User: Looks good, proceed
Agent: /core_piv_loop:execute "Packet Decoder plan"
Agent: [Implements step by step, validates each step]

User: /validation:validate
Agent: [Runs testbenches, synthesis, reports results]

User: /commit "Add packet decoder module"
Agent: [Creates commit with appropriate tag]
```

### Example 2: Fix a Timing Bug

```
User: /github_bug_fix:rca "Clock domain crossing issue"
Agent: [Analyzes code, creates RCA document]

User: Looks correct, implement the fix
Agent: /github_bug_fix:implement-fix "Clock domain RCA"
Agent: [Implements fix, adds testbench, validates]

User: /validation:code-review
Agent: [Reviews changes for quality]

User: /commit "Fix clock domain crossing metastability"
Agent: [Creates commit]
```

---

## Context Files Reference

| File | Purpose | When to Use |
|------|---------|------------|
| `prime.md` | Technical context and patterns | Start of every session |
| `PRD.md` | Requirements and specifications | Planning and validation |
| `claude.md` | This file - workflow definitions | Reference for commands |
| `.claude/commands/` | Command definitions | Discovered dynamically |

---

## Notes for Agents

- These commands are **agent-agnostic** — any AI assistant should understand them
- The workflow emphasizes **planning before implementation** and **validation after changes**
- Always prioritize **clarity and communication** over speed
- When in doubt, **ask for clarification** rather than assume
- Keep **prime.md updated** as new patterns emerge
- VHDL-specific: Always consider **timing, clock domains, and synthesis implications**

---

## Understanding Command Syntax

If you see a slash followed by a directory name, a colon, and a filename (e.g., `/core_piv_loop:prime`), and that markdown file exists in `.claude/commands/`, it's a command.

**Pattern:** `/$DIRECTORY:$COMMAND $ARGUMENTS`

The agent will:
1. Look for `.claude/commands/$DIRECTORY/$COMMAND.md`
2. Read the command definition
3. Execute the specified behavior
4. Pass `$ARGUMENTS` to the command

This allows commands to be defined as markdown files and discovered dynamically.

---

**Last Updated:** [Current Date]  
**Version:** 1.0
