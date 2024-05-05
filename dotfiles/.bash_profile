# ~/.bash_profile: executed by bash(1) for login shells.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# If not executed by bash, forward to ~/.profile
if [ -z "$BASH_VERSION" ]; then
    test -r "$HOME/.profile" && . "$HOME/.profile"
    return
fi

# Set shell config home varibale
if [ -z "$XDG_CONFIG_HOME" ]; then
    export XDG_CONFIG_HOME="$HOME/.config"
fi
export SHELL_CONFIG_HOME=$XDG_CONFIG_HOME/shell

# Load profile scripts
if [ -r "$SHELL_CONFIG_HOME/profile.sh" ]; then
    . $SHELL_CONFIG_HOME/profile.sh
fi

# if running in interactive mode, source .bashrc if it exists
if [[ $- == *i* ]] && [ -r "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
fi
