#!/bin/env bash

set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

export PATH="$HOME/.pyenv/bin:$PATH"  # pyenv
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"   


pyenv install 3.12.12
pyenv global 3.12.12 
