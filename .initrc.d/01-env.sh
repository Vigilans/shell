if [ -z "$EDITOR" ]; then
    if [ "$TERM_PROGRAM" = "vscode" ]; then
        export EDITOR="code --wait"
    elif type nano 1>/dev/null 2>&1 && [ "$(readlink $(which nano))" != "pico" ]; then
        export EDITOR="nano -l"
    elif type vim 1>/dev/null 2>&1; then
        export EDITOR=vim
    else
        export EDITOR=vi
    fi
fi

if [ -z "$PDFVIEWER" ]; then
    if [ "$TERM_PROGRAM" = "vscode" ]; then
        export PDFVIEWER="code --reuse-window"
    fi
fi

if [ -z "$GPG_TTY" ] && type gpg 1>/dev/null 2>&1; then
    if [ "$TERM_PROGRAM" = "vscode" ] && [ -n "$VSCODE_IPC_HOOK_CLI" ]; then
        export GPG_TTY=$(tty)
    elif [ -n "$SSH_CONNECTION" ]; then
        export GPG_TTY=$(tty)
    fi
fi

if [[ "$TERM" = "xterm-kitty" ]]; then
    export TERM="xterm-256color"
fi

if [ "${MANPATH:0:1}" != ":" ]; then
    export MANPATH=":$MANPATH" # Fix MANPATH ignoring system default by prefixing a colon
fi
