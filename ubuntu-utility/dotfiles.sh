#!/bin/bash

set -euo pipefail

echo "dotfiles.sh running..."

echo "setting up dotfiles for allacrity"
# alacritty
ALACRITTY_CONFIG_DIR="$HOME/.config/alacritty"
ALACRITTY_CONFIG="$ALACRITTY_CONFIG_DIR/alacritty.toml"

mkdir -p "$ALACRITTY_CONFIG_DIR"

rm -f "$ALACRITTY_CONFIG"
ln -s "$HOME/repos/utils/ubuntu-utility/dotfiles/alacritty/alacritty.toml" "$ALACRITTY_CONFIG"

echo "dotfiles.sh finished"
