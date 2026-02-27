#!/bin/env bash

set -e

# apps
bash ./ubuntu-utility/apps/docker.sh
bash ./ubuntu-utility/apps/terraform.sh
bash ./ubuntu-utility/apps/opencode.sh
bash ./ubuntu-utility/apps/brave.sh
bash ./ubuntu-utility/apps/alacritty.sh
bash ./ubuntu-utility/apps/keepassxc.sh
bash ./ubuntu-utility/apps/libreoffice.sh
bash ./ubuntu-utility/apps/p7zip.sh
bash ./ubuntu-utility/apps/git.sh
bash ./ubuntu-utility/apps/vim.sh
bash ./ubuntu-utility/apps/tree.sh

# services
bash ./ubuntu-utility/services/ssh.sh
bash ./ubuntu-utility/services/cifs-utils.sh

# system configuration
bash ./ubuntu-utility/dotfiles.sh
bash ./ubuntu-utility/keyboard.sh


