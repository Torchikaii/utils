#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../commands/logging.sh"

log_info "alacritty.sh running"

trap 'log_error_detail "alacritty.sh failed"; exit 1' ERR

if is_installed "alacritty" "alacritty"; then
    log_info "Alacritty already installed, skipping"
else
    export DEBIAN_FRONTEND=noninteractive

    log_info "Installing Alacritty"
    sudo apt update -y -qq
    sudo apt install -y -qq alacritty
fi

log_success "alacritty.sh completed"
