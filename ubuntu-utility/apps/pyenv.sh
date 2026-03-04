#!/bin/env bash

set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

sudo apt update -y

sudo apt install -y make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python3-openssl \
git

if [ ! -d "$HOME/.pyenv" ]; then
    curl https://pyenv.run | bash
fi 


