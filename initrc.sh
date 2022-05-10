# initrc.sh: setup script for interactive shells.

# Prevent loading twice
if [ -z "$_SHELL_INITRC_LOADED" ]; then
    _SHELL_INITRC_LOADED=1
else
    return
fi

# Profile setup if required
if [ -n "$_INITRC_SH_LOAD_PROFILE" ]; then
    if [ -f "$SHELL_CONFIG_HOME/profile.sh" ]; then
        . "$SHELL_CONFIG_HOME/profile.sh"
    fi
fi

# Login shell setup
if ([ -n "$BASH_VERSION" ] && shopt -q login_shell) || ([ -n "$ZSH_VERSION" ]  && [[ -o login ]]); then
    if [ -f "$SHELL_CONFIG_HOME/login.sh" ]; then
        . "$SHELL_CONFIG_HOME/login.sh"
    fi
fi

# RC scripts location setup
export SHELL_RC_HOME
if [ -n "$BASH_VERSION" ] && [ -d $SHELL_CONFIG_HOME/.bashrc.d ]; then
    SHELL_RC_HOME=$SHELL_CONFIG_HOME/.bashrc.d
elif [ -n "$ZSH_VERSION" ] && [ -d $SHELL_CONFIG_HOME/.zshrc.d ]; then
    SHELL_RC_HOME=$SHELL_CONFIG_HOME/.zshrc.d
fi

# Interactive mode setup
if ([ -n "$BASH_VERSION" ] || [ -n "$ZSH_VERSION" ]) && ([[ $- == *i* ]] || [ -n "$_INITRC_SH_FORCE_LOAD" ]); then
    # General setup
    if [ -d $SHELL_CONFIG_HOME/.initrc.d ]; then
        for rc in $SHELL_CONFIG_HOME/.initrc.d/*.sh; do
            test -r "$rc" && . "$rc"
        done
    fi
    # Per-Shell setup
    if [ -n "$BASH_VERSION" ]; then
        for rc in $SHELL_RC_HOME/*.sh; do
            test -r "$rc" && . "$rc"
        done
    elif [ -n "$ZSH_VERSION" ]; then
        for rc in $SHELL_RC_HOME/*.zsh; do
            test -r "$rc" && . "$rc"
        done
    fi
    unset rc
fi
