autoload -U colors
colors

# Colored ls
if [ -z "$LS_COLORS" ]; then
    eval $(dircolors)
fi

# colored GCC warnings and errors
if [ -z "$GCC_COLORS" ]; then
    export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
fi
