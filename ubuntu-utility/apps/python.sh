#!/bin/env bash

set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

# temporarely export in, as .bashrc is loaded later
export PATH="$HOME/.pyenv/bin:$PATH"  # pyenv
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"   


if ! pyenv versions | grep -q "3.12.12"; then
    pyenv install 3.12.12
fi
pyenv global 3.12.12 
