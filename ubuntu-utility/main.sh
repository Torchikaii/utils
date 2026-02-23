#!/bin/bash

set -e

# apps
./ubuntu-utility/apps/docker.sh
./ubuntu-utility/apps/terraform.sh
./ubuntu-utility/apps/opencode.sh
./ubuntu-utility/apps/brave.sh
./ubuntu-utility/apps/alacritty.sh
./ubuntu-utility/apps/apt-apps.sh

# services
./ubuntu-utility/services/ssh.sh

# system configuration
./ubuntu-utility/dotfiles.sh
./ubuntu-utility/keyboard.sh


