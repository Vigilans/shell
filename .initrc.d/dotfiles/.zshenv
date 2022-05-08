# ~/.zshenv: environment profile for zsh(1).
#
# This file is sourced on all invocations of the shell.
# If the -f flag is present or if the NO_RCS option is
# set within this file, all other initialization files
# are skipped.
#
# This file should contain commands to set the command
# search path, plus other important environment variables.
# This file should not contain commands that produce
# output or assume the shell is attached to a tty.
#
# Order: zshenv, zprofile, zshrc, zlogin

# Set shell config home varibale
if [ -z "$XDG_CONFIG_HOME" ]; then
    export XDG_CONFIG_HOME="$HOME/.config"
fi
export SHELL_CONFIG_HOME=$XDG_CONFIG_HOME/shell

# Load profile scripts
if [ -r "$SHELL_CONFIG_HOME/profile.sh" ]; then
    . $SHELL_CONFIG_HOME/profile.sh
fi
