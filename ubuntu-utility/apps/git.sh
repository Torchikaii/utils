#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../commands/logging.sh"

log_info "git.sh running"

trap 'log_error_detail "git.sh failed"; exit 1' ERR

if is_installed "git" "git"; then
    log_info "Git already installed, skipping"
else
    export DEBIAN_FRONTEND=noninteractive

    log_info "Updating package index"
    sudo apt update -y

    log_info "Installing Git"
    sudo apt install -y git
fi

log_success "git.sh completed"
