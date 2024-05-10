# Load zinit
export ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
source "$ZINIT_HOME/zinit.zsh" || return 0
[ -e "$ZPFX/bin" ] || mkdir -p "$ZPFX/bin"
[ -e "$ZPFX/man" ] || mkdir -p "$ZPFX/man"/man{1..9}
[ -e "$ZSH_CACHE_DIR/completions" ] || mkdir -p "$ZSH_CACHE_DIR/completions"

# Programs
if ! command -v fzf &> /dev/null; then
    zinit ice from'gh-r' as'program' atpull'%atclone' atclone'
        ln -svf $PWD/fzf $ZPFX/bin
        wget https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh
        wget https://raw.githubusercontent.com/junegunn/fzf/master/man/man1/fzf.1
        wget https://raw.githubusercontent.com/junegunn/fzf/master/man/man1/fzf-tmux.1
        ln -svf $PWD/fzf.1 $ZPFX/man/man1
        ln -svf $PWD/fzf-tmux.1 $ZPFX/man/man1'
    zinit light @junegunn/fzf
fi

if ! command -v bat &> /dev/null; then
    zinit ice from'gh-r' as'program' bpick"*$(HOST_TRIPLET_APPLE_USE_INTEL=1 host_triplet)*" mv'bat* release' atclone'
        ln -svf $PWD/release/bat $ZPFX/bin
        ln -svf $PWD/release/bat.1 $ZPFX/man/man1
        ln -svf $PWD/release/autocomplete/bat.zsh _bat'
    zinit light @sharkdp/bat
fi

if ! command -v exa &> /dev/null; then
    zinit ice from'gh-r' as'program' bpick"*$(HOST_TRIPLET_APPLE_USE_INTEL=1 host_libc_using_musl)*" atclone'
        ln -svf $PWD/bin/exa $ZPFX/bin
        ln -svf $PWD/man/exa.1 $ZPFX/man/man1
        ln -svf $PWD/man/exa_colors.5 $ZPFX/man/man5
        ln -svf $PWD/completions/exa.zsh _exa'
    zinit light ogham/exa
fi

if ! command -v delta &> /dev/null; then
    zinit ice from'gh-r' as'program' bpick"*$(HOST_LIBC_PREFER_MUSL=1 host_triplet)*" mv'delta* release' atpull'%atclone' atclone'
        ln -svf $PWD/release/delta $ZPFX/bin
        wget https://raw.githubusercontent.com/dandavison/delta/master/etc/completion/completion.zsh -O _delta'
    zinit light dandavison/delta
fi

if ! command -v fd &> /dev/null; then
    zinit ice from'gh-r' as'program' bpick"*$(HOST_TRIPLET_APPLE_USE_INTEL=1 host_triplet)*" mv'fd* release' atclone'
        ln -svf $PWD/release/fd $ZPFX/bin
        ln -svf $PWD/release/fd.1 $ZPFX/man/man1'
    zinit light @sharkdp/fd
fi

if ! command -v rg &> /dev/null; then
    zinit ice from'gh-r' as'program' bpick"ripgrep-*" mv'ripgrep* release' atclone'
        ln -svf $PWD/release/rg $ZPFX/bin
        ln -svf $PWD/release/doc/rg.1 $ZPFX/man/man1'
    zinit light @BurntSushi/ripgrep
fi

if ! command -v yq &> /dev/null; then
    zinit ice from'gh-r' as'program' mv'yq* yq' atclone'
        ln -svf $PWD/yq $ZPFX/bin'
    zinit light mikefarah/yq
fi

if ! command -v hexyl &> /dev/null; then
    zinit ice from'gh-r' as'program' bpick"*$(HOST_TRIPLET_APPLE_USE_INTEL=1 host_triplet)*" mv'hexyl* release' atclone'
        ln -svf $PWD/release/hexyl $ZPFX/bin
        ln -svf $PWD/release/hexyl.1 $ZPFX/man/man1'
    zinit light @sharkdp/hexyl
fi

if ! command -v dust &> /dev/null; then
    zinit ice from'gh-r' as'program' bpick"*$(HOST_TRIPLET_APPLE_USE_INTEL=1 host_triplet)*" mv'dust* release' atclone'
        ln -svf $PWD/release/dust $ZPFX/bin'
    zinit light @bootandy/dust
fi

if ! command -v procs &> /dev/null && [[ "$(uname -m)" = "x86_64" ]]; then
    zinit ice from'gh-r' as'program' atclone'
        ln -svf $PWD/procs $ZPFX/bin'
    zinit light @dalance/procs
fi

if ! command -v btm &> /dev/null; then
    zinit ice from'gh-r' as'program' bpick"*$(host_triplet)*" atclone'
        ln -svf $PWD/btm $ZPFX/bin
        ln -svf $PWD/completion/_btm _btm'
    zinit light @ClementTsang/bottom
fi

if ! command -v navi &> /dev/null; then
    zinit ice from"gh-r" as'program' bpick"*$(host_triplet_trivial)*" has'fzf' atclone'
        ln -svf $PWD/navi $ZPFX/bin'
    zinit light denisidoro/navi
fi

if ! command -v vivid &> /dev/null; then
    zinit ice from"gh-r" as'program' bpick"*$(HOST_TRIPLET_APPLE_USE_INTEL=1 host_triplet)*" mv'vivid*/vivid vivid' atclone'
        ln -svf $PWD/vivid $ZPFX/bin'
    zinit load @sharkdp/vivid
fi

if ! command -v bat-modules &> /dev/null; then
    zinit ice from"gh-r" as'program' has'bat' atclone'
        for sh in $PWD/bin/*; do ln -svf $sh $ZPFX/bin; done
        for sh in $PWD/man/*; do ln -svf $sh $ZPFX/man/man1; done'
    zinit light eth-p/bat-extras
fi

# Completions
zinit ice wait lucid as'completion' blockf
zinit light zsh-users/zsh-completions

zinit ice wait lucid as'null' atload'
    compdef _man batman
    compdef _rg ripgrep batgrep
    compdef _delta batdiff'
zinit light eth-p/bat-extras

# Completion snippets
function zinit_snippet_completion_from_stdin() {
    local command=$1
    local completion_cmdline=$2
    if ! [ -r "$ZSH_CACHE_DIR/completions/_$command" ]; then
        local completion
        if [ -n "$completion_cmdline" ]; then
            completion=$(${(z)completion_cmdline})
        else
            read -d '' -r completion
        fi
        if [ -z "$completion" ]; then
            return 1
        fi
        echo "$completion" > "$ZSH_CACHE_DIR/completions/_$command"
    fi
    zinit ice wait lucid as'completion' blockf
    zinit snippet "$ZSH_CACHE_DIR/completions/_$command"
}

if command -v docker &> /dev/null; then
    if ! zinit_snippet_completion_from_stdin docker 'docker completion zsh'; then
        zinit ice wait lucid as'completion' blockf
        zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker
    fi
fi

if command -v docker-compose &> /dev/null; then
    zinit ice wait lucid as'completion' blockf
    zinit snippet https://github.com/docker/compose/blob/1.29.2/contrib/completion/zsh/_docker-compose # Last version that has the completion script
fi

for command in kubectl helm kind; do
    command -v $command &> /dev/null && zinit_snippet_completion_from_stdin $command "$command completion zsh"
done
unset command

if command -v brew &> /dev/null; then
    zinit ice wait lucid as'completion' blockf
    zinit snippet $(brew --prefix)/share/zsh/site-functions/_brew
fi

if command -v conda &> /dev/null; then
    zinit ice wait lucid as'completion' blockf
    zinit light esc/conda-zsh-completion
fi

if command -v bazel &> /dev/null; then
    zinit ice wait lucid as'completion' blockf
    zinit snippet https://github.com/bazelbuild/bazel/blob/master/scripts/zsh_completion/_bazel
fi

if [ -r "$HOME/.local/lib/kw/_kw" ]; then
    zinit ice wait lucid as'completion' blockf
    zinit snippet "$HOME/.local/lib/kw/_kw"
fi

for completion in $SHELL_RC_HOME/vendors/completions/_*; do
    if [ -r "$completion" ] && command -v ${${completion:t}#_} &> /dev/null; then
        zinit ice wait lucid as'completion' blockf
        zinit snippet "$completion"
    fi
done
unset completion

# External program shell integration
if command -v alacritty &> /dev/null; then
    zinit ice wait lucid as'completion' blockf atpull'%atclone' atclone'
        wget https://github.com/alacritty/alacritty/releases/latest/download/alacritty.1.gz
        wget https://github.com/alacritty/alacritty/releases/latest/download/alacritty-msg.1.gz
        wget https://github.com/alacritty/alacritty/releases/latest/download/Alacritty.desktop
        wget https://github.com/alacritty/alacritty/releases/latest/download/Alacritty.svg
        mkdir -p $HOME/.local/share/applications $HOME/.local/share/icons/hicolor/scalable/apps
        ln -svf $PWD/alacritty.1.gz $ZPFX/man/man1
        ln -svf $PWD/alacritty-message.1.gz $ZPFX/man/man1
        ln -svf $PWD/Alacritty.desktop $HOME/.local/share/applications
        ln -svf $PWD/Alacritty.svg $HOME/.local/share/icons/hicolor/scalable/apps'
    zinit snippet https://github.com/alacritty/alacritty/blob/master/extra/completions/_alacritty
fi

# Plugin Snippets
# zinit ice wait lucid
# zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh

# Plugins
zinit light zsh-users/zsh-history-substring-search

zinit ice wait lucid atload"!_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions

zinit ice wait lucid
zinit light zdharma/fast-syntax-highlighting

zinit ice wait lucid
zinit light agkozak/zsh-z

zinit ice wait lucid
zinit light reegnz/jq-zsh-plugin

zinit ice atload'export PATH=$PATH:$FORGIT_INSTALL_DIR/bin'
FORGIT_NO_ALIASES=1 zinit light wfxr/forgit\

zinit ice wait lucid atload"zpcompinit; zpcdreplay" # Put compinit at last lazy load completion plugin
zinit light Aloxaf/fzf-tab
