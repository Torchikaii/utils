#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../commands/logging.sh"

log_info "vim.sh running"

trap 'log_error_detail "vim.sh failed"; exit 1' ERR

if is_installed "vim" "vim-gtk3"; then
    log_info "Vim already installed, skipping"
else
    export DEBIAN_FRONTEND=noninteractive

    log_info "Updating package index"
    sudo apt update -y

    log_info "Installing Vim"
    sudo apt install -y vim-gtk3
fi

log_success "vim.sh completed"
