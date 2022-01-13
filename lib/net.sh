function get_hostname() {
    grep -Eo '(?:[^:]*://)?([^/]+\.[^/]+)' <<< "$1"
}
