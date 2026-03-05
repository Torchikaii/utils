#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../commands/logging.sh"

log_info "keepassxc.sh running"

trap 'log_error_detail "keepassxc.sh failed"; exit 1' ERR

if is_installed "keepassxc" "keepassxc"; then
    log_info "KeePassXC already installed, skipping"
else
    export DEBIAN_FRONTEND=noninteractive

    log_info "Installing software-properties-common"
    sudo apt install -y -qq software-properties-common 2>/dev/null

    log_info "Adding KeePassXC PPA"
    sudo add-apt-repository -y ppa:phoerious/keepassxc

    log_info "Updating package index"
    sudo apt update -y -qq 2>/dev/null

    log_info "Installing KeePassXC"
    sudo apt install -y -qq keepassxc 2>/dev/null
fi

log_success "keepassxc.sh completed"
