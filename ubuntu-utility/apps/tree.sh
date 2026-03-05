#!/bin/bash

source ~/repos/utils/ubuntu-utility/commands/logging.sh

log "tree.sh running"

if dpkg -s tree >/dev/null 2>&1; then
    log "Tree already installed, skipping"
    exit 0
fi

log "Installing Tree"
sudo apt update -qq
sudo apt install -y -qq tree

log "tree.sh completed"
