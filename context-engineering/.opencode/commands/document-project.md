# Document Project: Generate Folder Documentation

## Purpose

Document the project structure by creating `<foldername>.README.md` files in relevant subfolders. Run this command after `/prime` to document an existing project.

---

## Output

Creates `<foldername>.README.md` files in subfolders based on the sweet spot rules below.

---

## Sweet Spot Rules

Decide whether a folder needs documentation:

| Folder Type | Decision | Reasoning |
|-------------|----------|-----------|
| **Root** | ALWAYS | Project overview |
| **Large/diverse subfolders** | YES | Multiple concerns, needs explanation |
| **Small/simple folders** (few files, single purpose) | NO | Reference in parent README instead |
| **Sub-subfolders of diverse parent** | BRIEF | Parent explains they have their own docs |
| **Leaf folders** (specific functionality) | INDEPTH if complex | Skip if self-explanatory |

### Decision Flow

```
Is this the root folder?
  YES → Create <foldername>.README.md
  NO
    Is this folder diverse (multiple subfolders with different purposes)?
      YES → Create brief README explaining subfolders have their own docs
      NO
        Does this folder contain complex logic or multiple files with different roles?
          YES → Create in-depth README
          NO → Skip (reference in parent's README)
```

---

## Content Guidelines

### Root README (Briefest)

- Project name and one-line description
- Tech stack
- High-level directory structure
- Setup instructions (dev/prod if applicable)
- How to run/build

### Primary Subfolder README (In-depth)

- Purpose: What this folder contains and why
- Structure: Tree view of immediate contents
- Key files: Brief description of important files
- Usage: How other parts of the project use this

### Sub-subfolder README (Brief or In-depth)

- Depends on complexity
- If parent already explains, keep very brief
- If standalone complex component, document in-depth

---

## Instructions

### Step 1: Explore Project Structure

Run `ls -la` and `find` commands to understand:
- All directories and their purposes
- File types and organization
- Configuration vs source vs tests

### Step 2: Map the Tree

Create a mental map:
- Root folders and their purposes
- Which folders are diverse (contain multiple concerns)
- Which folders are simple/leaves

### Step 3: Apply Sweet Spot Rules

For each folder, decide:
1. Does it need documentation?
2. How detailed should it be?

### Step 4: Write Each README

**Naming:** `<foldername>.README.md` (e.g., `src/README.md`, `backend/README.md`)

**Root README Template:**
```
# Project Name

Brief description (1-2 sentences).

## Tech Stack

- [List key technologies]

## Structure

```
project/
├── folder1/          # Purpose
├── folder2/          # Purpose
└── folder3/          # Purpose
```

## Setup

[How to install/run]
```

**Subfolder README Template:**
```
# foldername

Purpose: What this folder contains and its role in the project.

## Structure

```
foldername/
├── subfolder1/       # Purpose
├── file1.js         # Purpose
└── file2.js         # Purpose
```

## Key Files

- **file1.js** - [Brief description]
- **file2.js** - [Brief description]

## Usage

[How other parts use this]
```

### Step 5: Validate

- No redundant information across READMEs
- Each README has a clear purpose
- Tree structures are accurate
- No fluff sentences

---

## Quality Checklist

- [ ] Root folder always documented
- [ ] Large/diverse folders have their own docs
- [ ] Simple folders skipped (referenced in parent instead)
- [ ] No sentences like "This folder contains important files"
- [ ] Tree structures are accurate and concise
- [ ] Each README answers: "What is this folder for?"
- [ ] No duplicate information across READMEs

---

## Notes

- Be selective - better fewer quality docs than many half-hearted ones
- If unsure whether a folder needs docs, lean towards skipping
- A folder with 2-3 simple files doesn't need its own README
- Configuration folders (`config/`, `.github/`) typically don't need docs unless complex
- Test folders (`tests/`, `__tests__`) usually don't need docs if structure mirrors src
