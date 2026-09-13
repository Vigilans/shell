
# Platform functions invoked by subsequent rc scripts

# Get host triplet (3-fields only)
host_triplet_trivial() {
    local machine=$(uname -m)
    local vendor os
    case $(uname -s) in
        Linux*)  vendor="unknown"; os="linux";;
        Darwin*) vendor="apple"; os="darwin";;
        CYGWIN*|MINGW*|MSYS*) vendor="pc"; os="windows";;
    esac
    if [ "$os" = "darwin" ] && [ "$machine" = "arm64" ]; then
        if [ -n "$HOST_TRIPLET_APPLE_USE_INTEL" ]; then # Some repositories may not have apple m1 arm64 binaries
            machine="x86_64"
        else
            machine="aarch64"
        fi
    fi
    echo "$machine-$vendor-$os"
}

# Get whether host is using musl for c libraries
host_libc_using_musl() {
    if command -v ldd >/dev/null && command ldd /bin/ls| grep -qs "musl"; then
        echo "musl"
    elif command -v otool >/dev/null && command otool -L /bin/ls | grep -qs "musl"; then
        echo "musl"
    elif [ "$(uname -s)" = "Linux" ] && { [ "$HOST_LIBC_PREFER_MUSL" = 1 ] || [ "$HOST_LIBC_PREFER_MUSL" = "$(uname -m)" ]; }; then
        echo "musl"
    else
        echo ""
    fi
}

# Get libc library used by host (e.g. gnu or musl)
host_libc() {
    if [ -n "$(host_libc_using_musl)" ]; then
        echo "musl"
    else
        case $(uname -s) in
            Linux*)  echo "gnu";;
            Darwin*) echo "";;
            CYGWIN*|MINGW*|MSYS*) echo "msvc";;
        esac
    fi
}

# Get host triplet (conforms to GNU build system)
host_triplet() {
    local triplet=$(host_triplet_trivial)
    local suffix=$(host_libc)
    if [ -n "$suffix" ]; then
        echo "$triplet-$suffix"
    else
        echo "$triplet"
    fi
}

# Get host OS as spelled by Go's GOOS (linux, darwin, windows)
host_os() {
    case $(uname -s) in
        Linux*)  echo "linux";;
        Darwin*) echo "darwin";;
        CYGWIN*|MINGW*|MSYS*) echo "windows";;
    esac
}

# Get host CPU as spelled by a naming convention: go (amd64/arm64), gnu (x86_64/aarch64), apple (x86_64/arm64), msft (x64/arm64)
host_arch() {
    case $(uname -m) in
        x86_64|amd64)
            case $1 in
                go) echo "amd64";;
                gnu|apple) echo "x86_64";;
                msft) echo "x64";;
            esac;;
        aarch64|arm64)
            case $1 in
                gnu) echo "aarch64";;
                go|apple|msft) echo "arm64";;
            esac;;
    esac
}
