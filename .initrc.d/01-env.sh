if [ -z "$EDITOR" ]; then
    if [ "$TERM_PROGRAM" = "vscode" ]; then
        export EDITOR="code --wait"
    elif type nano 1>/dev/null 2>&1; then
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

if [[ "$TERM" = "xterm-kitty" ]]; then
    export TERM="xterm-256color"
fi
