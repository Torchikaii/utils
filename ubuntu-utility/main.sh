#!/bin/bash

set -e

# apps
./ubuntu-utility/apps/docker.sh
./ubuntu-utility/apps/terraform.sh
./ubuntu-utility/apps/opencode.sh
./ubuntu-utility/apps/brave.sh
./ubuntu-utility/apps/alacritty.sh
./ubuntu-utility/apps/keepassxc.sh
./ubuntu-utility/apps/p7zip.sh
./ubuntu-utility/apps/git.sh
./ubuntu-utility/apps/vim.sh

# services
./ubuntu-utility/services/ssh.sh
./ubuntu-utility/services/cifs-utils.sh

# system configuration
./ubuntu-utility/dotfiles.sh
./ubuntu-utility/keyboard.sh


