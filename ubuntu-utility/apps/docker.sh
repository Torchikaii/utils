#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../commands/logging.sh"

log_info "docker.sh running"

trap 'log_error_detail "docker.sh failed"; exit 1' ERR

if is_installed "docker" "docker-ce"; then
    log_info "Docker already installed, skipping"
else
    export DEBIAN_FRONTEND=noninteractive

    log_info "Removing conflicting packages"
    sudo apt remove -y docker.io docker-compose docker-compose-v2 docker-doc podman-docker containerd runc 2>/dev/null || true

    log_info "Updating package index"
    sudo apt update -y -qq 2>/dev/null

    log_info "Installing prerequisites"
    sudo apt install -y -qq ca-certificates curl 2>/dev/null

    log_info "Setting up Docker GPG key"
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    log_info "Adding Docker repository"
    sudo tee /etc/apt/sources.list.d/docker.sources >/dev/null <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

    log_info "Updating package index"
    sudo apt update -y -qq 2>/dev/null

    log_info "Installing Docker"
    sudo apt install -y -qq docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin 2>/dev/null

    log_info "Starting Docker service"
    sudo systemctl enable docker
    sudo systemctl start docker

    log_info "Waiting for Docker to become ready"
    sudo systemctl is-active --quiet docker

    if [ "${CI:-false}" != "true" ]; then
        log_info "Running hello-world docker container"
        sudo docker run --rm hello-world
    fi
fi

log_success "docker.sh completed"
