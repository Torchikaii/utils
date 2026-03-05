#!/bin/bash

source ~/repos/utils/ubuntu-utility/commands/logging.sh

log "p7zip.sh running"

if dpkg -s p7zip-full >/dev/null 2>&1; then
    log "p7zip-full already installed, skipping"
    exit 0
fi

log "Installing p7zip-full"
sudo apt update -qq
sudo apt install -y -qq p7zip-full

log "p7zip.sh completed"
