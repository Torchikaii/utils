### Context Engineering

Templates for generating project artifacts using OpenCode commands.

#### Available Commands

- `/create-prd` - Product Requirements Document (comprehensive)
- `/create-prp` - Product Requirements Presentation (stakeholder slide deck)
- `/create-spec` - Technical Specification (engineering implementation)
- `/create-adr` - Architecture Decision Record (architectural choices)

#### Usage

Run in OpenCode: `/create-prd path/to/output.md`

#### Structure

```
context-engineering/
└── .opencode/
    └── commands/
        ├── create-prd.md
        ├── create-prp.md
        ├── create-spec.md
        └── create-adr.md
```
