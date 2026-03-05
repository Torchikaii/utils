#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../commands/logging.sh"

log_info "terraform.sh running"

trap 'log_error_detail "terraform.sh failed"; exit 1' ERR

if is_installed "terraform" "terraform"; then
    log_info "Terraform already installed, skipping"
else
    export DEBIAN_FRONTEND=noninteractive

    log_info "Updating package index"
    sudo apt update -y

    log_info "Installing prerequisites"
    sudo apt install -y ca-certificates curl gnupg lsb-release

    log_info "Setting up HashiCorp GPG key"
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/hashicorp.gpg
    sudo chmod a+r /etc/apt/keyrings/hashicorp.gpg

    log_info "Adding HashiCorp repository"
    sudo tee /etc/apt/sources.list.d/hashicorp.list >/dev/null <<EOF
deb [signed-by=/etc/apt/keyrings/hashicorp.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main
EOF

    log_info "Updating package index"
    sudo apt update -y

    log_info "Installing Terraform"
    sudo apt install -y terraform

    log_info "Verifying Terraform installation"
    terraform -version
fi

log_success "terraform.sh completed"
