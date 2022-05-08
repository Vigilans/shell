if [ -n "$ANACONDA_HOME" ]; then
    if [ -n "$BASH_VERSION" ]; then
        __setup_script='shell.bash'
    elif [ -n "$ZSH_VERSION" ]; then
        __setup_script='shell.zsh'
    fi
    __conda_setup="$($ANACONDA_HOME/bin/conda $__setup_script 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "$ANACONDA_HOME/etc/profile.d/conda.sh" ]; then
            . "$ANACONDA_HOME/etc/profile.d/conda.sh"
        else
            export PATH="$ANACONDA_HOME/bin:$PATH"
        fi
    fi
    unset __setup_script __conda_setup
fi
