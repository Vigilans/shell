if [ "$TERM_PROGRAM" = "vscode" ]; then
    export EDITOR="code --wait"
elif type nano 1>/dev/null 2>&1; then
    export EDITOR="nano -l"
elif type vim 1>/dev/null 2>&1; then
    export EDITOR=vim
else
    export EDITOR=vi
fi
