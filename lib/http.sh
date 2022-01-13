function mozcurl() {
    curl -H 'User-Agent: Mozilla/5.0' "$@"
}

function http_status() {
    mozcurl -so /dev/null -w%{http_code} "$@"
}

function http_ok() {
    mozcurl -so /dev/null -w%{http_code} "$@" \
        | grep -q '^[12]'
}

function ssl_domains(){
    true | openssl s_client -connect "$1" 2>/dev/null \
        | openssl x509 -noout -text \
        | sed -En 's#\s*DNS:([^ ,]+)[^D]*#\1\n#gp' | awk '$0'
}

function paths_exists() {
    xargs -P4 -I@ bash -c "http_ok ${1}@ && echo @" < "$2"
}

export -f mozcurl http_status http_ok
