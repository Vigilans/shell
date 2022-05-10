# [ctrl-t/alt-c] Preview with exa and tree
export FZF_CTRL_T_OPTS="--preview '[ -d {} ] && exa -1 --git -lh --no-time --color=always --icons {} || bat --style=numbers --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

# [fzf-tab] Use Space key to accept
zstyle ':fzf-tab:*' fzf-bindings 'space:accept'
zstyle ':fzf-tab:*' switch-group ',' '.'

# [environment variable and functions] Preview variable content
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' fzf-preview \
'if [[ -v $word ]]; then
	word_is_variable=1
else
	_INITRC_SH_FORCE_LOAD=1 source $SHELL_CONFIG_HOME/initrc.sh
	if typeset -f $word > /dev/null; then
		typeset -f $word | bat --language=sh --style=numbers --color=always --line-range :500
	elif [[ -v $word ]]; then
		word_is_variable=1
	else
		echo "\033[1;34m$word\033[0m";
		echo "Variable not exported."
	fi
fi
if [[ -n "$word_is_variable" ]]; then
	echo "\033[1;34m$word\033[0m"; echo "\033[0;32mtype:\033[0m ${(t)${(P)word}}"; echo -n "\033[0;32mvalue:\033[0m "
	if [[ "${(t)${(P)word}}" == "association"* ]]; then
		print; for k v in ${(kv)${(P)word}}; do echo "$k \033[1;33m->\033[0m $v"; done
	elif [[ "${(t)${(P)word}}" == "array"* ]]; then
		print; for v in ${(P)word[@]}; do echo $v; done
	elif [[ $word == *"PATH" ]]; then
		print; echo ${(P)word} | xargs -d : -n 1;
	else
		echo ${(P)word}
	fi
fi
'

# [file] Preview with different strategies (e.g. bat (file) or exa (directory))
zstyle ':fzf-tab:complete:(ls|cat):*' fzf-preview '[ -d $realpath ] && exa -1 --git -lh --no-time --color=always --icons $realpath || bat --style=numbers --color=always --line-range :500 $realpath'

# [cd] Preview with exa
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --git -lh --no-time --color=always --icons $realpath'

# [man/run-help]
zstyle ':fzf-tab:complete:(\\|)run-help:*' fzf-preview 'run-help $word'
zstyle ':fzf-tab:complete:(\\|*/|)man:*' fzf-preview 'man $word'

# [kill/ps] Preview of full commandline arguments
zstyle ':completion:*:*:*:*:processes' command "ps -ef"
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap

# [systemd] Preview systemd unit status
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'

# [git]
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview 'git diff $word | delta'
zstyle ':fzf-tab:complete:git-log:*' fzf-preview 'git log --color=always $word'
zstyle ':fzf-tab:complete:git-help:*' fzf-preview 'git help $word | bat -plman --color=always'
zstyle ':fzf-tab:complete:git-show:*' fzf-preview \
'case "$group" in
	"commit tag") git show --color=always $word ;;
	*) git show --color=always $word | delta ;;
esac'
zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
'case "$group" in
	"modified file") git diff $word | delta ;;
	"recent commit object name") git show --color=always $word | delta ;;
	*) git log --color=always $word ;;
esac'
