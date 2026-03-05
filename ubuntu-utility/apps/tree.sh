#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../commands/logging.sh"

log_info "tree.sh running"

trap 'log_error_detail "tree.sh failed"; exit 1' ERR

if is_installed "tree" "tree"; then
    log_info "Tree already installed, skipping"
else
    export DEBIAN_FRONTEND=noninteractive

    log_info "Updating package index"
    sudo apt update -y -qq 2>/dev/null

    log_info "Installing Tree"
    sudo apt install -y -qq tree 2>/dev/null
fi

log_success "tree.sh completed"
