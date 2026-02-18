#!/usr/bin/env bash
set -euo pipefail

# don't run this script in CI environments, it's only
# used on real hardware like laptops and desktops
if [ "${CI:-false}" = "true" ]; then
    echo "CI detected. Skipping keyboard setup."
    exit 0
fi

# Check if grep supports PCRE
if echo "test" | grep -oP "test" >/dev/null 2>&1; then
    HAS_PCRE=true
else
    HAS_PCRE=false
fi

# Resolve script directory safely (works from anywhere)
SCRIPT_SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SCRIPT_SOURCE" ]; do
  DIR="$(cd -P "$(dirname "$SCRIPT_SOURCE")" >/dev/null 2>&1 && pwd)"
  SCRIPT_SOURCE="$(readlink "$SCRIPT_SOURCE")"
  [[ $SCRIPT_SOURCE != /* ]] && SCRIPT_SOURCE="$DIR/$SCRIPT_SOURCE"
done
SCRIPT_DIR="$(cd -P "$(dirname "$SCRIPT_SOURCE")" >/dev/null 2>&1 && pwd)"

DOTFILES_DIR="$SCRIPT_DIR/dotfiles"
DCONF_FILE="$DOTFILES_DIR/keyboard.dconf"

if [ ! -f "$DCONF_FILE" ]; then
    echo "ERROR: $DCONF_FILE not found!"
    exit 1
fi

echo "Extracting keyboard layouts from keyboard.dconf..."

# Extract layouts
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
    echo "ERROR: Could not extract layouts"
    exit 1
fi

echo "Detected layouts: $LAYOUTS"

echo "Extracting xkb-options..."

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

# If no options found, ensure empty string
XKB_OPTIONS="${XKB_OPTIONS:-}"

echo "Detected XKB options: ${XKB_OPTIONS:-<none>}"

echo "Updating packages..."
sudo apt update -y -qq

echo "Installing required packages..."
sudo apt install -y -qq keyboard-configuration console-setup

echo "Configuring system console keyboard..."

sudo tee /etc/default/keyboard > /dev/null <<EOF
XKBMODEL="pc105"
XKBLAYOUT="$LAYOUTS"
XKBVARIANT=""
XKBOPTIONS="$XKB_OPTIONS"
BACKSPACE="guess"
EOF

sudo dpkg-reconfigure -f noninteractive keyboard-configuration
sudo setupcon

echo "Restoring GNOME keyboard configuration..."
if command -v dconf >/dev/null 2>&1; then
    dconf load /org/gnome/desktop/input-sources/ < "$DCONF_FILE"
else
    echo "dconf not available. Skipping GNOME configuration."
fi


echo ""
echo "Keyboard configuration complete."
echo "Console and GNOME are now aligned."
echo "Log out and log back in."

