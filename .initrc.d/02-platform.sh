
# Platform functions invoked by subsequent rc scripts

# Get host triplet (3-fields only)
host_triplet_trivial() {
    local machine=$(uname -m)
    local vendor os
    case $(uname -s) in
        Linux*)  vendor="unknown"; os="linux";;
        Darwin*) vendor="apple"; os="darwin";;
        CYGWIN*) vendor="pc"; os="windows";;
        MINGW*)  vendor="pc"; os="windows";;
    esac
    echo "$machine-$vendor-$os"
}

# Get whether host is using musl for c libraries
host_libc_using_musl() {
    if command ldd /bin/ls | grep -qs "musl"; then
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
            CYGWIN*) echo "msvc";;
            MINGW*)  echo "gnu";;
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
