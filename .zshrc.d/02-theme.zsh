# theme.sh: setup script for shell themes.

if [ -n "$SHELL_THEME" ]; then
    if [ -r "$SHELL_RC_HOME/themes/$SHELL_THEME.zsh-theme" ]; then
        source "$SHELL_RC_HOME/themes/$SHELL_THEME.zsh-theme"
    elif [ -f "$SHELL_RC_HOME/themes/$SHELL_THEME.zi.zsh-theme" ]; then
        source "$SHELL_RC_HOME/themes/$SHELL_THEME.zi.zsh-theme"
    else
        echo "Theme $SHELL_THEME does not exist."
    fi
fi
