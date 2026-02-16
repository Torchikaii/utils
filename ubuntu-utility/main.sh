#!/bin/bash

set -e

./dokcer.sh
./terraform.sh
./opencode.sh
