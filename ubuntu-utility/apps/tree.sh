#!/bin/bash

set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

echo "tree.sh running"

sudo apt update -y -qq
sudo apt install tree -y -qq

echo "tree.sh finished"
