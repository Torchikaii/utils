#!/bin/bash

set -e

export DEBIAN_FRONTEND=noninteractive

sudo apt update -y
sudo apt install -y openssh-server > /dev/null 2>&1
sudo systemctl start ssh > /dev/null 2>&1
sudo systemctl enable ssh > /dev/null 2>&1

