#!/bin/bash

set -e

export DEBIAN_FRONTEND=noninteractive

sudo apt install -y software-properties-common
sudo add-apt-repository -y ppa:phoerious/keepassxc
sudo apt update -y
sudo apt install keepassxc -y
