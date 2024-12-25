# ~/.zprofile: environment profile for zsh(1).
#
# This file is sourced only for login shells (i.e. shells
# invoked with "-" as the first character of argv[0], and
# shells invoked with the -l flag.)
#
# Global Order: zshenv, zprofile, zshrc, zlogin

# Leave globbing expressions which don't match anything as-is
setopt +o nomatch

# Set shell config home varibale
if [ -z "$XDG_CONFIG_HOME" ]; then
    export XDG_CONFIG_HOME="$HOME/.config"
fi
export SHELL_CONFIG_HOME=$XDG_CONFIG_HOME/shell

# Load profile scripts
if [ -r "$SHELL_CONFIG_HOME/profile.sh" ]; then
    . $SHELL_CONFIG_HOME/profile.sh
fi
