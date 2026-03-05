#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/commands/logging.sh"

log_info "dotfiles.sh running"

trap 'log_error_detail "dotfiles.sh failed"; exit 1' ERR

# Alacritty
ALACRITTY_CONFIG_DIR="$HOME/.config/alacritty"
ALACRITTY_CONFIG="$ALACRITTY_CONFIG_DIR/alacritty.toml"
ALACRITTY_SOURCE="$HOME/repos/utils/ubuntu-utility/dotfiles/alacritty/alacritty.toml"

if [ -L "$ALACRITTY_CONFIG" ] && [ "$(readlink -f "$ALACRITTY_CONFIG")" = "$(readlink -f "$ALACRITTY_SOURCE")" ]; then
    log_info "Alacritty config already linked, skipping"
else
    mkdir -p "$ALACRITTY_CONFIG_DIR"
    rm -f "$ALACRITTY_CONFIG"
    ln -s "$ALACRITTY_SOURCE" "$ALACRITTY_CONFIG"
    log_info "Alacritty config linked"
fi

# Bash
BASH_CONFIG="$HOME/.bashrc"
BASH_SOURCE="$HOME/repos/utils/ubuntu-utility/dotfiles/bash/.bashrc"

if [ -L "$BASH_CONFIG" ] && [ "$(readlink -f "$BASH_CONFIG")" = "$(readlink -f "$BASH_SOURCE")" ]; then
    log_info "Bash config already linked, skipping"
else
    rm -f "$BASH_CONFIG"
    ln -s "$BASH_SOURCE" "$BASH_CONFIG"
    log_info "Bash config linked"
fi

# Vim
VIM_CONFIG="$HOME/.vimrc"
VIM_SOURCE="$HOME/repos/utils/ubuntu-utility/dotfiles/vim/.vimrc"

if [ -L "$VIM_CONFIG" ] && [ "$(readlink -f "$VIM_CONFIG")" = "$(readlink -f "$VIM_SOURCE")" ]; then
    log_info "Vim config already linked, skipping"
else
    rm -f "$VIM_CONFIG"
    ln -s "$VIM_SOURCE" "$VIM_CONFIG"
    log_info "Vim config linked"
fi

log_success "dotfiles.sh completed"
