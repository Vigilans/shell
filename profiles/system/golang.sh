if [ -z "$GOROOT" ] || [ -z "$GOPATH" ]; then
    if command -v go &> /dev/null; then
        export GOROOT="$(go env GOROOT)"
        export GOPATH="$(go env GOPATH)"
    fi
fi

if [ -n "$GOPATH" ]; then
    export PATH=$PATH:$GOPATH/bin
fi
