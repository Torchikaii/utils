# Project Requirements Document: Ubuntu Utility

## 1. Project Overview

**Project Name:** Ubuntu Utility  
**Description:** A collection of bash scripts to automate the installation of programs and configuration of an Ubuntu system from a fresh installation.  
**Objectives:**
- Automate the setup of a personal Ubuntu development environment
- Provide idempotent scripts that are safe to re-run
- Maintain consistent dotfiles and configurations across systems

**Scope:**
- **Included:** Application installation scripts, dotfile management, keyboard layout configuration, system services setup
- **Excluded:** Desktop environment customization beyond GNOME defaults, hardware-specific configurations, non-Linux OS support

---

## 2. Requirements

### 2.1 Functional Requirements

| ID | Requirement | Description |
|----|-------------|--------------|
| FR-1 | Main Entry Point | `main.sh` must execute all sub-scripts in correct order |
| FR-2 | Application Installation | Individual scripts must install: docker, terraform, opencode CLI, brave browser, alacritty, keepassxc, p7zip, git, vim, tree |
| FR-3 | Dotfile Management | `dotfiles.sh` must create symlinks from `~/.config` to repository dotfiles |
| FR-4 | Keyboard Configuration | `keyboard.sh` must configure console and GNOME keyboard layouts |
| FR-5 | Service Configuration | Scripts must configure: SSH, CIFS utils (SMB client), NFS common |
| FR-6 | Idempotency | All scripts must be safe to re-run (use `rm -f` before symlinks) |
| FR-7 | Error Handling | Scripts must use `set -e` to fail on errors |

### 2.2 Non-Functional Requirements

| ID | Requirement | Target |
|----|-------------|--------|
| NFR-1 | Compatibility | Ubuntu 20.04+ (LTS versions) |
| NFR-2 | Idempotency | Scripts must not fail on repeated execution |
| NFR-3 | Portability | Assumes utils repository at `~/repos/utils` |
| NFR-4 | Dependencies | Must run with standard bash shell |
| NFR-5 | Safety | No destructive operations beyond intended config replacement |

---

## 3. Technical Specifications

### 3.1 Technology Stack

| Component | Technology |
|-----------|------------|
| Language | Bash (POSIX-compliant) |
| Package Manager | apt, snap |
| Configuration | TOML (Alacritty), Dconf (GNOME) |
| Version Control | Git |

### 3.2 Architecture

```
ubuntu-utility/
├── main.sh              # Entry point - orchestrates all scripts
├── dotfiles.sh          # Symlinks dotfiles to ~/.config
├── keyboard.sh          # Keyboard layout configuration
├── apps/                # Application installation scripts
│   ├── docker.sh
│   ├── terraform.sh
│   ├── brave.sh
│   ├── alacritty.sh
│   ├── opencode.sh
│   ├── keepassxc.sh
│   ├── p7zip.sh
│   ├── git.sh
│   ├── vim.sh
│   └── tree.sh
├── services/            # System service configurations
│   ├── ssh.sh
│   ├── cifs-utils.sh
│   └── nfs-common.sh
└── dotfiles/            # Configuration files (source for symlinks)
    ├── bash/.bashrc
    ├── vim/.vimrc
    ├── keyboard.dconf
    └── alacritty/
        ├── alacritty.toml
        └── themes/
```

### 3.3 Dependencies

- **External Packages:** docker.io, terraform, brave-browser, alacritty, keepassxc, p7zip-full, git, vim, tree, openssh-client, cifs-utils, nfs-common
- **External Services:** Ubuntu apt repositories, Brave Browser APT repository

### 3.4 Constraints

- Repository must be located at `~/repos/utils`
- Requires internet access for package downloads
- Requires sudo privileges for package installation
- Assumes GNOME desktop environment for keyboard.dconf

---

## 4. Success Criteria

### 4.1 Metrics

| Metric | Target |
|--------|--------|
| Scripts Executable | All .sh files have execute permission |
| Idempotency Test | Running `main.sh` twice completes without error |
| Symlink Verification | All dotfiles symlinked correctly to ~/.config |
| Package Verification | Installed packages available in PATH |

### 4.2 Acceptance Criteria

- [ ] `main.sh` executes all sub-scripts without failure
- [ ] Each application script installs the intended package
- [ ] `dotfiles.sh` creates valid symlinks for bash, vim, alacritty configs
- [ ] `keyboard.sh` applies keyboard layout settings
- [ ] Service scripts configure SSH/CIFS/NFS without error
- [ ] All scripts are re-run safe (idempotent)

### 4.3 Performance Targets

- Full execution time: < 30 minutes on fresh Ubuntu
- Individual script execution: < 5 minutes each

---

## 5. Timeline & Resources

### 5.1 Milestones

| Milestone | Status | Notes |
|-----------|--------|-------|
| Core Scripts (main, dotfiles, keyboard) | Complete | Core functionality implemented |
| Application Installation Scripts | Complete | 10 app scripts completed |
| Service Configuration Scripts | Complete | SSH, CIFS, NFS scripts |
| Dotfile Repository | Complete | bash, vim, alacritty configs |

### 5.2 Team

| Role | Responsibility |
|------|----------------|
| Owner/Maintainer | Single user personal project |

### 5.3 Budget

None - all open-source tools and packages.

---

## 6. Risks & Assumptions

### 6.1 Assumptions

- User has fresh Ubuntu 20.04+ installation
- User has sudo privileges
- Internet connection available for package downloads
- Repository cloned to `~/repos/utils`

### 6.2 Risks

| Risk | Impact | Mitigation |
|------|--------|------------|
| External package repository changes | High | Pin package versions; test on each Ubuntu LTS release |
| Path dependency | Medium | Document requirement; add path validation |
| GNOME API changes | Low | keyboard.dconf may need updates for new GNOME versions |
| Breaking changes in Brave/Terraform | Low | Pin versions in install scripts |

### 6.3 Dependencies

- Ubuntu apt repositories
- Brave Browser APT repository
- Terraform downloads (HashiCorp)

---

## 7. Deliverables

### 7.1 Tangible Outputs

| Deliverable | Location |
|-------------|----------|
| Main entry script | `ubuntu-utility/main.sh` |
| Application scripts | `ubuntu-utility/apps/*.sh` |
| Service scripts | `ubuntu-utility/services/*.sh` |
| Dotfile manager | `ubuntu-utility/dotfiles.sh` |
| Keyboard config | `ubuntu-utility/keyboard.sh` |
| Configuration files | `ubuntu-utility/dotfiles/**` |

### 7.2 Documentation

- Project README at `ubuntu-utility/README.md`
- Inline comments in all shell scripts

### 7.3 Testing

- Manual execution on fresh Ubuntu VM
- Idempotency verification (re-run test)
- Symlink verification via `ls -la ~/.config`

---

*Document Version: 1.0*  
*Last Updated: 2026-02-27*
