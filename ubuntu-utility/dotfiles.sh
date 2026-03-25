#!/bin/bash

source "$(dirname "$0")/commands/logging.sh"

log "dotfiles.sh running"

mkdir -p ~/.config/alacritty
rm -f ~/.config/alacritty/alacritty.toml
ln -s ~/repos/utils/ubuntu-utility/dotfiles/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml

rm -f ~/.bashrc
ln -s ~/repos/utils/ubuntu-utility/dotfiles/bash/.bashrc ~/.bashrc

rm -f ~/.vimrc
ln -s ~/repos/utils/ubuntu-utility/dotfiles/vim/.vimrc ~/.vimrc

log "dotfiles.sh completed"
