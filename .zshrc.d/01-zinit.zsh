# Load zinit
export ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit"
source "$ZINIT_HOME/zinit.git/zinit.zsh" || return 0
[ -e "$ZPFX/bin" ] || mkdir -p "$ZPFX/bin"
[ -e "$ZPFX/man" ] || mkdir -p "$ZPFX/man"/man{1..9}
[ -e "$ZSH_CACHE_DIR/completions" ] || mkdir -p "$ZSH_CACHE_DIR/completions"
[[ ":$PATH:" != *":$ZPFX/bin:"* ]] && export PATH="$ZPFX/bin:$PATH"

###################
# Native Programs #
###################

# `fzf` fuzzy finder
zinit ice from'gh-r' id-as as'completion' atpull'%atclone' atclone'
    ln -svf $PWD/fzf $ZPFX/bin
    wget https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh -O key-bindings.zsh
    wget https://raw.githubusercontent.com/junegunn/fzf/master/man/man1/fzf.1 -O fzf.1
    wget https://raw.githubusercontent.com/junegunn/fzf/master/man/man1/fzf-tmux.1 -O fzf-tmux.1
    ln -svf $PWD/fzf.1 $ZPFX/man/man1
    ln -svf $PWD/fzf-tmux.1 $ZPFX/man/man1'
zinit light junegunn/fzf

# `cat` alternative
zinit ice from'gh-r' id-as as'completion' mv'bat* release' atpull'%atclone' atclone'
    ln -svf $PWD/release/bat $ZPFX/bin
    ln -svf $PWD/release/bat.1 $ZPFX/man/man1
    bat --completion zsh > _bat'
zinit light sharkdp/bat

# `ls` alternative
zinit ice from'gh-r' id-as as'completion' bpick'man-*' atpull'%atclone' atclone'
    VERSION=$(ls target | sed "s/man-//")
    if [[ "$(uname -s)" = "Darwin"* ]]; then
        typeset -A ICE=(ver eza-$VERSION)
        .zinit-get-latest-gh-r-url-part cargo-bins cargo-quickinstall
    else
        .zinit-get-latest-gh-r-url-part eza-community eza
    fi
    [ -n "$reply" ] && wget https://github.com/$reply -O eza.tar.gz && tar -xzf eza.tar.gz && rm -f eza.tar.gz && ln -svf $PWD/eza $ZPFX/bin
    wget https://raw.githubusercontent.com/eza-community/eza/main/completions/zsh/_eza -O _eza
    for man in $PWD/target/*/*.1; do ln -svf $man $ZPFX/man/man1; done
    for man in $PWD/target/*/*.5; do ln -svf $man $ZPFX/man/man5; done'
zinit light eza-community/eza

# `diff` alternative
zinit ice from'gh-r' id-as as'completion' bpick"*$(HOST_LIBC_PREFER_MUSL=1 host_triplet)*" mv'delta* release' atpull'%atclone' atclone'
    ln -svf $PWD/release/delta $ZPFX/bin
    delta --generate-completion zsh > _delta'
zinit light dandavison/delta

# `find` alternative
zinit ice from'gh-r' id-as as'completion' mv'fd* release' atpull'%atclone' atclone'
    ln -svf $PWD/release/fd $ZPFX/bin
    ln -svf $PWD/release/fd.1 $ZPFX/man/man1
    fd --gen-completions zsh > _fd'
zinit light sharkdp/fd

# `grep` alternative
zinit ice from'gh-r' id-as as'completion' bpick"ripgrep-*" mv'ripgrep* release' atpull'%atclone' atclone'
    ln -svf $PWD/release/rg $ZPFX/bin
    ln -svf $PWD/release/doc/rg.1 $ZPFX/man/man1
    rg --generate=complete-zsh > _rg'
zinit light BurntSushi/ripgrep

# Always use repository managed `jq` to ensure latest features
zinit ice from'gh-r' id-as as'null' mv'jq* jq' atpull'%atclone' atclone'
    ln -svf $PWD/jq $ZPFX/bin'
zinit light jqlang/jq

# `yq` yaml cli
zinit ice from'gh-r' id-as as'completion' mv'yq* yq' atpull'%atclone' atclone'
    ln -svf $PWD/yq $ZPFX/bin
    yq completion zsh > _yq'
zinit light mikefarah/yq

# `fx` json tui viewer
zinit ice from'gh-r' id-as as'completion' mv'fx* fx' atpull'%atclone' atclone'
    ln -svf $PWD/fx $ZPFX/bin
    fx --comp zsh > _fx'
zinit light antonmedv/fx

# `xxd` and `hexdump` alternative
zinit ice from'gh-r' id-as as'null' mv'hexyl* release' atpull'%atclone' atclone'
    ln -svf $PWD/release/hexyl $ZPFX/bin
    ln -svf $PWD/release/hexyl.1 $ZPFX/man/man1'
zinit light sharkdp/hexyl

# `du` alternative
zinit ice from'gh-r' id-as as'completion' bpick"*$(HOST_TRIPLET_APPLE_USE_INTEL=1 host_triplet)*" mv'dust* release' atpull'%atclone' atclone'
    ln -svf $PWD/release/dust $ZPFX/bin
    wget https://raw.githubusercontent.com/bootandy/dust/master/completions/_dust -O _dust'
zinit light bootandy/dust

# `ps` alternative
zinit ice from'gh-r' id-as as'completion' atpull'%atclone' atclone'
    ln -svf $PWD/procs $ZPFX/bin
    procs --gen-completion-out zsh > _procs'
zinit light dalance/procs

# `top` alternative
zinit ice from'gh-r' id-as as'completion' bpick"*$(host_triplet)*" atpull'%atclone' atclone'
    ln -svf $PWD/btm $ZPFX/bin
    ln -svf $PWD/completion/_btm _btm'
zinit light ClementTsang/bottom

# `vivid` colorizes output of commands
zinit ice from'gh-r' id-as as'null' bpick"*$(HOST_TRIPLET_APPLE_USE_INTEL=1 host_triplet)*" mv'vivid*/vivid vivid' atpull'%atclone' atclone'
    ln -svf $PWD/vivid $ZPFX/bin'
zinit load sharkdp/vivid

# `git` tui
zinit ice from'gh-r' id-as as'null' atpull'%atclone' atclone'
    ln -svf $PWD/lazygit $ZPFX/bin'
zinit light jesseduffield/lazygit

###################
# Python Programs #
###################

# Python venv manager
zinit ice from'gh-r' id-as as'completion' mv'uv* release' atpull'%atclone' atclone'
    ln -svf $PWD/release/uv $ZPFX/bin
    uv generate-shell-completion zsh > _uv'
zinit light astral-sh/uv

# Zinit wide venv at "$ZINIT_HOME/plugins/python"
# Use zinit managed python, to keep available across host machines and devcontainers
# Exported to the back of PATH, provided if any other python is not available
zinit ice id-as'python' as'null' atload'export PATH=$PATH:$(zi run python pwd)/bin' run-atpull'%atclone' atclone'rm -f *.md
    uv python install --reinstall 3.13
    uv venv --prompt zinit --python 3.13 --python-preference only-managed --seed --allow-existing $PWD'
zinit light zdharma-continuum/null

zinit ice id-as'sgpt' as'completion' atpull'%atclone' atclone'
    source "$ZINIT_HOME/plugins/python/bin/activate"
    uv pip install -e .
    wget https://gist.githubusercontent.com/obeone/dc66f2ca40b8254edab61ac50cdec0f3/raw/_sgpt.zsh -O _sgpt'
zinit light TheR1D/shell_gpt

zinit ice id-as'ansible' as'null' atpull'%atclone' atclone'
    source "$ZINIT_HOME/plugins/python/bin/activate"
    uv pip install ansible-core'
zinit light zdharma-continuum/null

###############
# Completions #
###############

zinit ice wait lucid id-as as'completion' blockf
zinit light zsh-users/zsh-completions

function zinit_snippet_completion_from_stdin() {
    local command=$1
    local completion_cmdline=$2
    zinit ice wait lucid id-as"_$command" as'completion' blockf atpull!'%atclone' atclone"
        $completion_cmdline > _$command"
    zinit snippet /dev/null
}

for command in kubectl helm kind; do
    command -v $command &> /dev/null && zinit_snippet_completion_from_stdin $command "$command completion zsh"
done
unset command

if command -v docker &> /dev/null; then
    zinit_snippet_completion_from_stdin docker 'docker completion zsh || curl -sSL https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker'
fi

if command -v docker-compose &> /dev/null; then
    zinit ice wait lucid id-as as'completion' blockf
    zinit snippet https://github.com/docker/compose/blob/1.29.2/contrib/completion/zsh/_docker-compose # Last version that has the completion script
fi

if command -v brew &> /dev/null; then
    zinit ice wait lucid id-as as'completion' blockf
    zinit snippet $(brew --prefix)/share/zsh/site-functions/_brew
fi

if command -v conda &> /dev/null; then
    zinit ice wait lucid id-as as'completion' blockf
    zinit light esc/conda-zsh-completion
fi

if command -v poetry &> /dev/null; then
    zinit_snippet_completion_from_stdin poetry "poetry completions zsh | head -n -1"
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
        wget https://github.com/alacritty/alacritty/releases/latest/download/alacritty.1.gz -O alacritty.1.gz
        wget https://github.com/alacritty/alacritty/releases/latest/download/alacritty-msg.1.gz -O alacritty-message.1.gz
        wget https://github.com/alacritty/alacritty/releases/latest/download/Alacritty.desktop -O Alacritty.desktop
        wget https://github.com/alacritty/alacritty/releases/latest/download/Alacritty.svg -O Alacritty.svg
        mkdir -p $HOME/.local/share/applications $HOME/.local/share/icons/hicolor/scalable/apps
        ln -svf $PWD/alacritty.1.gz $ZPFX/man/man1
        ln -svf $PWD/alacritty-message.1.gz $ZPFX/man/man1
        ln -svf $PWD/Alacritty.desktop $HOME/.local/share/applications
        ln -svf $PWD/Alacritty.svg $HOME/.local/share/icons/hicolor/scalable/apps'
    zinit snippet https://github.com/alacritty/alacritty/blob/master/extra/completions/_alacritty
fi

###########
# Plugins #
###########

zinit ice wait lucid id-as
zinit light zsh-users/zsh-history-substring-search

zinit ice wait lucid id-as
zinit light agkozak/zsh-z

zinit ice wait lucid id-as
zinit light reegnz/jq-zsh-plugin

zinit ice wait lucid id-as atpull'%atclone' atclone'ln -svf $PWD/bin/git-forgit $ZPFX/bin' atinit'export FORGIT_NO_ALIASES=1'
zinit light wfxr/forgit

zinit ice wait lucid id-as as'null' atpull'%atclone' atclone'make -C $PWD PREFIX=$ZPFX' atload'zi run git-extras source etc/git-extras-completion.zsh'
zinit light tj/git-extras

zinit ice wait lucid id-as as'null' atload'export PATH=$PATH:$(zi run git-open pwd)'
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
zinit ice from'gh-r' wait lucid id-as as'null' has'bat' atpull'%atclone' atclone'
    for sh in $PWD/bin/*; do ln -svf $sh $ZPFX/bin; done
    for sh in $PWD/man/*; do ln -svf $sh $ZPFX/man/man1; done' atload'
    compdef _man batman
    compdef _rg ripgrep batgrep
    compdef _delta batdiff'
zinit light eth-p/bat-extras
