#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../commands/logging.sh"

log_info "ssh.sh running"

trap 'log_error_detail "ssh.sh failed"; exit 1' ERR

if is_installed "sshd" "openssh-server"; then
    log_info "OpenSSH server already installed, skipping"
else
    export DEBIAN_FRONTEND=noninteractive

    log_info "Updating package index"
    sudo apt update -y

    log_info "Installing openssh-server"
    sudo apt install -y openssh-server

    log_info "Starting and enabling SSH service"
    sudo systemctl start ssh
    sudo systemctl enable ssh
fi

log_success "ssh.sh completed"
