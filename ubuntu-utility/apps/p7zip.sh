#!/bin/bash

set -e

export DEBIAN_FRONTEND=noninteractive

sudo apt update -y
sudo apt install -y p7zip-full
