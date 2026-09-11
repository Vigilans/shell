#  ---------------------------------------------------------------------------
#  Wrappers around curl.
#  ---------------------------------------------------------------------------

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
