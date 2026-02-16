#!/bin/bash

set -e

export DEBIAN_FRONTEND=noninteractive

# keepassxc
sudo add-apt-repository -y ppa:phoerious/keepassxc
sudo apt update -y
sudo apt install keepassxc -y

# 7 zip
sudo apt install p7zip-full -y



