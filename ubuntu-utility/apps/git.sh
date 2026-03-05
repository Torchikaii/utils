#!/bin/bash

source ~/repos/utils/ubuntu-utility/commands/logging.sh

log "git.sh running"

if dpkg -s git >/dev/null 2>&1; then
    log "Git already installed, skipping"
    exit 0
fi

log "Installing Git"
sudo apt update -qq
sudo apt install -y -qq git

log "git.sh completed"
