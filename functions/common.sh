#  ---------------------------------------------------------------------------
#  Description:  This file holds simple wrappers of existing system commands.
#
#  Sections:
#  1.   Filesystem opereation
#  2.   Searching
#  4.   Process Management
#  6.   System Operations & Information
#  ---------------------------------------------------------------------------

#   -----------------------------
#   1.  Filesystem operation
#   -----------------------------

#   mkcd: Makes new Dir and jumps inside
#         Usage: mkcd FOLDER
#   --------------------------------------------------------------------
function mkcd() {
    mkdir -p -- $@ ; cd -- $@ || exit ;
}

#   trash：Move file to trashbin
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

#   archive: Create most known archives with one command
#            Usage: archive [FOLDER] ARCHIVE
#   --------------------------------------------------------------------
function archive() {
    echo "not implemented yet"
}

#   -----------------------------
#   2.  Searching
#   -----------------------------

#   lsgrep: Search through directory contents with grep.
#           Usage: lsgrep [LS-OPTION] PATTERN
#   --------------------------------------------------------------------
function dufind() {
  if [[ $# -lt 1 ]]; then
    echo_warn "Usage: dufind DIRECTORY"
    return
  fi
  du -a "$1" | sort -n -r | head -n 10
}

#   -----------------------------
#   3.  Editing
#   -----------------------------

#   -----------------------------
#   4.  System information
#   -----------------------------

#   history_stats：Visualize the usage frequency of commands in history
#   --------------------------------------------------------------------
function history_stats() {
    fc -l 1 | awk '{ CMD[$2]++;count++; } END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a; }' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl | head -n 20
}
