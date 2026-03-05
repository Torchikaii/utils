#!/bin/bash

source ~/repos/utils/ubuntu-utility/commands/logging.sh

log "vim.sh running"

if dpkg -s vim-gtk3 >/dev/null 2>&1; then
    log "Vim already installed, skipping"
    exit 0
fi

log "Installing Vim"
sudo apt update -qq
sudo apt install -y -qq vim-gtk3

log "vim.sh completed"
