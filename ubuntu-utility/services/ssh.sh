#!/bin/bash

source ~/repos/utils/ubuntu-utility/commands/logging.sh

log "ssh.sh running"

if dpkg -s openssh-server >/dev/null 2>&1; then
    log "OpenSSH server already installed, skipping"
    exit 0
fi

log "Installing openssh-server"
sudo apt update -qq
sudo apt install -y -qq openssh-server
sudo systemctl enable ssh --now

log "ssh.sh completed"
