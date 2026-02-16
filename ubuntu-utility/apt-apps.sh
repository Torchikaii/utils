#!/bin/bash

set -e

export DEBIAN_FRONTEND=noninteractive

sudo apt update -y
# Install required dependency for add-apt-repository (important# on minimal installs)
sudo apt install -y software-properties-common

# keepassxc
sudo add-apt-repository -y ppa:phoerious/keepassxc
sudo apt update -y  # always update after apt-add-repository
sudo apt install keepassxc -y

# 7 zip
sudo apt install p7zip-full -y

# git
sudo apt install git -y

# vim
sudo apt install vim -y

