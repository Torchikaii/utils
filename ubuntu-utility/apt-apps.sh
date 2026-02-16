#!/bin/bash

set -e

export DEBIAN_FRONTEND=noninteractive

sudo apt update -y

# keepassxc
sudo add-apt-repository ppa:phoerious/keepassxc
sudo apt install keepassxc -y

# 7 zip
sudo apt install p7zip-full -y



