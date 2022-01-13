#!/usr/bin/env bash
#
# Check if an IP in blacklists

lists=(
    "0spam.fusionzero.com"
    "access.redhawk.org"
    "all.s5h.net"
    "all.spamrats.com"
    "aspews.ext.sorbs.net"
    "b.barracudacentral.org"
    "backscatter.spameatingmonkey.net"
    "bb.barracudacentral.org"
    "bl.blocklist.de"
    "bl.drmx.org"
    "bl.konstant.no"
    "bl.mailspike.net"
    "bl.nosolicitado.org"
    "bl.rbl.scrolloutf1.com"
    "bl.scientificspam.net"
    "bl.score.senderscore.com"
    "bl.spamcop.net"
    "bl.spameatingmonkey.net"
    "bl.suomispam.net"
    "bl.worst.nosolicitado.org"
    "black.junkemailfilter.com"
    "black.mail.abusix.zone"
    "block.dnsbl.sorbs.net"
    "cart00ney.surriel.com"
    "cbl.abuseat.org"
    "db.wpbl.info"
    "dnsbl-1.uceprotect.net"
    "dnsbl-2.uceprotect.net"
    "dnsbl-3.uceprotect.net"
    "dnsbl.cobion.com"
    "dnsbl.dronebl.org"
    "dnsbl.justspam.org"
    "dnsbl.kempt.net"
    "dnsbl.net.ua"
    "dnsbl.sorbs.net"
    "dnsbl.spfbl.net"
    "dnsbl.tornevall.org"
    "dnsbl.zapbl.net"
    "dnsrbl.swinog.ch"
    "dul.dnsbl.sorbs.net"
    "dyna.spamrats.com"
    "escalations.dnsbl.sorbs.net"
    "exploit.mail.abusix.zone"
    "fnrbl.fast.net"
    "hostkarma.junkemailfilter.com"
    "http.dnsbl.sorbs.net"
    "ips.backscatterer.org"
    "ix.dnsbl.manitu.net"
    "l4.bbfh.ext.sorbs.net"
    "mail-abuse.blacklist.jippg.org"
    "mail-abuse.com"
    "misc.dnsbl.sorbs.net"
    "multi.surbl.org"
    "netscan.rbl.blockedservers.com"
    "new.spam.dnsbl.sorbs.net"
    "noptr.spamrats.com"
    "old.spam.dnsbl.sorbs.net"
    "pbl.spamhaus.org"
    "problems.dnsbl.sorbs.net"
    "proxies.dnsbl.sorbs.net"
    "psbl.surriel.com"
    "rbl.abuse.ro"
    "rbl.blockedservers.com"
    "rbl.dns-servicios.com"
    "rbl.interserver.net"
    "rbl.realtimeblacklist.com"
    "rbl2.triumf.ca"
    "recent.spam.dnsbl.sorbs.net"
    "relays.dnsbl.sorbs.net"
    "rep.mailspike.net"
    "safe.dnsbl.sorbs.net"
    "sbl.spamhaus.org"
    "smtp.dnsbl.sorbs.net"
    "socks.dnsbl.sorbs.net"
    "spam.dnsbl.anonmails.de"
    "spam.dnsbl.sorbs.net"
    "spam.pedantic.org"
    "spam.rbl.blockedservers.com"
    "spam.spamrats.com"
    "spamlist.or.kr"
    "spamrbl.imp.ch"
    "spamsources.fabel.dk"
    "st.technovision.dk"
    "talosintelligence.com"
    "torexit.dan.me.uk"
    "truncate.gbudb.net"
    "ubl.unsubscore.com"
    "web.dnsbl.sorbs.net"
    "xbl.spamhaus.org"
    "z.mailspike.net"
    "zen.spamhaus.org"
    "zombie.dnsbl.sorbs.net"
)

GREEN="\e[1;32m"
RED="\e[1;31m"
YELLOW="\e[1;33m"
RESET="\e[m"

ip="$1"

grep -qE '^[0-9]{1,3}(\.[0-9]{1,3}){3}$' <<< "$ip" || {
    echo "Not an IP: '${ip}'"
    exit 255
}

rev_ip=$(awk -F. -vOFS=. '{print $4,$3,$2,$1}' <<< "$ip")

function check() {
    local host="${1}.${2}."
    local listed="$(dig +short -t a $host)"
    [[ "$listed" == *"timed out"* ]] && printf "${YELLOW}timeout${RESET}" && return
    [[ "$listed" ]] && printf "${RED}listed${RESET}" || printf "${GREEN}not listed${RESET}"
}

for list in "${lists[@]}"; do
    printf "${list} ... "
    echo "$(check "$rev_ip" "$list")"
done
