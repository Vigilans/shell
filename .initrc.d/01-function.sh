# function.sh: setup scripts for shell functions.

# Load shell functions
if [ -d $SHELL_CONFIG_HOME/functions ]; then
    # Common functions
    for func in $SHELL_CONFIG_HOME/functions/*.sh; do
        test -r "$func" && . "$func"
    done
    # Common vendor functions
    if [ -d $SHELL_CONFIG_HOME/functions/vendors ]; then
        for func in $SHELL_CONFIG_HOME/functions/vendors/*.sh; do
            test -r "$func" && . "$func"
        done
    fi
    # Zsh functions
    if [ -n "$ZSH_VERSION" ]; then
        for func in $SHELL_CONFIG_HOME/functions/*.zsh; do
            test -r "$func" && . "$func"
        done
    fi
    unset func
fi
