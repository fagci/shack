GREEN="\e[1;32m"
RED="\e[1;31m"
YELLOW="\e[1;33m"
GREY="\e[1;30m"
RESET="\e[m"

printf "$(
cat <<EOF
     _                _    
 ___| |__   __ _  ___| | __
/ __| '_ \\ / _\` |/ __| |/ /
\\__ \\ | | | (_| | (__|   < 
|___/_| |_|\\__,_|\\___|_|\\_\\ ${GREY}by fagci${RESET}
------------------------------------
EOF
)\n"

function info() {
    printf "${GREY}$@${RESET}\n"
}
