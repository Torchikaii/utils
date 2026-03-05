#!/bin/bash

source ~/repos/utils/ubuntu-utility/commands/logging.sh

log "keyboard.sh running"

if [ "${CI:-false}" = "true" ]; then
    log "CI detected, skipping"
    exit 0
fi

DCONF=~/repos/utils/ubuntu-utility/dotfiles/keyboard.dconf
if [ ! -f "$DCONF" ]; then
    log "keyboard.dconf not found"
    exit 1
fi

LAYOUTS=$(grep "^sources=" "$DCONF" | grep -oE "'xkb', '[^']+'" | sed "s/.*'\([^']*\)'/\1/" | awk '!seen[$0]++' | paste -sd "," -)
XKB_OPTIONS=$(grep "xkb-options=" "$DCONF" | grep -oE "'[^']+'" | sed "s/'\([^']*\)'/\1/" | paste -sd "," - || true)

log "Configuring keyboard: $LAYOUTS"

echo 'XKBMODEL="pc105"
XKBLAYOUT="'"$LAYOUTS"'"
XKBVARIANT=""
XKBOPTIONS="'"${XKB_OPTIONS:-}"'"
BACKSPACE="guess"' | sudo tee /etc/default/keyboard

sudo dpkg-reconfigure -f noninteractive keyboard-configuration
sudo setupcon

if command -v dconf >/dev/null 2>&1; then
    dconf load /org/gnome/desktop/input-sources/ < "$DCONF"
fi

log "keyboard.sh completed"
