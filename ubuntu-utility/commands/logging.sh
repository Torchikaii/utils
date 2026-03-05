#!/bin/bash

log_info() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"
}

log_success() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"
}

log_error() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] ERROR: $*" >&2
}

log_error_detail() {
    local exit_code=$?
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] ERROR: $*" >&2
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Exit code: $exit_code" >&2
    if [ -n "$BASH_COMMAND" ]; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] Command: $BASH_COMMAND" >&2
    fi
}

is_installed() {
    local cmd="$1"
    local package="$2"

    if [ -n "$cmd" ] && command -v "$cmd" >/dev/null 2>&1; then
        return 0
    fi

    if [ -n "$package" ] && dpkg -s "$package" >/dev/null 2>&1; then
        return 0
    fi

    return 1
}
