#!/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../commands/logging.sh"

log_info "libreoffice.sh running"

trap 'log_error_detail "libreoffice.sh failed"; exit 1' ERR

if is_installed "libreoffice" "libreoffice"; then
    log_info "LibreOffice already installed, skipping"
else
    export DEBIAN_FRONTEND=noninteractive

    log_info "Updating package index"
    sudo apt update -y -qq 2>/dev/null

    log_info "Installing LibreOffice"
    sudo apt install -y -qq libreoffice 2>/dev/null
fi

log_success "libreoffice.sh completed"
