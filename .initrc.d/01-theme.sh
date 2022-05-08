# theme.sh: setup script for shell themes.

if [ -n "$SHELL_THEME" ]; then
    # Bash setup
    if [ -n "$BASH_VERSION" ]; then
        source "$SHELL_RC_HOME/vendors/theme-base.sh"
        source "$SHELL_RC_HOME/vendors/theme-colours.sh"
    fi

    if [ -r "$SHELL_RC_HOME/vendors/themes/$SHELL_THEME.theme.sh" ]; then
        source "$SHELL_RC_HOME/vendors/themes/$SHELL_THEME.theme.sh"
    elif [ -f "$SHELL_RC_HOME/themes/$SHELL_THEME.theme.sh" ]; then
        source "$SHELL_RC_HOME/themes/$SHELL_THEME.theme.sh"
    else
        echo "Theme $SHELL_THEME does not exist."
    fi
fi
