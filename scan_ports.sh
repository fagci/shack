#!/usr/bin/env bash

target="${1:-127.0.0.1}"

ports="$(seq "${2:-1}" "${3:-1024}")"

DIR="$(dirname "$0")"

source "${DIR}/lib/base.sh"
source "${DIR}/lib/net.sh"

xargs -P128 -I@ bash -c "check_port ${target} @ 0.25" <<< "$ports"
