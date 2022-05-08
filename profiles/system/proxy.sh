if [ -n "$PROXY_SERVER" ]; then
    export http_proxy="http://$PROXY_SERVER:8123"
    export https_proxy="http://$PROXY_SERVER:8123"
    export socks5_proxy="socks5://$PROXY_SERVER:1080"
    export no_proxy="localhost,127.0.0.0/8,::1"
else
    unset http_proxy https_proxy socks5_proxy no_proxy
fi
