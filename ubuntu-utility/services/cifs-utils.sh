#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../commands/logging.sh"

log_info "cifs-utils.sh running"

trap 'log_error_detail "cifs-utils.sh failed"; exit 1' ERR

if is_installed "mount.cifs" "cifs-utils" && is_installed "smbclient" "smbclient"; then
    log_info "cifs-utils and smbclient already installed, skipping"
else
    export DEBIAN_FRONTEND=noninteractive

    log_info "Updating package index"
    sudo apt update -y -qq 2>/dev/null

    log_info "Installing cifs-utils and smbclient"
    sudo apt install -y -qq cifs-utils smbclient 2>/dev/null
fi

log_success "cifs-utils.sh completed"
