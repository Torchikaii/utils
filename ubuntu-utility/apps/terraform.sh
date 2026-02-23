#!/bin/bash
set -e

export DEBIAN_FRONTEND=noninteractive

echo "Updating package index..."
sudo apt update -y

echo "Installing prerequisites..."
sudo apt install -y ca-certificates curl gnupg lsb-release

echo "Setting up HashiCorp GPG key..."
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/hashicorp.gpg
sudo chmod a+r /etc/apt/keyrings/hashicorp.gpg

echo "Adding HashiCorp repository..."
sudo tee /etc/apt/sources.list.d/hashicorp.list >/dev/null <<EOF
deb [signed-by=/etc/apt/keyrings/hashicorp.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main
EOF

echo "Updating package index..."
sudo apt update -y

echo "Installing Terraform..."
sudo apt install -y terraform

echo "Verifying Terraform installation..."
terraform -version


echo "Terraform installation completed successfully."
