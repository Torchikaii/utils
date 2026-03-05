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
    sudo apt update -y

    log_info "Installing cifs-utils and smbclient"
    sudo apt install -y cifs-utils smbclient
fi

log_success "cifs-utils.sh completed"
