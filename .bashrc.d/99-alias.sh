# alias.sh: setup scripts for shell aliases.

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


# Load shell aliases
if [ -d $SHELL_CONFIG_HOME/aliases ]; then
    for alias in $SHELL_CONFIG_HOME/aliases/*.sh; do
        test -r "$alias" && . "$alias"
    done
    unset alias
fi
