if [[ -r "${XDG_CONFIG_HOME:-$HOME/.config}/zi/init.zsh" ]]; then
    source "${XDG_CONFIG_HOME:-$HOME/.config}/zi/init.zsh" && zzinit
    export MANPATH=":$MANPATH" # Fix MANPATH ignoring system default by prefixing a colon
else
    return 0
fi

# Programs
if ! command -v fzf &> /dev/null; then
    zi ice from'gh-r' as'program' atpull'%atclone' atclone'
        ln -svf $PWD/fzf $ZPFX/bin
        wget https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh
        wget https://raw.githubusercontent.com/junegunn/fzf/master/man/man1/fzf.1
        wget https://raw.githubusercontent.com/junegunn/fzf/master/man/man1/fzf-tmux.1
        ln -svf $PWD/fzf.1 $ZPFX/man/man1
        ln -svf $PWD/fzf-tmux.1 $ZPFX/man/man1'
    zi light @junegunn/fzf
fi

if ! command -v bat &> /dev/null; then
    zi ice from'gh-r' as'program' bpick"*$(host_triplet)*"  mv'bat* release' atclone'
        ln -svf $PWD/release/bat $ZPFX/bin
        ln -svf $PWD/release/bat.1 $ZPFX/man/man1
        ln -svf $PWD/release/autocomplete/bat.zsh _bat'
    zi light @sharkdp/bat
fi

if ! command -v exa &> /dev/null; then
    zi ice from'gh-r' as'program' bpick"*$(host_libc_using_musl)*" atclone'
        ln -svf $PWD/bin/exa $ZPFX/bin
        ln -svf $PWD/man/exa.1 $ZPFX/man/man1
        ln -svf $PWD/man/exa_colors.5 $ZPFX/man/man5
        ln -svf $PWD/completions/exa.zsh _exa'
    zi light ogham/exa
fi

if ! command -v delta &> /dev/null; then
    zi ice from'gh-r' as'program' bpick"*$(host_triplet)*" mv'delta* release' atpull'%atclone' atclone'
        ln -svf $PWD/release/delta $ZPFX/bin
        wget https://raw.githubusercontent.com/dandavison/delta/master/etc/completion/completion.zsh -O _delta'
    zi light dandavison/delta
fi

if ! command -v fd &> /dev/null; then
    zi ice from'gh-r' as'program' bpick"*$(host_triplet)*" mv'fd* release' atclone'
        ln -svf $PWD/release/fd $ZPFX/bin
        ln -svf $PWD/release/fd.1 $ZPFX/man/man1'
    zi light @sharkdp/fd
fi

if ! command -v rg &> /dev/null; then
    zi ice from'gh-r' as'program' bpick"ripgrep-*" mv'ripgrep* release' atclone'
        ln -svf $PWD/release/rg $ZPFX/bin
        ln -svf $PWD/release/doc/rg.1 $ZPFX/man/man1'
    zi light @BurntSushi/ripgrep
fi

if ! command -v micro &> /dev/null; then
    zi ice from"gh-r" as'program' mv'micro* release' atclone'
        ln -svf $PWD/release/micro $ZPFX/bin
        ln -svf $PWD/release/micro.1 $ZPFX/man/man1'
    zi light @zyedidia/micro
fi

if ! command -v hexyl &> /dev/null; then
    zi ice from'gh-r' as'program' bpick"*$(host_triplet)*" mv'hexyl* release' atclone'
        ln -svf $PWD/release/hexyl $ZPFX/bin
        ln -svf $PWD/release/hexyl.1 $ZPFX/man/man1'
    zi light @sharkdp/hexyl
fi

if ! command -v navi &> /dev/null; then
    zi ice from"gh-r" as'program' bpick"*$(host_triplet_trivial)*" has'fzf' atclone'
        ln -svf $PWD/navi $ZPFX/bin'
    zi light denisidoro/navi
fi

if ! command -v vivid &> /dev/null; then
    zi ice from"gh-r" as'program' bpick"*$(host_triplet)*" mv'vivid*/vivid vivid' atclone'
        ln -svf $PWD/vivid $ZPFX/bin'
    zi load @sharkdp/vivid
fi

if ! command -v bat-modules &> /dev/null; then
    zi ice from"gh-r" as'program' has'bat' atclone'
        for sh in $PWD/bin/*; do ln -svf $sh $ZPFX/bin; done
        for sh in $PWD/man/*; do ln -svf $sh $ZPFX/man/man1; done'
    zi light eth-p/bat-extras
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

zi ice wait lucid as'completion' blockf
zi snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

zi ice wait lucid as'program' has'bat' atload'
    compdef _man batman
    compdef _rg ripgrep batgrep
    compdef _delta batdiff
    zi unload -q eth-p/bat-extras'
zi light eth-p/bat-extras

# Snippets
# zi ice wait lucid
# zi snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh
