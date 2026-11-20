# Coding agents snapshot the interactive environment from a login, non-interactive
# shell that sources the rc file directly. Keep this unexported: an exported flag
# would make every child shell load the interactive layer.
if [ -n "$CLAUDECODE" ]; then
    _INITRC_SH_FORCE_LOAD=1
fi

# Point VS Code's history reader at the active CAC environment.
if [ "$VSCODE_RESOLVING_ENVIRONMENT" = 1 ]; then
    cac_dir="${CAC_DIR:-$HOME/.local/share/cac}"
    if [ -f "$cac_dir/stopped" ]; then
        unset CLAUDE_CONFIG_DIR
    elif [ -r "$cac_dir/current" ]; then
        IFS= read -r cac_env < "$cac_dir/current"
        export CLAUDE_CONFIG_DIR="$cac_dir/envs/$cac_env/.claude"
    fi
    unset cac_dir cac_env
fi
