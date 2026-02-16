#!/bin/bash

set -e

./docker.sh
./terraform.sh
./opencode.sh
