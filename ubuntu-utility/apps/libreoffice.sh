#!/bin/bash

source ~/repos/utils/ubuntu-utility/commands/logging.sh

log "libreoffice.sh running"

if dpkg -s libreoffice >/dev/null 2>&1; then
    log "LibreOffice already installed, skipping"
    exit 0
fi

log "Installing LibreOffice"
sudo apt update -qq
sudo apt install -y -qq libreoffice

log "libreoffice.sh completed"
