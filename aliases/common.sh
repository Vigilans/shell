# Human friendly option
alias df='df -h'
alias du='du -h'
alias free='free -h'

if type nano 1>/dev/null 2>&1 && [ "$(readlink $(which nano))" != "pico" ]; then
    alias nano='nano -l'
fi

# Interactive
if [ -z "$CLAUDECODE" ]; then # Do not enable in Claude Code shell snapshot
    alias cp='cp -i'
    # alias rm='rm -i'
fi
