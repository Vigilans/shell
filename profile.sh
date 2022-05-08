# profile.sh: setup script for setting up environment variables.

export SHELL_PROFILE_HOME
if [ -n "$SHELL_CONFIG_HOME" ]; then
    SHELL_PROFILE_HOME=$SHELL_CONFIG_HOME/profiles
else
    SHELL_PROFILE_HOME=$(pwd)
fi

# Load local machine's profile directory (for setting home variables, etc.)
if [ -z "$_SHELL_PROFILE_LOCAL_LOADED" ]; then
    if [ -d $SHELL_PROFILE_HOME/local ]; then
        for profile in $SHELL_PROFILE_HOME/local/*.sh; do
          test -r "$profile" && . "$profile"
        done
        unset profile
        _REMOVE_DUPLICATE_PATH=1
        _SHELL_PROFILE_LOCAL_LOADED=1 # Prevent loading twice
    fi
fi

# Load system profile directory
if [ -z "$_SHELL_PROFILE_SYSTEM_LOADED" ]; then
    if [ -d $SHELL_PROFILE_HOME/system ]; then
        for profile in $SHELL_PROFILE_HOME/system/*.sh; do
          test -r "$profile" && . "$profile"
        done
        unset profile
        _REMOVE_DUPLICATE_PATH=1
        _SHELL_PROFILE_SYSTEM_LOADED=1 # Do not load system profiles if system level profile has loaded it
    fi
fi

# Load user profile directory
if [ -z "$_SHELL_PROFILE_USER_LOADED" ]; then
    if [ -d $SHELL_PROFILE_HOME/user ]; then
        for profile in $SHELL_PROFILE_HOME/user/*.sh; do
          test -r "$profile" && . "$profile"
        done
        unset profile
        _REMOVE_DUPLICATE_PATH=1
        _SHELL_PROFILE_USER_LOADED=1 # Prevent loading twice
    fi
fi

# Remove duplicate path
if [ -n "$_REMOVE_DUPLICATE_PATH" ] && [ -n "$PATH" ]; then
    old_PATH=$PATH:; PATH=
    while [ -n "$old_PATH" ]; do
        x=${old_PATH%%:*}        # the first remaining entry
        case $PATH: in
            *:"$x":*) ;;         # already there
            *) PATH=$PATH:$x;;   # not there yet
        esac
        old_PATH=${old_PATH#*:}
    done
    PATH=${PATH#:}
    unset old_PATH x _REMOVE_DUPLICATE_PATH
fi

# Export final PATH variable
export PATH
