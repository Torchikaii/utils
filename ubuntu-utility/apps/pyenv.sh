#!/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../commands/logging.sh"

log_info "pyenv.sh running"

trap 'log_error_detail "pyenv.sh failed"; exit 1' ERR

if [ -d "$HOME/.pyenv" ]; then
    log_info "Pyenv already installed, skipping"
else
    export DEBIAN_FRONTEND=noninteractive

    log_info "Updating package index"
    sudo apt update -y

    log_info "Installing pyenv prerequisites"
    sudo apt install -y make build-essential libssl-dev zlib1g-dev \
        libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
        libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python3-openssl \
        git

    log_info "Installing pyenv"
    curl https://pyenv.run | bash
fi

log_success "pyenv.sh completed"
