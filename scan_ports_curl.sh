#!/usr/bin/env bash

target="${1:-127.0.0.1}"

export TIMEOUT=0.5

function check_port_curl() {
    curl -m "$TIMEOUT" --connect-timeout "$TIMEOUT" \
        --tcp-fastopen --tcp-nodelay \
        -svo /dev/null "telnet://${1}:${2}" 2>&1 \
        | grep -Fq Connected
}

export -f check_port_curl

seq "${2:-1}" "${3:-1024}" \
    | xargs -P128 -I@ bash -c "check_port_curl ${target} @ && echo @"
