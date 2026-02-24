#!/bin/bash

set -euo pipefail

echo "cifs-utils.sh running ..."

sudo apt update -y
sudo apt install cifs-utils -y
sudo apt install smbclient -y

echo "cifs-utils.sh completed"


