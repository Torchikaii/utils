# Context Engineering

Boilerplate for context-driven development using OpenCode commands. Copy `.opencode/` folder to any project (greenfield or brownfield) to start.

---

## Workflow

```
SESSION 1: Initial Planning
├── 1. Describe project idea (or analyze brownfield)
│   └── Ask clarifying questions to user
├── 2. /create-prd → .opencode/PRD.md
└── 3. /create-rules → .opencode/AGENTS.md

SESSION 2: Feature Planning
├── 1. /prime → loads PRD + AGENTS + progress context
├── 2. /plan-feature → .opencode/plans/phase-1-plan.md
└── (optional: iterate within session)

SESSION 3: Execution
├── 1. /prime → loads context + current state
├── 2. /execute phase-1-plan.md
│   └── AI validates as it goes (tests, checks)
└── 3. AI reports completion in chat
    └── Human reviews → marks ✅ in .opencode/progress/current.md

REPEAT Sessions 2-3 for each phase

PERIODIC:
├── /document-project → updates folder docs
└── /rewrite-prd → rewrites PRD.md based on progress
```

---

## Commands

| Command | Description |
|---------|-------------|
| `/create-prd` | Generate PRD.md from conversation |
| `/create-rules` | Generate AGENTS.md from template + PRD |
| `/prime` | Load project context in new session |
| `/plan-feature` | Create phase-X-plan.md in plans/ |
| `/execute <plan>` | Execute plan with validation |
| `/document-project` | Create folder documentation |
| `/rewrite-prd` | Rewrite PRD based on progress |

---

## Structure

```
.opencode/
├── AGENTS-template.md      # Template for AI agent rules
├── PRD.md                  # Product Requirements Document
├── AGENTS.md               # Generated agent rules
├── commands/
│   ├── create-prd.md
│   ├── create-rules.md
│   ├── prime.md
│   ├── plan-feature.md
│   ├── execute.md
│   ├── document-project.md
│   └── rewrite-prd.md
├── progress/
│   └── current.md          # Human marks ✅ completed tasks
└── plans/
    └── phase-X-plan.md      # Implementation plans
```

---

## Usage

1. Copy `.opencode/` folder to your project
2. Open OpenCode in the project
3. Follow the workflow above

---

## Key Concepts

- **PRD.md** - Brief product overview, updated periodically with `/rewrite-prd`
- **AGENTS.md** - Coding rules for AI agents, generated from template
- **progress/current.md** - Human-only marks ✅ completed tasks
- **phase-X-plan.md** - Detailed implementation plans
- **Folder docs** - `<foldername>.README.md` in relevant subfolders
