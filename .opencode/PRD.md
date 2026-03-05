# Product Requirements Document: Utils Repo Improvement

## 1. Executive Summary

This document outlines the improvements needed for the `/utils` repository - a personal toolbox containing context engineering files, Ubuntu workstation setup scripts, and various utilities. The core value proposition is a "throw laptop into sea and run main.sh" idempotent recovery system. The MVP goal is to complete context engineering templates, standardize ubuntu-utility output, add installation pre-checks, and improve documentation.

## 2. Mission & Principles

**Mission:** Create a self-documenting, robust utilities repository that enables instant workstation recovery with minimal human intervention.

**Core Principles:**
- Idempotency: All scripts safe to re-run
- Minimalism: Only display essential progress/error messages
- Fail Fast: Check preconditions before operations, show detailed errors when they occur
- Self-Documenting: Consistent patterns and README files for every substantial subfolder

## 3. Target Users

**Primary User:** Single-user personal setup (the repository owner)
**Technical Comfort Level:** High - comfortable with CLI, bash scripting, and system administration
**Key Pain Points:**
- Loss of workstation requires manual reinstall of ~20 apps
- Inconsistent script output makes automation monitoring difficult
- Missing documentation makes future modifications time-consuming
- Verbose apt output hides actual progress

## 4. Scope

### In Scope (MVP) — ✅

- [ ] Standardized timestamped echo messages across all ubuntu-utility scripts
- [ ] Installation pre-checks (skip if already installed) for all apps
- [ ] Create missing context-engineering command templates (PRP, ADR, SPEC)
- [ ] Add subfolder README.md files for context-engineering and docs
- [ ] Update all existing scripts to use new patterns

### Out of Scope — ❌

- Adding new apps to ubuntu-utility (future phase)
- Creating a global .opencode/commands structure (not needed)
- Migrating to alternative package managers
- Cross-platform support (Windows, macOS)

## 5. User Stories

1. **"As a** user **I want** all scripts to output consistent timestamped messages **so that** I can easily parse logs and understand what's happening."

2. **"As a** user **I want** scripts to check if apps are installed before attempting installation **so that** re-running main.sh completes quickly without unnecessary operations."

3. **"As a** user **I want** context-engineering to have multiple command templates **so that** I can generate different artifact types for my projects."

4. **"As a** user **I want** each substantial subfolder to have its own README.md **so that** I can understand what each folder does at a glance.**

5. **"As a** user **I want** scripts to show detailed error messages on failure **so that** I can quickly diagnose what went wrong.**

6. **"As a** user **I want** ubuntu-utility to run silently during normal operation **so that** I only see important progress messages.**

## 6. Architecture & Design

### Directory Structure

```
utils/
├── .opencode/
│   └── commands/                    # Global commands (empty, uses context-engineering)
├── context-engineering/
│   └── .opencode/
│       └── commands/
│           ├── create-prd.md       # Existing
│           ├── create-prp.md       # New - Product Requirements Presentation
│           ├── create-spec.md      # New - Technical Specification
│           └── create-adr.md       # New - Architecture Decision Record
│   └── README.md                   # New - Subfolder documentation
├── ubuntu-utility/
│   ├── commands/
│   │   └── utils.sh                 # New - Shared logging functions
│   ├── apps/                        # All *.sh files updated
│   ├── services/                    # All *.sh files updated
│   ├── dotfiles.sh                  # Updated
│   ├── keyboard.sh                  # Updated
│   └── main.sh                      # Updated
├── docs/
│   └── README.md                    # New - Subfolder documentation
├── README.md                        # Existing - keep concise
├── BOM-reconstructor/
│   └── README.md                    # Existing
├── cd-NAS/
│   └── README.md                    # Existing
```

### Key Design Patterns

1. **Logging Function:** Single source of truth in `commands/utils.sh` with:
   - `log_info "message"` - timestamped info messages
   - `log_error "message"` - detailed error with exit code
   - `log_success "message"` - completion messages

2. **Installation Check Pattern:**
   ```bash
   if command -v <binary> >/dev/null 2>&1 || dpkg -s <package> >/dev/null 2>&1; then
       log_info "<app> already installed, skipping"
       return 0
   fi
   ```

3. **Echo Format:**
   - `[YYYY-MM-DD HH:MM:SS] <script-name> running`
   - `[YYYY-MM-DD HH:MM:SS] Installing <app>...`
   - `[YYYY-MM-DD HH:MM:SS] <script-name> completed`

## 7. Technology Stack

- **Shell:** Bash (POSIX compliant)
- **Tools:** coreutils (date, grep, awk), apt, dpkg, systemctl, dconf
- **No external dependencies** for scripts (self-contained)

## 8. Security & Configuration

- Scripts use `sudo` for system modifications (required for apt installs)
- No secrets stored in repository
- Scripts are idempotent (safe to re-run)
- CI detection via `CI` env var to skip hardware-specific operations

## 9. Success Criteria

- [ ] All ubuntu-utility/*.sh scripts use consistent timestamped logging
- [ ] All app installation scripts check if app is already installed
- [ ] context-engineering has at least 3 command templates (PRD, PRP, ADR or SPEC)
- [ ] context-engineering/ and docs/ each have README.md files
- [ ] Re-running main.sh completes in <30 seconds when all apps installed
- [ ] Error messages include file path, error code, and context

## 10. Implementation Phases

### Phase 1: Foundation
- [ ] Create `ubuntu-utility/commands/utils.sh` with logging functions
- [ ] Test logging functions work correctly
- [ ] **Deliverables:** `commands/utils.sh` with `log_info`, `log_error`, `log_success`

### Phase 2: Core Scripts Update
- [ ] Update `main.sh` to include logging header/footer
- [ ] Update `dotfiles.sh` with new logging and install checks
- [ ] Update `keyboard.sh` with new logging (keep CI detection)
- [ ] **Deliverables:** Core scripts using new patterns

### Phase 3: App Scripts
- [ ] Update all `apps/*.sh` with install checks and logging
- [ ] Update all `services/*.sh` with install checks and logging
- [ ] **Deliverables:** All app/service scripts updated

### Phase 4: Context Engineering
- [ ] Create `create-prp.md` template
- [ ] Create `create-spec.md` template  
- [ ] Create `create-adr.md` template
- [ ] **Deliverables:** 3 new command templates

### Phase 5: Documentation
- [ ] Create `context-engineering/README.md`
- [ ] Create `docs/README.md`
- [ ] Review and update root `README.md` if needed
- [ ] **Deliverables:** Subfolder READMEs complete

### Phase 6: Validation
- [ ] Run `main.sh` on fresh Ubuntu (or VM)
- [ ] Verify idempotency (re-run main.sh)
- [ ] Verify log output format matches requirements
- [ ] **Deliverables:** All tests pass

## 11. Risks & Mitigations

| Risk | Impact | Mitigation |
|------|--------|------------|
| Breaking existing scripts | High | Test each script individually before running full main.sh |
| Installation check false positives | Medium | Use multiple check methods (command -v AND dpkg -s) |
| Timestamps cause issues | Low | Use ISO format, strip colons if needed for specific tools |
| brave.sh installer changes | Medium | Check brave.sh works, may need update to install method |

## 12. Future Considerations

- Add support for more Linux distributions (Debian, Fedora)
- Create homebrew-based install option for macOS
- Add configuration file for customizable app selection
- Add support for dotfile repository URL as parameter
