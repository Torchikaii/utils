#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../commands/logging.sh"

log_info "p7zip.sh running"

trap 'log_error_detail "p7zip.sh failed"; exit 1' ERR

if is_installed "7z" "p7zip-full"; then
    log_info "p7zip-full already installed, skipping"
else
    export DEBIAN_FRONTEND=noninteractive

    log_info "Updating package index"
    sudo apt update -y

    log_info "Installing p7zip-full"
    sudo apt install -y p7zip-full
fi

log_success "p7zip.sh completed"
