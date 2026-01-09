# VHDL Project - Context Engineering Setup

This README describes the context engineering files and project structure for starting a new VHDL hardware project.

## Project Structure

```
vhdl-project/
├── .claude/
│   ├── PRD.md                    # Project requirements (generated)
│   ├── commands/                 # Command definitions
│   │   ├── core_piv_loop/
│   │   ├── validation/
│   │   └── github_bug_fix/
│   ├── reference/
│   │   ├── VHDL_claude.md        # Workflow commands
│   │   ├── VHDL_prime.md         # Technical context & patterns
│   │   ├── VHDL_create-prd.md    # PRD template
│   │   ├── VHDL_implement.md     # Implementation guide
│   │   └── VHDL_validate.md      # Validation guide
│   └── rules/
│       └── memory-bank/          # Project-specific rules
│
├── src/                          # VHDL source files
│   └── (modules here)
├── tb/                           # Testbenches
│   └── (testbenches here)
├── sim/                          # Simulation outputs
├── synth/                        # Synthesis outputs
├── constraints/                  # Timing/pinout constraints
├── doc/                          # Documentation
├── Makefile                      # Build automation
└── README.md                     # Project README
```

## Context Engineering Files

Read these files in order when starting a new project:

### 1. VHDL_claude.md
**Location:** `.claude/reference/VHDL_claude.md`

**Purpose:** Defines all workflow commands and how to use them

**Key Content:**
- Command structure: `/$WORKFLOW:$COMMAND $ARGUMENTS`
- Core PIV Loop: prime, plan-feature, execute
- Validation workflows: validate, code-review, execution-report
- Bug fix workflows: rca, implement-fix
- Utility commands: commit, init-project, create-prd

**When to Use:** First — understand the workflow framework

---

### 2. VHDL_prime.md
**Location:** `.claude/reference/VHDL_prime.md`

**Purpose:** Technical context, coding standards, and design patterns

**Key Content:**
- VHDL style conventions (naming, formatting, indentation)
- Timing & clocking strategies
- Synthesis considerations
- Semantic patterns (state machines, synchronizers, testbenches)
- File organization conventions
- Testing & verification approach

**When to Use:** Second — establish project standards and patterns

---

### 3. VHDL_create-prd.md
**Location:** `.claude/reference/VHDL_create-prd.md`

**Purpose:** Template for generating PRD.md

**Key Content:**
- PRD structure and sections
- Hardware requirements table
- Interface signals specification
- Module specifications (entity, ports, generics)
- Functional & non-functional requirements
- Success criteria
- Testing strategy

**When to Use:** Third — before running `/create-prd` command

---

### 4. VHDL_implement.md
**Location:** `.claude/reference/VHDL_implement.md`

**Purpose:** Step-by-step implementation process

**Key Content:**
- Entity/architecture skeleton
- Core logic implementation
- Testbench creation
- Simulation & debugging workflow
- Implementation checklist

**When to Use:** Fourth — during `/core_piv_loop:execute`

---

### 5. VHDL_validate.md
**Location:** `.claude/reference/VHDL_validate.md`

**Purpose:** Validation and testing procedures

**Key Content:**
- Behavioral simulation
- Waveform analysis
- Code coverage measurement
- Synthesis verification
- Timing analysis
- Linting & style checks
- Validation checklist & report template

**When to Use:** Fifth — during `/validation:validate`

---

## Getting Started Workflow

### Step 1: Setup Project Structure
```bash
mkdir vhdl-project
cd vhdl-project
mkdir -p .claude/reference .claude/commands .claude/rules
mkdir -p src tb sim synth constraints doc
```

### Step 2: Copy Context Files
Copy these files to `.claude/reference/`:
- VHDL_claude.md
- VHDL_prime.md
- VHDL_create-prd.md
- VHDL_implement.md
- VHDL_validate.md

### Step 3: Read Files in Order
1. Read `VHDL_claude.md` — Understand commands
2. Read `VHDL_prime.md` — Learn standards
3. Read `VHDL_create-prd.md` — Know PRD structure

### Step 4: Generate PRD
```
/create-prd "Your Project Name"
```
This creates `.claude/PRD.md` with your project requirements.

### Step 5: Plan First Module
```
/core_piv_loop:prime
/core_piv_loop:plan-feature "Module Name"
```

### Step 6: Implement
```
/core_piv_loop:execute "Module Name plan"
```
Reference `VHDL_implement.md` during this step.

### Step 7: Validate
```
/validation:validate
```
Reference `VHDL_validate.md` during this step.

---

## File Reference Quick Lookup

| Task | File | Section |
|------|------|---------|
| Understand workflow | VHDL_claude.md | Core PIV Loop Workflow |
| Learn naming conventions | VHDL_prime.md | VHDL Style & Conventions |
| Create PRD | VHDL_create-prd.md | Full template |
| Write entity/architecture | VHDL_implement.md | Step 1-2 |
| Create testbench | VHDL_implement.md | Step 5 |
| Run simulation | VHDL_validate.md | Step 1-2 |
| Check synthesis | VHDL_validate.md | Step 4 |
| Verify timing | VHDL_validate.md | Step 5 |

---

## Context Files Checklist

Before starting a new project, ensure you have:

- [ ] `.claude/reference/VHDL_claude.md`
- [ ] `.claude/reference/VHDL_prime.md`
- [ ] `.claude/reference/VHDL_create-prd.md`
- [ ] `.claude/reference/VHDL_implement.md`
- [ ] `.claude/reference/VHDL_validate.md`
- [ ] `.claude/PRD.md` (generated via `/create-prd`)
- [ ] Project directories created (src/, tb/, sim/, synth/, constraints/)

---

## Next Steps

1. Copy context files to `.claude/reference/`
2. Create project directories
3. Run `/create-prd "Your Project Name"`
4. Read `.claude/PRD.md` to understand requirements
5. Run `/core_piv_loop:prime` to load context
6. Begin implementation with `/core_piv_loop:plan-feature`

---

**Version:** 1.0  
**Last Updated:** [Current Date]
