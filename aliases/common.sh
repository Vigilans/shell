# Human friendly option
alias df='df -h'
alias du='du -h'
alias free='free -h'

if type nano 1>/dev/null 2>&1 && [ "$(readlink $(which nano))" != "pico" ]; then
    alias nano='nano -l'
fi

# Interactive
alias cp='cp -i'
# alias rm='rm -i'
