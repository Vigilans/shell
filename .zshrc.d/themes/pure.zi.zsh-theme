# Load pure theme through zi
zi light-mode for compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh' sindresorhus/pure

# Configure options
zstyle ':prompt:pure:prompt:success' color '36'
zstyle ':prompt:pure:user' color '78'
zstyle ':prompt:pure:host' color '78'
zstyle ':prompt:pure:git:branch' color '214'
zstyle ':prompt:pure:suspended_jobs' color '105'
zstyle ':prompt:pure:execution_time' color 'cyan'

# Adaptation for tty low-color display
if [[ "$TERM" = "linux" ]] || [[ "$(tput colors)" = "8" ]]; then
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

    # Extract the prompt part at second line
	local ps1_prompt=$PROMPT
	local -H MATCH MBEGIN MEND
	if [[ $PROMPT = *$prompt_newline* ]]; then
		ps1_prompt=${PROMPT##*${prompt_newline}} # Remove everything from the prompt until the newline. This removes the preprompt and only the original PROMPT remains.
	fi
	unset MATCH MBEGIN MEND

	# Construct the new prompt with a clean preprompt.
	local -ah ps1=(
		${(j.-.)preprompt_parts}  # Join parts, dash separated.
		$prompt_newline           # Separate preprompt and prompt.
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
        RPROMPT="$(printf %b '\u200b')" # Use zero width space to prevent a weird backspace bug in VSCode Remote SSH Terminal
    fi
}
add-zsh-hook precmd precmd_pipestatus

# Setup LS_COLORS
zi ice from"gh-r" as'program' bpick"*$(host_triplet)*" mv'vivid*/vivid vivid' atload'export LS_COLORS="$(vivid generate molokai)"'
zi load @sharkdp/vivid
zi unload -q sharkdp/vivid
