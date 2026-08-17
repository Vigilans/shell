# Coding agents snapshot the interactive environment from a login, non-interactive
# shell that sources the rc file directly. Keep this unexported: an exported flag
# would make every child shell load the interactive layer.
if [ -n "$CLAUDECODE" ]; then
    _INITRC_SH_FORCE_LOAD=1
fi
