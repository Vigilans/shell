EXA_OPTIONS="--group --color-scale --time-style=iso"
EXA_TABLE_OPTIONS="--header --icons --classify --group-directories-first"
EXA_FULL_TABLE_OPTIONS="--git --links --inode --blocks --extended --created --modified --changed --accessed"

# Directories
alias ls='ls -h --color=auto'
alias la="exa -a $EXA_OPTIONS"
alias ll="exa -l $EXA_OPTIONS $EXA_TABLE_OPTIONS"
alias lla="exa -l -a $EXA_OPTIONS $EXA_TABLE_OPTIONS"
alias lll="exa -l $EXA_OPTIONS $EXA_TABLE_OPTIONS $EXA_FULL_TABLE_OPTIONS"
alias llla="exa -l -a $EXA_OPTIONS $EXA_TABLE_OPTIONS $EXA_FULL_TABLE_OPTIONS"
alias lt="exa --tree $EXA_OPTIONS $EXA_TABLE_OPTIONS"
alias lta="exa --tree -a $EXA_OPTIONS $EXA_TABLE_OPTIONS"

unset EXA_OPTIONS EXA_TABLE_OPTIONS EXA_FULL_TABLE_OPTIONS

# Dots
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
