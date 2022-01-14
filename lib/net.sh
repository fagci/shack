function get_hostname() {
    grep -Eo '(?:[^:]*://)?([^/]+\.[^/]+)' <<< "$1"
}

function check_port() {
    timeout "${3:-1}" bash -c "echo > /dev/tcp/${1}/${2} && echo $2" 2>/dev/null
}

export -f get_hostname check_port
