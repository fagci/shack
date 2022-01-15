RED="\e[1;31m"
GREEN="\e[1;32m"
YELLOW="\e[1;33m"
BLUE="\e[1;34m"
GREY="\e[1;30m"
RESET="\e[m"

printf "$(
cat <<EOF
     _                _    
 ___| |__   ____  ___| | __
/ __| '_ \ / _. |/ __| |/ /
\__ \ | | | (_| | (__|   < 
|___/_| |_|\__,_|\___|_|\_\ ${GREY}by fagci${RESET}
------------------------------------
EOF
)\n" >&2

function process() {
    printf "\n${GREY}[*] $@${RESET}\n"
}

function nfound() {
    printf "${GREY}[-] $@${RESET}\n"
}

function found() {
    printf "${GREEN}[+] $@${RESET}\n"
}

function success() {
    printf "${GREEN}[+] $@${RESET}\n"
}

function info() {
    printf "${BLUE}[i] $@${RESET}\n"
}

function warn() {
    printf "${YELLOW}[!] $@${RESET}\n" >&2
}

function error() {
    printf "${RED}[E] $@${RESET}\n" >&2
}
