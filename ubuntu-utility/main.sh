#!/bin/bash

set -e

./ubuntu-utility/keyboard.sh

./ubuntu-utility/docker.sh
./ubuntu-utility/ssh.sh
./ubuntu-utility/terraform.sh
./ubuntu-utility/opencode.sh
./ubuntu-utility/brave.sh
./ubuntu-utility/alacritty.sh
./ubuntu-utility/apt-apps.sh

