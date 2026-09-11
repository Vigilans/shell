#  ---------------------------------------------------------------------------
#  Wrappers around common system commands.
#  ---------------------------------------------------------------------------

#   mkcd: Makes new Dir and jumps inside
#         Usage: mkcd FOLDER
#   --------------------------------------------------------------------
function mkcd() {
    mkdir -p -- $@ ; cd -- $@ || exit ;
}

#   trash: Move file to trashbin
#          Usage: trash FILES...
#   --------------------------------------------------------------------
function trash() {
    if command -v gio &> /dev/null; then # gnome
        gio trash $@
    elif command -v kioclient5 &> /dev/null; then # kde
        kioclient5 move $@ trash:/
    elif command -v kioclient &> /dev/null; then # kde
        kioclient move $@ trash:/
    fi
}

#   extract: Extract most known archives with one command
#            Usage: extract ARCHIVE [FOLDER]
#   --------------------------------------------------------------------
function extract() {
    if [ -f "$1" ] ; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar e "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

#   archive: Create an archive from one or more paths.
#            Format inferred from the output extension.
#            Usage: archive ARCHIVE FILES...
#            Examples:
#              archive backup.tar.gz mydir
#              archive code.zip src/ docs/
#   --------------------------------------------------------------------
function archive() {
    if [ $# -lt 2 ]; then
        echo "Usage: archive ARCHIVE FILES..." >&2
        return 1
    fi
    local out="$1"; shift
    case "$out" in
        *.tar.bz2|*.tbz2)  tar cjf "$out" "$@" ;;
        *.tar.gz|*.tgz)    tar czf "$out" "$@" ;;
        *.tar.xz|*.txz)    tar cJf "$out" "$@" ;;
        *.tar.zst|*.tzst)  tar --zstd -cf "$out" "$@" ;;
        *.tar)             tar cf  "$out" "$@" ;;
        *.zip)             zip -r  "$out" "$@" ;;
        *.7z)              7z a    "$out" "$@" ;;
        *) echo "'$out' format not supported by archive()" >&2; return 1 ;;
    esac
}

#   history_stats: Visualize the usage frequency of commands in history
#   --------------------------------------------------------------------
function history_stats() {
    fc -l 1 | awk '{ CMD[$2]++;count++; } END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a; }' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl | head -n 20
}
