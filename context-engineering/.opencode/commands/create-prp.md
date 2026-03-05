# Create PRP: Generate Product Requirements Presentation

## Purpose

Generate a concise Product Requirements Presentation (PRP) for stakeholder alignment.

---

## Output

Write to: `$ARGUMENTS` (default: `.opencode/PRP.md`)

---

## PRP Template

### 1. Title Slide
- Product name
- Version/iteration
- Date

### 2. Problem Statement
- 1-2 sentences on the pain point
- Who is affected

### 3. Solution Overview
- Core value proposition
- Key features (MVP)

### 4. Target Users
- Primary persona
- User count estimate (if known)

### 5. Success Metrics
- 3-5 measurable KPIs

### 6. Timeline
- MVP launch date
- Key milestones

### 7. Risks & Mitigations
- Top 2-3 risks with mitigation

### 8. Next Steps
- Action items
- Decision needed

---

## Instructions

### Step 1: Extract
- Review conversation for requirements
- Identify key value proposition

### Step 2: Synthesize
- Focus on stakeholder-relevant points
- Keep concise

### Step 3: Write
- Use markdown slides format (horizontal rules `---` for slide breaks)
- Maximum 8 slides
- Use bullet points, avoid paragraphs

### Step 4: Review
- Can a stakeholder understand this in 5 minutes?
- Are next steps clear?
