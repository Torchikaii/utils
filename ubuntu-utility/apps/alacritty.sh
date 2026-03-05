#!/bin/bash

source ~/repos/utils/ubuntu-utility/commands/logging.sh

log "alacritty.sh running"

if dpkg -s alacritty >/dev/null 2>&1; then
    log "Alacritty already installed, skipping"
    exit 0
fi

log "Installing Alacritty"
sudo apt update -qq
sudo apt install -y -qq alacritty

log "alacritty.sh completed"
