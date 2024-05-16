# Load zinit
export ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit"
source "$ZINIT_HOME/zinit.git/zinit.zsh" || return 0
[ -e "$ZPFX/bin" ] || mkdir -p "$ZPFX/bin"
[ -e "$ZPFX/man" ] || mkdir -p "$ZPFX/man"/man{1..9}
[ -e "$ZSH_CACHE_DIR/completions" ] || mkdir -p "$ZSH_CACHE_DIR/completions"
[[ ":$PATH:" != *":$ZPFX/bin:"* ]] && export PATH="$ZPFX/bin:$PATH"

# Programs
if ! command -v fzf &> /dev/null; then
    zinit ice from'gh-r' id-as as'program' atpull'%atclone' atclone'
        ln -svf $PWD/fzf $ZPFX/bin
        wget https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh
        wget https://raw.githubusercontent.com/junegunn/fzf/master/man/man1/fzf.1
        wget https://raw.githubusercontent.com/junegunn/fzf/master/man/man1/fzf-tmux.1
        ln -svf $PWD/fzf.1 $ZPFX/man/man1
        ln -svf $PWD/fzf-tmux.1 $ZPFX/man/man1'
    zinit light junegunn/fzf
fi

if ! command -v bat &> /dev/null; then # `cat` alternative
    zinit ice from'gh-r' id-as as'program' bpick"*$(HOST_TRIPLET_APPLE_USE_INTEL=1 host_triplet)*" mv'bat* release' atclone'
        ln -svf $PWD/release/bat $ZPFX/bin
        ln -svf $PWD/release/bat.1 $ZPFX/man/man1
        ln -svf $PWD/release/autocomplete/bat.zsh _bat'
    zinit light sharkdp/bat
fi

if ! command -v exa &> /dev/null; then # `ls` alternative
    zinit ice from'gh-r' id-as as'program' bpick"*$(HOST_TRIPLET_APPLE_USE_INTEL=1 host_libc_using_musl)*" atclone'
        ln -svf $PWD/bin/exa $ZPFX/bin
        ln -svf $PWD/man/exa.1 $ZPFX/man/man1
        ln -svf $PWD/man/exa_colors.5 $ZPFX/man/man5
        ln -svf $PWD/completions/exa.zsh _exa'
    zinit light ogham/exa
fi

if ! command -v delta &> /dev/null; then # `diff` alternative
    zinit ice from'gh-r' id-as as'program' bpick"*$(HOST_LIBC_PREFER_MUSL=1 host_triplet)*" mv'delta* release' atpull'%atclone' atclone'
        ln -svf $PWD/release/delta $ZPFX/bin
        wget https://raw.githubusercontent.com/dandavison/delta/master/etc/completion/completion.zsh -O _delta'
    zinit light dandavison/delta
fi

if ! command -v fd &> /dev/null; then # `find` alternative
    zinit ice from'gh-r' id-as as'program' bpick"*$(HOST_TRIPLET_APPLE_USE_INTEL=1 host_triplet)*" mv'fd* release' atclone'
        ln -svf $PWD/release/fd $ZPFX/bin
        ln -svf $PWD/release/fd.1 $ZPFX/man/man1'
    zinit light sharkdp/fd
fi

if ! command -v rg &> /dev/null; then # `grep` alternative
    zinit ice from'gh-r' id-as as'program' bpick"ripgrep-*" mv'ripgrep* release' atclone'
        ln -svf $PWD/release/rg $ZPFX/bin
        ln -svf $PWD/release/doc/rg.1 $ZPFX/man/man1'
    zinit light BurntSushi/ripgrep
fi

if ! command -v jq &> /dev/null; then
    zinit ice from'gh-r' id-as as'program' mv'jq* jq' atclone'
        ln -svf $PWD/jq $ZPFX/bin'
    zinit light jqlang/jq
fi

if ! command -v yq &> /dev/null; then
    zinit ice from'gh-r' id-as as'program' mv'yq* yq' atclone'
        ln -svf $PWD/yq $ZPFX/bin'
    zinit light mikefarah/yq
fi

if ! command -v fx &> /dev/null; then # json tui viewer
    zinit ice from'gh-r' id-as as'program' mv'**/fx* fx' atclone'
        ln -svf $PWD/fx $ZPFX/bin'
    zinit light antonmedv/fx
fi

if ! command -v hexyl &> /dev/null; then # `xxd` and `hexdump` alternative
    zinit ice from'gh-r' id-as as'program' bpick"*$(HOST_TRIPLET_APPLE_USE_INTEL=1 host_triplet)*" mv'hexyl* release' atclone'
        ln -svf $PWD/release/hexyl $ZPFX/bin
        ln -svf $PWD/release/hexyl.1 $ZPFX/man/man1'
    zinit light sharkdp/hexyl
fi

if ! command -v dust &> /dev/null; then # `du` alternative
    zinit ice from'gh-r' id-as as'program' bpick"*$(HOST_TRIPLET_APPLE_USE_INTEL=1 host_triplet)*" mv'dust* release' atclone'
        ln -svf $PWD/release/dust $ZPFX/bin'
    zinit light bootandy/dust
fi

if ! command -v procs &> /dev/null && [[ "$(uname -m)" = "x86_64" ]]; then # `ps` alternative
    zinit ice from'gh-r' id-as as'program' atclone'
        ln -svf $PWD/procs $ZPFX/bin'
    zinit light dalance/procs
fi

if ! command -v btm &> /dev/null; then # `top` alternative
    zinit ice from'gh-r' id-as as'program' bpick"*$(host_triplet)*" atclone'
        ln -svf $PWD/btm $ZPFX/bin
        ln -svf $PWD/completion/_btm _btm'
    zinit light ClementTsang/bottom
fi

if ! command -v vivid &> /dev/null; then
    zinit ice from'gh-r' id-as as'program' bpick"*$(HOST_TRIPLET_APPLE_USE_INTEL=1 host_triplet)*" mv'vivid*/vivid vivid' atclone'
        ln -svf $PWD/vivid $ZPFX/bin'
    zinit load sharkdp/vivid
fi

if ! command -v lazygit &> /dev/null; then # `git` tui
    zinit ice from'gh-r' id-as as'program' atpull'%atclone' atclone'
        ln -svf $PWD/lazygit $ZPFX/bin'
    zinit light jesseduffield/lazygit
fi

# Python programs
if command -v python &> /dev/null || command -v python3 &> /dev/null; then
    # Python venv manager
    zinit ice from'gh-r' id-as as'program' mv'uv* release' atclone'
        ln -svf $PWD/release/uv $ZPFX/bin'
    zinit light astral-sh/uv

    # Zinit wide venv at "$ZINIT_HOME/python"
    if ! [ -d "$ZINIT_HOME/python" ]; then
        uv venv "$ZINIT_HOME/python"
        zinit run uv ln -svf "$ZINIT_HOME/python" .venv
    fi

    if ! command -v sgpt &> /dev/null; then
        zinit ice id-as'sgpt' as'null' atclone'
            source "$ZINIT_HOME/python/bin/activate"
            uv pip install -e .
            ln -svf "$ZINIT_HOME/python/bin/sgpt" $ZPFX/bin'
        zinit light TheR1D/shell_gpt
    fi
fi

# Completions
zinit ice wait lucid as'completion' blockf
zinit light zsh-users/zsh-completions

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
    zinit ice wait lucid id-as as'completion' blockf
    zinit snippet "$ZSH_CACHE_DIR/completions/_$command"
}

if command -v docker &> /dev/null; then
    if ! zinit_snippet_completion_from_stdin docker 'docker completion zsh'; then
        zinit ice wait lucid id-as as'completion' blockf
        zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker
    fi
fi

if command -v docker-compose &> /dev/null; then
    zinit ice wait lucid id-as as'completion' blockf
    zinit snippet https://github.com/docker/compose/blob/1.29.2/contrib/completion/zsh/_docker-compose # Last version that has the completion script
fi

for command in kubectl helm kind; do
    command -v $command &> /dev/null && zinit_snippet_completion_from_stdin $command "$command completion zsh"
done
unset command

if command -v brew &> /dev/null; then
    zinit ice wait lucid id-as as'completion' blockf
    zinit snippet $(brew --prefix)/share/zsh/site-functions/_brew
fi

if command -v conda &> /dev/null; then
    zinit ice wait lucid id-as as'completion' blockf
    zinit light esc/conda-zsh-completion
fi

if command -v bazel &> /dev/null; then
    zinit ice wait lucid id-as as'completion' blockf
    zinit snippet https://github.com/bazelbuild/bazel/blob/master/scripts/zsh_completion/_bazel
fi

if [ -r "$HOME/.local/lib/kw/_kw" ]; then
    zinit ice wait lucid id-as as'completion' blockf
    zinit snippet "$HOME/.local/lib/kw/_kw"
fi

for completion in $SHELL_RC_HOME/vendors/completions/_*; do
    if [ -r "$completion" ] && command -v ${${completion:t}#_} &> /dev/null; then
        zinit ice wait lucid id-as as'completion' blockf
        zinit snippet "$completion"
    fi
done
unset completion

if command -v alacritty &> /dev/null; then # Terminal gui
    zinit ice wait lucid id-as as'completion' blockf atpull'%atclone' atclone'
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

# Plugins
zinit ice wait lucid id-as
zinit light zsh-users/zsh-history-substring-search

zinit ice wait lucid id-as
zinit light agkozak/zsh-z

zinit ice wait lucid id-as
zinit light reegnz/jq-zsh-plugin

zinit ice wait lucid id-as atpull'%atclone' atclone'ln -svf $PWD/bin/git-forgit $ZPFX/bin' atinit'export FORGIT_NO_ALIASES=1'
zinit light wfxr/forgit

zinit ice wait lucid id-as as'null' atpull'%atclone' atclone'make -C $PWD PREFIX=$ZPFX' atload'zi run tj/git-extras source etc/git-extras-completion.zsh'
zinit light tj/git-extras

zinit ice wait lucid id-as
zinit light paulirish/git-open

zinit ice wait lucid id-as as'null' atpull'%atclone' atclone'chmod +x $PWD/git-recall && ln -svf $PWD/git-recall $ZPFX/bin'
zinit light Fakerr/git-recall

# Put compinit after all completions plugin && before fzf-tab and syntax highlighting plugin
# fzf-tab needs to be loaded after compinit, but before plugins which will wrap widgets, such as zsh-autosuggestions or fast-syntax-highlighting
zinit ice wait lucid id-as atinit'zpcompinit; zpcdreplay'
zinit light Aloxaf/fzf-tab

zinit ice wait lucid id-as
zinit light zdharma/fast-syntax-highlighting

zinit ice wait lucid id-as atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

# Plugins using `compdef` need to run after `compinit`
zinit ice from'gh-r' wait lucid as'null' has'bat' atpull'%atclone' atclone'
    for sh in $PWD/bin/*; do ln -svf $sh $ZPFX/bin; done
    for sh in $PWD/man/*; do ln -svf $sh $ZPFX/man/man1; done' atload'
    compdef _man batman
    compdef _rg ripgrep batgrep
    compdef _delta batdiff'
zinit light eth-p/bat-extras
