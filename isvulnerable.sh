#!/usr/bin/env bash
#
# Site vuln checker

DIR="$(dirname "$0")"
VULN_DICT="${DIR}/data/web/vulns/potential.txt"

target="$1"
base="${target}"
host=$(grep -Eo '(?:[^:]*://)?([^/]+\.[^/]+)' <<< "$base")

source "${DIR}/lib/base.sh"
source "${DIR}/lib/http.sh"

printf "Target: ${target}\n"

process "Check path misconfigs..."

paths_exists "${base}" "${VULN_DICT}" || echo "No path vulns found."

process "Check domains..."

ssl_domains "${host}:443"
