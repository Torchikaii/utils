#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../commands/logging.sh"

log_info "opencode.sh running"

trap 'log_error_detail "opencode.sh failed"; exit 1' ERR

if is_installed "opencode"; then
    log_info "Opencode already installed, skipping"
else
    export DEBIAN_FRONTEND=noninteractive

    log_info "Installing Opencode"
    curl -fsSL https://opencode.ai/install | bash
fi

log_success "opencode.sh completed"
