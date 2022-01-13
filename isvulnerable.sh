#!/usr/bin/env bash
#
# Site vuln checker

DIR="$(dirname "$0")"
VULN_DICT="${DIR}/data/web/vulns/potential.txt"

target="$1"
base="${target}"
host=$(grep -Eo '(?:[^:]*:\/\/)?([^\/]+\.[^\/]+)' <<< "$base")

source "${DIR}/lib/http.sh"

echo "Target: ${target}"

echo "Check path misconfigs..."

xargs -P4 -I@ bash -c "http_ok ${base}@ && echo @" < "${VULN_DICT}" \
    || echo "No path vulns found."

echo "Check domains..."

true | openssl s_client -connect "${host}:443" 2>/dev/null \
    | openssl x509 -noout -text \
    | sed -En 's#\s*DNS:([^ ,]+)[^D]*#\1 #gp'
