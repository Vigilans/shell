#  ---------------------------------------------------------------------------
#  Description: This file holds networking related functions.
#
#  Sections:
#  1.   IP functions
#  2.   HTTP wrappers
#  3.   SSH wrappers
#  ---------------------------------------------------------------------------

#   -----------------------------
#   1.  IP functions
#   -----------------------------

#   interface_ip: Display all ip addresses from network interfaces
#   --------------------------------------------------------------------
function interface_ip() {
    if command -v ifconfig &>/dev/null; then
        ifconfig | awk '/inet /{ print $2 }'
    elif command -v ip &>/dev/null; then
        ip addr | grep -oP 'inet \K[\d.]+'
    else
        echo "You don't have ifconfig or ip command installed!"
    fi
}

#   zerotier_ip: Display zerotier ip addresses from zerotier-one tools
#   --------------------------------------------------------------------
function zerotier_ip() {
    zerotier="zerotier-cli"
    secrets=(/var/lib/zerotier-one/*.secret) # authtoken.secret and identity.secret
    if [ ! -r ${secrets[0]} ] || [ ! -r ${secrets[1]} ] ; then
        zerotier="sudo $zerotier" # Use sudo privilege if no read access
    fi
    for network in $($zerotier listnetworks | tail -n +1 | awk '{ print $3 }'); do
        echo $network
        $zerotier get $network ip
    done
    unset zerotier network
}

#   public_ip: Display public ip addresses from internet providers
#   --------------------------------------------------------------------
function public_ip() {
    case $1 in
        "");&
        -*);&
        --domestic)
            curl ip.cip.cc ${@:2};;
        --international)
            curl ifconfig.co ${@:2};;
        *)
            curl $@;;
    esac
}

#   -----------------------------
#   2.  HTTP Wrappers
#   -----------------------------

#   curl_headers: Grabs headers from web page
#   --------------------------------------------------------------------
function curl_headers() {
    curl -I -L "$@"
}

#   curl_profile:  Download a web page and show profile on what took time
#   --------------------------------------------------------------------
function curl_profile() {
    curl "$@" -o /dev/null -w "dns: %{time_namelookup} connect: %{time_connect} pretransfer: %{time_pretransfer} starttransfer: %{time_starttransfer} total: %{time_total}\\n"
}
