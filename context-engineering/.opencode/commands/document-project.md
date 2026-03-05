# Document Project: Generate Folder Documentation

## Purpose

Document the project structure by creating `<foldername>.README.md` files in relevant subfolders. Run this command after `/prime` to document an existing project.

---

## Output

Creates `<foldername>.README.md` files in subfolders based on the sweet spot rules below.

---

## README Naming

| Folder Level | Filename |
|--------------|----------|
| Root | `README.md` |
| Subfolder & Sub-subfolder | `<foldername>.README.md` |

---

## Sweet Spot Rules

Decide whether a folder needs documentation:

| Folder Type | Decision | Depth | Reasoning |
|-------------|----------|-------|-----------|
| **Root** | ALWAYS | Brief | Project overview |
| **Subfolder with diverse children** (e.g., `/flask` has `/backend` + `/frontend`) | YES | Brief | Mention children have own docs |
| **Subfolder with single purpose** (e.g., `/terraform` - one function) | YES | In-depth | Full documentation |
| **Sub-subfolder** (independently complex/diverse) | YES | In-depth | Same as subfolder |
| **Sub-subfolder** (simple, few files) | NO | - | Reference in parent instead |
| **Small/simple folders** (few files, single purpose) | NO | - | Reference in parent README |

### Decision Flow

```
Is this the root folder?
  YES → Create README.md (brief)

  NO → Is this folder diverse (contains multiple subfolders with DIFFERENT purposes)?
    YES → Create <foldername>.README.md (brief, mention children have own docs)

    NO → Does this folder serve a single, specific purpose?
      YES → Create <foldername>.README.md (in-depth)
      NO → Skip (reference in parent's README)
```

### Example

```
flask/                     # Diverse children → brief README
├── backend/               # Independent function → in-depth README
└── frontend/              # Independent function → in-depth README

terraform/                 # Single purpose → in-depth README
├── main.tf
└── variables.tf
```

---

## Detect Changes

Every time this command runs, you MUST:

1. **Grep full file structure** - Get complete directory listing
2. **Run `git diff`** - Detect any file/folder changes since last documentation
3. **If changes found** → Update/create READMEs accordingly
4. **Check existing READMEs** - If they don't exist or don't follow conventions → create/update them

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

### Step 1: Detect Changes

1. Run `git diff` to see what changed
2. Get full file structure: `find . -type f -o -type d | head -100` (adjust as needed)
3. Check which folders are new/modified
4. Identify existing READMEs and check if they follow conventions

### Step 2: Explore Project Structure

If no git repo or first run, understand:
- All directories and their purposes
- File types and organization
- Configuration vs source vs tests

### Step 3: Map the Tree

Create a mental map:
- Root folders and their purposes
- Which folders are diverse (contain multiple concerns)
- Which folders are simple/leaves
- Which subfolders have children with independent functions

### Step 4: Apply Sweet Spot Rules

For each folder, decide:
1. Does this folder need documentation?
2. How detailed should it be?

### Step 5: Write Each README

**Naming:** Root = `README.md`, Others = `<foldername>.README.md`

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

### Step 6: Validate

- No redundant information across READMEs
- Each README has a clear purpose
- Tree structures are accurate
- No fluff sentences
- Naming follows convention (root = README.md, others = <foldername>.README.md)
- All changes detected and documented

---

## Quality Checklist

- [ ] Root folder always documented as README.md
- [ ] Subfolders documented as <foldername>.README.md
- [ ] Diverse subfolders (with multiple independent children) have brief docs
- [ ] Single-purpose subfolders have in-depth docs
- [ ] Simple folders skipped (referenced in parent instead)
- [ ] No sentences like "This folder contains important files"
- [ ] Tree structures are accurate and concise
- [ ] Each README answers: "What is this folder for?"
- [ ] No duplicate information across READMEs
- [ ] git diff run and changes documented
- [ ] Existing READMEs checked for convention compliance

---

## Notes

- Be selective - better fewer quality docs than many half-hearted ones
- If unsure whether a folder needs docs, lean towards skipping
- A folder with 2-3 simple files doesn't need its own README
- Configuration folders (`config/`, `.github/`) typically don't need docs unless complex
- Test folders (`tests/`, `__tests__`) usually don't need docs if structure mirrors src
