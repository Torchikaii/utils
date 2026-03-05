#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../commands/logging.sh"

log_info "brave.sh running"

trap 'log_error_detail "brave.sh failed"; exit 1' ERR

if is_installed "brave" "brave-browser"; then
    log_info "Brave already installed, skipping"
else
    export DEBIAN_FRONTEND=noninteractive

    log_info "Installing Brave Browser"
    curl -fsS https://dl.brave.com/install.sh | sh
fi

log_success "brave.sh completed"
