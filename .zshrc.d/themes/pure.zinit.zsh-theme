# Load pure theme through zi
zinit light-mode for compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh' id-as sindresorhus/pure

# Configure options
zstyle ':prompt:pure:prompt:success' color '36'
zstyle ':prompt:pure:user' color '78'
zstyle ':prompt:pure:host' color '78'
zstyle ':prompt:pure:git:branch' color '214'
zstyle ':prompt:pure:suspended_jobs' color '105'
zstyle ':prompt:pure:execution_time' color 'cyan'

# Adaptation for tty low-color display
if [[ "$TERM" = "linux" ]] || [[ "$TERM" != "xterm-kitty" ]] && [[ "$(tput colors)" = "8" ]]; then
    SHELL_LOW_COLOR=1
    PURE_PROMPT_SYMBOL=">"
    PURE_PROMPT_VICMD_SYMBOL="<"
    PURE_GIT_DOWN_ARROW="↓"
    PURE_GIT_UP_ARROW="↑"
    PURE_SUSPEND_JOB_SYMBOL="♦"
    zstyle ':prompt:pure:prompt:success' color 'green'
    zstyle ':prompt:pure:user' color 'green'
    zstyle ':prompt:pure:host' color 'green'
    zstyle ':prompt:pure:git:branch' color 'yellow'
    zstyle ':prompt:pure:suspended_jobs' color 'magenta'
fi

# If domain name non empty and not local/localdomain, show its full FQDN
SHELL_DOMAIN_NAME=$(hostname -d)
case "$SHELL_DOMAIN_NAME" in
    local)       ;&
    localdomain) ;&
    "(none)")    unset SHELL_DOMAIN_NAME ;;
    "")          unset SHELL_DOMAIN_NAME ;;
esac

# Enable only certain async tasks of small cost
prompt_pure_async_refresh() {
    async_job "prompt_pure" prompt_pure_async_git_arrows
    async_job "prompt_pure" prompt_pure_async_git_stash
    if zstyle -t ":prompt:pure:git:dirty" show; then
        async_job "prompt_pure" prompt_pure_async_git_dirty ${PURE_GIT_UNTRACKED_DIRTY:-1}
    fi
}

# Compose prompt and render
prompt_pure_preprompt_render() {
	setopt localoptions noshwordsplit
	unset prompt_pure_async_render_requested

    # Setup each component
    local -a preprompt_time_part
    preprompt_time_part+=('%F{$prompt_pure_colors[execution_time]}%*%f') # Reuse the execution_time color.

    local -a preprompt_user_part
    [[ -n $WSL_DISTRO_NAME ]] && prompt_pure_state[username]='%F{$prompt_pure_colors[user]}%n%f%F{$prompt_pure_colors[host]}@%m%f' # Always show username in WSL
    # New upstream (>=1.27.0) no longer populates prompt_pure_state[username]; prompt_pure_state[user_color] is set by upstream when user@host should display (SSH/container/root).
    [[ -z $prompt_pure_state[username] ]] && [[ -n $prompt_pure_state[user_color] ]] && prompt_pure_state[username]='%F{$prompt_pure_colors['"${prompt_pure_state[user_color]}"']}%n%f%F{$prompt_pure_colors[host]}@%m%f'
    [[ -n $SHELL_DOMAIN_NAME ]] && prompt_pure_state[username]="${prompt_pure_state[username]/\%m\%f/%m.$SHELL_DOMAIN_NAME%f}"
    [[ -n $prompt_pure_state[username] ]] && preprompt_user_part+=($prompt_pure_state[username]) # Username and machine, if applicable.

    local -a preprompt_path_part
	preprompt_path_part+=('%F{${prompt_pure_colors[path]}}%~%f') # Set the path.

    local -a preprompt_git_part
    typeset -gA prompt_pure_vcs_info
	[[ -n $prompt_pure_vcs_info[branch] ]] && preprompt_git_part+=("%F{$prompt_pure_colors[git:branch]}"'${prompt_pure_vcs_info[branch]}'"%F{$prompt_pure_colors[git:dirty]}"'${prompt_pure_git_dirty}%f') # Git branch and dirty status info.
	[[ -n $prompt_pure_vcs_info[action] ]] && preprompt_git_part+=("%F{$prompt_pure_colors[git:action]}"'$prompt_pure_vcs_info[action]%f') # Git action (for example, merge).
	[[ -n $prompt_pure_git_arrows ]] && preprompt_git_part+=('%F{$prompt_pure_colors[git:arrow]}${prompt_pure_git_arrows}%f') # Git pull/push arrows.
	[[ -n $prompt_pure_git_stash ]]  && preprompt_git_part+=('%F{$prompt_pure_colors[git:stash]}${PURE_GIT_STASH_SYMBOL:-≡}%f') # Git stash symbol (if opted in).

    local -a preprompt_misc_part
    ((${(M)#jobstates:#suspended:*} != 0)) && preprompt_misc_part+=('%F{$prompt_pure_colors[suspended_jobs]}${PURE_SUSPEND_JOB_SYMBOL:-✦}%f') # Suspended jobs in background.
    [[ -n $prompt_pure_cmd_exec_time ]] && preprompt_misc_part+=('(%F{$prompt_pure_colors[execution_time]}${prompt_pure_cmd_exec_time}%f)') # Execution time.

	# Combine all preprompt parts.
	local -a preprompt_parts
    preprompt_parts+=("[${(j. .)preprompt_time_part}]")
    [[ ${#preprompt_user_part} -gt 0 ]] && preprompt_parts+=("[${(j. .)preprompt_user_part}]")
    preprompt_parts+=("[${(j. .)preprompt_path_part}]")
    [[ ${#preprompt_git_part}  -gt 0 ]] && preprompt_parts+=("[${(j. .)preprompt_git_part}]")
    [[ ${#preprompt_misc_part} -gt 0 ]] && preprompt_parts+=("${(j. .)preprompt_misc_part}")

    # Extract the prompt part at second line.
    # Feature-detect upstream's PROMPT separator format:
    #   - pure >=1.27.0 (PR #706): PROMPT is built once at setup with literal ${prompt_newline} text, expanded by prompt_subst at render time.
    #   - older pure: PROMPT is rebuilt each render with the actual newline character spliced in.
	local ps1_prompt=$PROMPT
	local newline_sep=$prompt_newline
	local -H MATCH MBEGIN MEND
	if [[ $PROMPT = *'${prompt_newline}'* ]]; then
		ps1_prompt=${PROMPT##*'${prompt_newline}'}
		newline_sep='${prompt_newline}'
	elif [[ $PROMPT = *$prompt_newline* ]]; then
		ps1_prompt=${PROMPT##*${prompt_newline}}
	fi
	unset MATCH MBEGIN MEND

    # VIRTUAL_ENV_PROMPT not used by upstream, we detect it here with highest priority.
    # The slot upstream reserves for virtualenv is version-dependent (12 in old, 20 in >=1.27.0).
    # $VIRTUAL_ENV_DISABLE_PROMPT carries the slot number — use it for version-agnostic dispatch.
    if [[ -n "$VIRTUAL_ENV_PROMPT" ]] && [[ -n "$VIRTUAL_ENV_DISABLE_PROMPT" ]]; then
        psvar[$VIRTUAL_ENV_DISABLE_PROMPT]="$VIRTUAL_ENV_PROMPT"
    fi

	# Construct the new prompt with a clean preprompt.
	local -ah ps1=(
		${(j.-.)preprompt_parts}  # Join parts, dash separated.
		$newline_sep              # Separate preprompt and prompt (matches upstream's format).
		$ps1_prompt               # Prompt part at the command input line
	)
	PROMPT="${(j..)ps1}"

	# Expand the prompt for future comparision.
	local expanded_prompt="${(S%%)PROMPT}"
	[[ $prompt_pure_last_prompt != $expanded_prompt ]] && prompt_pure_reset_prompt # Redraw the prompt.
	typeset -g prompt_pure_last_prompt=$expanded_prompt
}

# Show red exit code on right prompt
precmd_pipestatus() {
    local exitcodes="${(j.|.)pipestatus}"
    if ! [[ "$exitcodes" =~ ^[0\|]+$ ]]; then
        RPROMPT="%F{$prompt_pure_colors[prompt:error]}[$exitcodes]%f"
    elif [[ -z "$SHELL_LOW_COLOR" ]]; then
        RPROMPT="%{$(printf %b '\u200b')%}" # Use zero width space to prevent a weird backspace bug in VSCode Remote SSH Terminal; %{%} marks it as zero-width so zsh doesn't reserve a column (which Windows ssh clients render by trimming PROMPT's trailing space).
    fi
}
add-zsh-hook precmd precmd_pipestatus

# Setup LS_COLORS
if command vivid generate one-dark 1>/dev/null 2>&1; then
    export LS_COLORS="$(command vivid generate one-dark)"
fi
