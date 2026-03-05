#!/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/commands/logging.sh"

log_info "ubuntu-utility main.sh running"

trap 'log_error_detail "Script failed"; exit 1' ERR

# apps
bash "$SCRIPT_DIR/apps/docker.sh"
bash "$SCRIPT_DIR/apps/terraform.sh"
bash "$SCRIPT_DIR/apps/opencode.sh"
bash "$SCRIPT_DIR/apps/brave.sh"
bash "$SCRIPT_DIR/apps/alacritty.sh"
bash "$SCRIPT_DIR/apps/keepassxc.sh"
bash "$SCRIPT_DIR/apps/libreoffice.sh"
bash "$SCRIPT_DIR/apps/p7zip.sh"
bash "$SCRIPT_DIR/apps/git.sh"
bash "$SCRIPT_DIR/apps/vim.sh"
bash "$SCRIPT_DIR/apps/tree.sh"
bash "$SCRIPT_DIR/apps/pyenv.sh"
bash "$SCRIPT_DIR/apps/python.sh"

# services
bash "$SCRIPT_DIR/services/ssh.sh"
bash "$SCRIPT_DIR/services/cifs-utils.sh"

# system configuration
bash "$SCRIPT_DIR/dotfiles.sh"
bash "$SCRIPT_DIR/keyboard.sh"

log_success "ubuntu-utility main.sh completed"
