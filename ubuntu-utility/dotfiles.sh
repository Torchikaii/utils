#!/bin/bash

set -euo pipefail

echo "dotfiles.sh running..."


#------------------------------
#  Alacritty

echo "setting up dotfiles for allacrity"

ALACRITTY_CONFIG_DIR="$HOME/.config/alacritty"
ALACRITTY_CONFIG="$ALACRITTY_CONFIG_DIR/alacritty.toml"

mkdir -p "$ALACRITTY_CONFIG_DIR"

rm -f "$ALACRITTY_CONFIG"
ln -s "$HOME/repos/utils/ubuntu-utility/dotfiles/alacritty/alacritty.toml" "$ALACRITTY_CONFIG"


#-------------------------------
# Bash

echo "setting up dotfiles for bash"

BASH_CONFIG="$HOME/.bashrc"

rm -f "$BASH_CONFIG"
ln -s "$HOME/repos/utils/ubuntu-utility/dotfiles/bash/.bashrc" "$BASH_CONFIG"


echo "dotfiles.sh finished"
