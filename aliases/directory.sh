EZA_OPTIONS="--group --color-scale --time-style=iso"
EZA_TABLE_OPTIONS="--header --icons --classify --group-directories-first"
EZA_FULL_TABLE_OPTIONS="--git --links --inode --blocks --extended --created --modified --changed --accessed"

# Directories
alias ls='ls -h --color=auto'
alias la="eza -a $EZA_OPTIONS"
alias ll="eza -l $EZA_OPTIONS $EZA_TABLE_OPTIONS"
alias lla="eza -l -a $EZA_OPTIONS $EZA_TABLE_OPTIONS"
alias lll="eza -l $EZA_OPTIONS $EZA_TABLE_OPTIONS $EZA_FULL_TABLE_OPTIONS"
alias llla="eza -l -a $EZA_OPTIONS $EZA_TABLE_OPTIONS $EZA_FULL_TABLE_OPTIONS"
alias lt="eza --tree $EZA_OPTIONS $EZA_TABLE_OPTIONS"
alias lta="eza --tree -a $EZA_OPTIONS $EZA_TABLE_OPTIONS"

unset EZA_OPTIONS EZA_TABLE_OPTIONS EZA_FULL_TABLE_OPTIONS

# Dots
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
