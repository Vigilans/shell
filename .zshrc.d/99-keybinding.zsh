# Speical keys
bindkey '^[[C'  forward-char                                    # Right key
bindkey '^[[D'  backward-char                                   # Left key
bindkey '^[[A'  history-substring-search-up			            # Up key, depends on zsh-history-substring-search
bindkey '^[[B'  history-substring-search-down                   # Down key, depends on zsh-history-substring-search
bindkey '^[[5~' history-beginning-search-backward               # Page up key
bindkey '^[[6~' history-beginning-search-forward                # Page down key
bindkey '^[[7~' beginning-of-line                               # Home key
bindkey '^[[H'  beginning-of-line                               # Home key
bindkey '^[[8~' end-of-line                                     # End key
bindkey '^[[F'  end-of-line                                     # End key
bindkey '^[[2~' overwrite-mode                                  # Insert key
bindkey '^[[3~' delete-char                                     # Delete key

# Navigate words with Ctrl + Arrow keys
bindkey '^[Oc'    forward-word                                  # Ctrl + Right
bindkey '^[Od'    backward-word                                 # Ctrl + Left
bindkey '^[[1;5C' forward-word                                  # Ctrl + Right
bindkey '^[[1;5D' backward-word                                 # Ctrl + Left
bindkey '^[^H'    backward-kill-word                            # Ctrl + Backspace: delete previous word
bindkey '^[[Z'    undo                                          # Shift + TAB: undo last action

# Miscellaneous
bindkey '^Xh' _complete_help                                    # Ctrl + X, H: Show completion contexts and tags
bindkey '^X?' _complete_debug                                   # Ctrl + X, ?: Debug completion

# Clipboard binding
if command -v xclip &> /dev/null && [ -n "$DISPLAY" ]; then
    function paste-from-clipboard() { RBUFFER="$(xclip -o -selection clipboard)$RBUFFER" }
    zle -N paste-from-clipboard
    bindkey '^V' paste-from-clipboard # Ctrl + V: paste from clipboard grabbed from xclip
else
    bindkey -r "^V" # Unbind Ctrl + V, so not to trigger ^[[200~ ~ (bracketed paste mode)
fi

# Fzf binding
if command -v fzf &> /dev/null; then
    if [ -r /usr/share/fzf/key-bindings.zsh ]; then
        source /usr/share/fzf/key-bindings.zsh
    elif type zi &> /dev/null; then
        fzf_keybindings=$(zi run junegunn/fzf realpath key-bindings.zsh)
        [ -r $fzf_keybindings ] && source $fzf_keybindings
        unset fzf_keybindings
    fi
fi

# Navi binding
if command -v navi &> /dev/null; then
    eval "$(navi widget zsh)"
fi
