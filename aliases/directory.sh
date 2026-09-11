# Directories
if command -v eza &> /dev/null; then
    EZA_OPTIONS="--group --color-scale --time-style=iso"
    EZA_TABLE_OPTIONS="--header --icons --classify --group-directories-first"
    EZA_FULL_TABLE_OPTIONS="--git --links --inode --extended --created --modified --changed --accessed"

    alias ls='eza -h'
    alias la="eza -a $EZA_OPTIONS"
    alias ll="eza -l $EZA_OPTIONS $EZA_TABLE_OPTIONS"
    alias lla="eza -l -a $EZA_OPTIONS $EZA_TABLE_OPTIONS"
    alias lll="eza -l $EZA_OPTIONS $EZA_TABLE_OPTIONS $EZA_FULL_TABLE_OPTIONS"
    alias llla="eza -l -a $EZA_OPTIONS $EZA_TABLE_OPTIONS $EZA_FULL_TABLE_OPTIONS"
    alias lt="eza --tree $EZA_OPTIONS $EZA_TABLE_OPTIONS"
    alias lta="eza --tree -a $EZA_OPTIONS $EZA_TABLE_OPTIONS"

    unset EZA_OPTIONS EZA_TABLE_OPTIONS EZA_FULL_TABLE_OPTIONS
fi

# Dots
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
