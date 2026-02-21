#!/usr/bin/env bash
set -euo pipefail

sudo apt update -y -qq
sudo apt install -y -qq alacritty

ALACRITTY_CONFIG_DIR="$HOME/.config/alacritty"
ALACRITTY_CONFIG="$ALACRITTY_CONFIG_DIR/alacritty.toml"

mkdir -p "$ALACRITTY_CONFIG_DIR"

rm -f "$ALACRITTY_CONFIG"
ln -s "$HOME/repos/utils/ubuntu-utility/dotfiles/alacritty/alacritty.toml" "$ALACRITTY_CONFIG"
