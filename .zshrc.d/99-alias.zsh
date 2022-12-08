# alias.sh: setup scripts for shell aliases.

# Load shell aliases
if [ -d $SHELL_CONFIG_HOME/aliases ]; then
    for alias in $SHELL_CONFIG_HOME/aliases/*.sh; do
        test -r "$alias" && . "$alias"
    done
    unset alias
fi
