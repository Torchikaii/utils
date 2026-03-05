#!/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../commands/logging.sh"

log_info "python.sh running"

trap 'log_error_detail "python.sh failed"; exit 1' ERR

export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

if pyenv versions | grep -q "3.12.12"; then
    log_info "Python 3.12.12 already installed, skipping"
else
    log_info "Installing Python 3.12.12"
    pyenv install 3.12.12
fi

log_info "Setting Python 3.12.12 as global"
pyenv global 3.12.12

log_success "python.sh completed"
