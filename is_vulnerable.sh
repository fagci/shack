#!/usr/bin/env bash
#
# Site vuln checker

DIR="$(dirname "$0")"
VULN_DICT="${DIR}/data/web/vulns/potential.txt"

target="$1"

source "${DIR}/lib/base.sh"
source "${DIR}/lib/net.sh"
source "${DIR}/lib/http.sh"

grep -q '^http' <<< "$target" || target="https://${target}"

base="${target}"
host=$(get_hostname "$base")

info "Target: $target"

process "Check path misconfigs..."

paths_exists "$base" "${VULN_DICT}" || echo "No path vulns found."

process "Check domains..."

ssl_domains "${host}:443"
