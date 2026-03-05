#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/commands/logging.sh"

log_info "keyboard.sh running"

trap 'log_error_detail "keyboard.sh failed"; exit 1' ERR

if [ "${CI:-false}" = "true" ]; then
    log_info "CI detected, skipping keyboard setup"
    exit 0
fi

if echo "test" | grep -oP "test" >/dev/null 2>&1; then
    HAS_PCRE=true
else
    HAS_PCRE=false
fi

DOTFILES_DIR="$SCRIPT_DIR/dotfiles"
DCONF_FILE="$DOTFILES_DIR/keyboard.dconf"

if [ ! -f "$DCONF_FILE" ]; then
    log_error "$DCONF_FILE not found!"
    exit 1
fi

log_info "Extracting keyboard layouts from keyboard.dconf"

if [ "$HAS_PCRE" = true ]; then
    LAYOUTS=$(grep "^sources=" "$DCONF_FILE" \
        | grep -oP "\('xkb', '\K[^']+" \
        | awk '!seen[$0]++' \
        | paste -sd "," -)
else
    LAYOUTS=$(grep "^sources=" "$DCONF_FILE" \
        | grep -oE "'xkb', '[^']+'" \
        | sed "s/.*'\\([^']*\\)'/\\1/" \
        | awk '!seen[$0]++' \
        | paste -sd "," -)
fi

if [ -z "$LAYOUTS" ]; then
    log_error "Could not extract layouts from keyboard.dconf"
    exit 1
fi

log_info "Detected layouts: $LAYOUTS"

if [ "$HAS_PCRE" = true ]; then
    XKB_OPTIONS=$(grep "xkb-options=" "$DCONF_FILE" \
        | grep -oP "'\K[^']+" \
        | paste -sd "," - || true)
else
    XKB_OPTIONS=$(grep "xkb-options=" "$DCONF_FILE" \
        | grep -oE "'[^']+'" \
        | sed "s/'\\([^']*\\)'/\\1/g" \
        | paste -sd "," - || true)
fi

XKB_OPTIONS="${XKB_OPTIONS:-}"

log_info "Detected XKB options: ${XKB_OPTIONS:-<none>}"

log_info "Updating packages"
sudo apt update -y -qq 2>/dev/null

log_info "Installing keyboard-configuration and console-setup"
sudo apt install -y -qq keyboard-configuration console-setup 2>/dev/null

log_info "Configuring system console keyboard"

sudo tee /etc/default/keyboard > /dev/null <<EOF
XKBMODEL="pc105"
XKBLAYOUT="$LAYOUTS"
XKBVARIANT=""
XKBOPTIONS="$XKB_OPTIONS"
BACKSPACE="guess"
EOF

sudo dpkg-reconfigure -f noninteractive keyboard-configuration
sudo setupcon

log_info "Restoring GNOME keyboard configuration"
if command -v dconf >/dev/null 2>&1; then
    dconf load /org/gnome/desktop/input-sources/ < "$DCONF_FILE"
else
    log_info "dconf not available, skipping GNOME configuration"
fi

log_success "keyboard.sh completed. Log out and log back in for changes to take effect."
