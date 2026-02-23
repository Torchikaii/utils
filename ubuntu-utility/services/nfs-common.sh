#!/bin/bash

set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

echo "nfs-common.sh running..."

sudo apt update -y
sudo apt install nfs-common -y

# Create mount point for dataset
sudo mkdir -p /mnt/NAS-main

echo "nfs-common.sh finished"

