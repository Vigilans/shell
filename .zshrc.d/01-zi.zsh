if [[ -r "${XDG_CONFIG_HOME:-$HOME/.config}/zi/init.zsh" ]]; then
    source "${XDG_CONFIG_HOME:-$HOME/.config}/zi/init.zsh" && zzinit
fi

# Programs
if ! command -v fzf &> /dev/null; then
    zi ice from'gh-r' as'program' atclone'
        ln -svf $PWD/fzf $ZPFX/bin
        wget https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh
        wget https://raw.githubusercontent.com/junegunn/fzf/master/man/man1/fzf.1
        wget https://raw.githubusercontent.com/junegunn/fzf/master/man/man1/fzf-tmux.1
        ln -svf $PWD/fzf.1 $ZPFX/man/man1
        ln -svf $PWD/fzf-tmux.1 $ZPFX/man/man1'
    zi light @junegunn/fzf
fi

if ! command -v bat &> /dev/null; then
    zi ice from'gh-r' as'program' mv'bat* release' atclone'
        ln -svf $PWD/release/bat $ZPFX/bin
        ln -svf $PWD/release/bat.1 $ZPFX/man/man1
        ln -svf $PWD/release/autocomplete/bat.zsh _bat'
    zi light @sharkdp/bat
fi

if ! command -v exa &> /dev/null; then
    zi ice from'gh-r' as'program' atclone'
        ln -svf $PWD/bin/exa $ZPFX/bin
        ln -svf $PWD/man/exa.1 $ZPFX/man/man1
        ln -svf $PWD/man/exa_colors.5 $ZPFX/man/man5
        ln -svf $PWD/completions/exa.zsh _exa'
    zi light ogham/exa
fi

if ! command -v delta &> /dev/null; then
    zi ice from'gh-r' as'program' mv'delta* release' atclone'
        ln -svf $PWD/release/delta $ZPFX/bin
        wget https://raw.githubusercontent.com/dandavison/delta/master/etc/completion/completion.zsh -O _delta' && \
    zi light dandavison/delta
fi

if ! command -v fd &> /dev/null; then
    zi ice from'gh-r' as'program' mv'fd* release' atclone'
        ln -svf $PWD/release/fd $ZPFX/bin
        ln -svf $PWD/release/fd.1 $ZPFX/man/man1
        ln -svf $PWD/autocomplete/_fd _fd'
    zi light @sharkdp/fd
fi

if ! command -v navi &> /dev/null; then
    zi ice from"gh-r" as'program' has'fzf' atclone'
        ln -svf $PWD/navi $ZPFX/bin'
    zi light denisidoro/navi
fi

# Plugins
zi light zsh-users/zsh-history-substring-search

zi ice wait lucid atinit"ZI[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay; zzcomps" has'fzf'
zi light Aloxaf/fzf-tab

zi ice wait lucid atload"!_zsh_autosuggest_start"
zi light zsh-users/zsh-autosuggestions

zi ice wait lucid
zi light z-shell/F-Sy-H

zi ice wait lucid
zi light agkozak/zsh-z

zi ice wait lucid
zi light reegnz/jq-zsh-plugin

zi ice atload'export PATH=$PATH:$FORGIT_INSTALL_DIR/bin'
FORGIT_NO_ALIASES=1 zi light wfxr/forgit

# Completions
zi ice wait lucid as'completion' blockf
zi light zsh-users/zsh-completions

zi ice wait lucid as'completion' blockf
zi light esc/conda-zsh-completion

zi ice wait lucid as'completion' blockf
zi snippet https://github.com/bazelbuild/bazel/blob/master/scripts/zsh_completion/_bazel

# Snippets
zi ice wait lucid
zi snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh
