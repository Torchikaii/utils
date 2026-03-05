#!/bin/bash

source ~/repos/utils/ubuntu-utility/commands/logging.sh

log "brave.sh running"

if dpkg -s brave-browser >/dev/null 2>&1; then
    log "Brave already installed, skipping"
    exit 0
fi

log "Installing Brave Browser"
sudo apt update -qq
sudo apt install -y -qq curl
curl -fsS https://dl.brave.com/install.sh | bash

log "brave.sh completed"
