#!/bin/bash

source ~/repos/utils/ubuntu-utility/commands/logging.sh

log "docker.sh running"

if dpkg -s docker-ce >/dev/null 2>&1; then
    log "Docker already installed, skipping"
    exit 0
fi

log "Installing Docker"
sudo apt remove -y docker.io docker-compose podman-docker 2>/dev/null || true
sudo apt update -qq
sudo apt install -y -qq ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt update -qq
sudo apt install -y -qq docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl enable docker --now

log "docker.sh completed"
