#!/bin/bash
set -e

export DEBIAN_FRONTEND=noninteractive

echo "Removing conflicting packages..."
sudo apt remove -y docker.io docker-compose docker-compose-v2 docker-doc podman-docker containerd runc || true

echo "Updating package index..."
sudo apt update -y

echo "Installing prerequisites..."
sudo apt install -y ca-certificates curl

echo "Setting up Docker GPG key..."
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo "Adding Docker repository..."
sudo tee /etc/apt/sources.list.d/docker.sources >/dev/null <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

echo "Updating package index..."
sudo apt update -y

echo "Installing Docker..."
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "Starting Docker service..."
sudo systemctl enable docker
sudo systemctl start docker

echo "Waiting for Docker to become ready..."
sudo systemctl is-active --quiet docker

echo "Running hello-world docker container..."
if [ "${CI:-false}" = "true" ]; then
    echo "CI environment detected, Will not pull docker image"
else
    sudo docker run --rm hello-world
fi
echo "Docker installation completed successfully."
