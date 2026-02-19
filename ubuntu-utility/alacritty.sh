#!/usr/bin/env bash
set -euo pipefail

SCRIPT_SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SCRIPT_SOURCE" ]; do
  DIR="$(cd -P "$(dirname "$SCRIPT_SOURCE")" >/dev/null 2>&1 && pwd)"
  SCRIPT_SOURCE="$(readlink "$SCRIPT_SOURCE")"
  [[ $SCRIPT_SOURCE != /* ]] && SCRIPT_SOURCE="$DIR/$SCRIPT_SOURCE"
done
SCRIPT_DIR="$(cd -P "$(dirname "$SCRIPT_SOURCE")" >/dev/null 2>&1 && pwd)"

source "$SCRIPT_DIR/envsetup.sh"

DOTFILES_DIR="$DOTFILES/alacritty"
ALACRITTY_CONFIG_DIR="$HOME/.config/alacritty"
ALACRITTY_CONFIG="$ALACRITTY_CONFIG_DIR/alacritty.toml"

echo "Installing alacritty..."
sudo apt update -y -qq
sudo apt install -y -qq alacritty

echo "Setting up alacritty configuration..."

if [ ! -d "$ALACRITTY_CONFIG_DIR" ]; then
    echo "Creating ~/.config/alacritty/ directory..."
    mkdir -p "$ALACRITTY_CONFIG_DIR"
fi

if [ -f "$ALACRITTY_CONFIG" ] && [ ! -L "$ALACRITTY_CONFIG" ]; then
    echo "WARNING: $ALACRITTY_CONFIG exists and is not a symlink. Backing up to ${ALACRITTY_CONFIG}.backup"
    mv "$ALACRITTY_CONFIG" "${ALACRITTY_CONFIG}.backup"
fi

if [ -L "$ALACRITTY_CONFIG" ]; then
    echo "Symlink already exists at $ALACRITTY_CONFIG. Updating..."
    rm "$ALACRITTY_CONFIG"
fi

echo "Creating symlink: $ALACRITTY_CONFIG -> $DOTFILES_DIR/alacritty.toml"
ln -s "$DOTFILES_DIR/alacritty.toml" "$ALACRITTY_CONFIG"

THEMES_DIR="$ALACRITTY_CONFIG_DIR/themes"
if [ -d "$THEMES_DIR" ] && [ ! -L "$THEMES_DIR" ]; then
    echo "WARNING: $THEMES_DIR exists and is not a symlink. Backing up to ${THEMES_DIR}.backup"
    mv "$THEMES_DIR" "${THEMES_DIR}.backup"
fi

if [ -L "$THEMES_DIR" ]; then
    rm "$THEMES_DIR"
fi

echo "Creating symlink: $THEMES_DIR -> $DOTFILES_DIR/themes"
ln -s "$DOTFILES_DIR/themes" "$THEMES_DIR"

echo "Updating config with real paths..."
REAL_DOTFILES="$(cd "$DOTFILES" && pwd)"
sed -i "s|\$DOTFILES|$REAL_DOTFILES|g" "$DOTFILES_DIR/alacritty.toml"
echo "Config updated: $REAL_DOTFILES"

echo "Alacritty setup complete."
