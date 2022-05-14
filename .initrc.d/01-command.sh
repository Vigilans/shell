# command.sh: setup scripts for executable files.

if [ -d $SHELL_CONFIG_HOME/commands ]; then
    # Try giving all files in directory +x permission, and append directory to path if any executable exists.
    if find $SHELL_CONFIG_HOME/commands -maxdepth 1 -type f -o -type l -not -name ".*" -print -not -exec test -x {} \; -exec chmod +x {} \; | grep -q .; then
        export PATH=$SHELL_CONFIG_HOME/commands:$PATH
    fi
fi

if [ -d $SHELL_CONFIG_HOME/commands/local ]; then
    if find $SHELL_CONFIG_HOME/commands/local -maxdepth 1 -type f -o -type l -not -name ".*" -print -not -exec test -x {} \; -exec chmod +x {} \; | grep -q .; then
        export PATH=$SHELL_CONFIG_HOME/commands/local:$PATH
    fi
fi
