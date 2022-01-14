#!/usr/bin/env bash

target="${1:-127.0.0.1}"

ports="$(seq "${2:-1}" "${3:-1024}")"

function check_port() {
    timeout "${3:-1}" bash -c "echo > /dev/tcp/${1}/${2} && echo $2" 2>/dev/null
}

export -f check_port

xargs -P128 -I@ bash -c "check_port ${target} @ 0.25" <<< "$ports"
