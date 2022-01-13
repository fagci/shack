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

export -f mozcurl http_status http_ok
