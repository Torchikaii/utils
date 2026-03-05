# Create ADR: Generate Architecture Decision Record

## Purpose

Document a significant architectural decision using the ADR format.

---

## Output

Write to: `$ARGUMENTS` (default: `.opencode/ADR.md`)

---

## ADR Template

### ADR-N: Title

**Status:** Proposed | Accepted | Deprecated | Superseded

**Date:** YYYY-MM-DD

**Context:**
Describe the problem or situation that prompted this decision.

**Decision:**
Describe the choice that was made.

**Consequences:**
- **Positive:** Benefits gained
- **Negative:** Drawbacks or costs
- **Neutral:** Things that remain unchanged

---

### Alternatives Considered

| Option | Pros | Cons |
|--------|------|------|
| Option A | ... | ... |
| Option B | ... | ... |
| ... | ... | ... |

---

## Instructions

### Step 1: Identify Decision
- What architectural choice needs documenting?
- Why does it matter?

### Step 2: Research
- What alternatives exist?
- What are the trade-offs?

### Step 3: Write
- Be concise
- Focus on "why" not just "what"
- Include consequences

### Step 4: Link
- Link to related PRDs, specs, or ADRs
- Include ticket numbers if applicable
