# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc) for examples
# This file will be sourced by ~/.bash_profile for login & interactive shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

if [ -n "$SHELL_THEME" ]; then
    export SHELL_THEME="90210"
fi

source ~/.profile

# Load initrc scripts
if [ -f "$SHELL_CONFIG_HOME/initrc.sh" ]; then
	  . "$SHELL_CONFIG_HOME/initrc.sh"
else
    echo "Shell init script not found, environment not setup correctly."
fi
