# ~/.profile: executed by Xsession for environment setup.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login exists.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# Set shell config home varibale
if [ -z "$XDG_CONFIG_HOME" ]; then
    export XDG_CONFIG_HOME="$HOME/.config"
fi
export SHELL_CONFIG_HOME=$XDG_CONFIG_HOME/shell

# Load profile scripts
if [ -r "$SHELL_CONFIG_HOME/profile.sh" ]; then
    . $SHELL_CONFIG_HOME/profile.sh
fi
