autoload -Uz promptinit vcs_info
promptinit

setopt prompt_subst

# Adaptation for tty low-color display
if [[ "$TERM" = "linux" ]] || [[ "$(tput colors)" = "8" ]]; then
    SHELL_LOW_COLOR=1
fi

# Nicely formatted terminal prompt
function prompt_command() {
    # Preprompt
    PS1=""

    # System time
    PS1+="%B%F{black}[%b"
    PS1+="%F{blue}%*"
    PS1+="%B%F{black}]%b"

    # User and host
    PS1+="%B%F{black}-[%b"
    PS1+="%F{green}%n%F{yellow}@%F{green}%m"
    PS1+="%B%F{black}]%b"

    # Working directory path
    PS1+="%B%F{black}-[%b"
    PS1+="%F{magenta}%~"
    PS1+="%B%F{black}]%b"

    # Git info
    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' use-simple true
    zstyle ':vcs_info:*' max-exports 3 # Only export four message variables from `vcs_info`.
    zstyle ':vcs_info:git*' formats '%b' '%R' '%a' # Export branch (%b), Git toplevel (%R), action (rebase/cherry-pick) (%a)
    zstyle ':vcs_info:git*' actionformats '%b' '%R' '%a'
    vcs_info
    if [[ -n "$vcs_info_msg_1_" ]]; then
        PS1+="%B%F{black}-[%b"
        PS1+="%F{yellow}${vcs_info_msg_0_//\%/%%}" # Branch info
		local ref=$(command git symbolic-ref -q HEAD)
		local remote=$(command git for-each-ref --format='%(upstream:remotename)' $ref) # Set remote to only fetch information for the current branch.
		if [[ -n $remote ]]; then # Remote exists
            command git rev-list --left-right --count HEAD...@'{u}' | read left right
            if (( right > 0 )); then
                PS1+=" %F{cyan}↓" # Pull info
            fi
            if (( left > 0 )); then
                PS1+=" %F{cyan}↑" # Push info
            fi
		fi
        if [[ -n "$(command git rev-list --walk-reflogs --count refs/stash 2>/dev/null)" ]]; then
            PS1+=" %F{cyan}≡" # Stash info
        fi
        PS1+="%B%F{black}]%b%f"
    fi

    # Misc info
    if ((${(M)#jobstates:#suspended:*} != 0)); then
		PS1+='%F{magenta}♦' # Background jobs info
	fi

    # Prompt
    PS1+="$prompt_newline" # new line

    # Check for virtual env
	if [[ -n $CONDA_DEFAULT_ENV ]]; then
		PS1+="%B%F{black}(${CONDA_DEFAULT_ENV//[$'\t\r\n']})%f%b "
    elif [[ -n $VIRTUAL_ENV ]]; then
        PS1+="%B%F{black}(${VIRTUAL_ENV:t})%f%b "
    fi

    # Prompt symbol colored according to exit code
    PS1+="%(?.%f.%F{red})\$%f "
}

function rprompt_command() {
    # Right prompt
    local exitcodes="${(j.|.)pipestatus}"
    if ! [[ "$exitcodes" =~ ^[0\|]+$ ]]; then
        RPROMPT="%F{red}[$exitcodes]%f"
    elif [[ -z "$SHELL_LOW_COLOR" ]]; then
        RPROMPT="$(printf %b '\u200b')" # Use zero width space to prevent a weird backspace bug in VSCode Remote SSH Terminal
    fi
}

add-zsh-hook precmd prompt_command
add-zsh-hook precmd rprompt_command

# Setup LS_COLORS
export LS_COLORS="$(command vivid generate one-dark)"
