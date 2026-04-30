#!/bin/bash
# Bootstrap the shell config. Phases are callable individually so the dotfiles
# framework can drive them in its own lifecycle. `bash bootstrap.sh` with no
# args runs the full standalone bootstrap (the original behavior).
#
#   prepare      install OS packages + clone zinit (when $SHELL is zsh)
#   install      copy entry dotfiles into $HOME + warm zinit (zsh users)
#   upgrade      zinit self-update + plugin update (zsh users)
#   bootstrap    prepare + ~/.config/shell symlink + install (standalone path)

set -eu

export SHELL_HOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"; cd "$SHELL_HOME"

prepare() {
    # Setup necessary packages
    if command -v pacman &> /dev/null; then
        sudo pacman --noconfirm -S wget git tar unzip make less inetutils util-linux file
    elif command -v apt-get &> /dev/null; then
        sudo apt-get -y update
        sudo apt-get -y install wget git tar unzip make less bsdmainutils file
    elif command -v yum &> /dev/null; then
        sudo yum -y install wget git tar unzip make less util-linux file
    elif command -v apk &> /dev/null; then
        sudo apk add -q wget git tar unzip make less coreutils file zsh-vcs ncurses findutils util-linux
    elif command -v brew &> /dev/null; then
        brew install wget coreutils util-linux # git tar unzip installed by xcode CLI tools
        export PATH="$(brew --prefix)/opt/coreutils/libexec/gnubin:$PATH"
    else
        echo "[shell] package manager not supported" >&2
        return 1
    fi

    # Setup Zinit
    if [ "$(basename "$SHELL")" = "zsh" ]; then
        local ZINIT_HOME="${XDG_DATA_HOME:-"$HOME/.local/share"}/zinit/zinit.git"
        [ -d "$ZINIT_HOME" ] || mkdir -p "$(dirname "$ZINIT_HOME")"
        [ -d "$ZINIT_HOME/.git" ] || git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
    fi
}

# Copy entry dotfiles into $HOME instead of symlinking, so lines installers like
# LM Studio append (`. ".../env"`, `export PATH=...`) land in the $HOME copy and
# don't bleed back into source control. Skip when the existing $HOME file
# differs from source — preserves both user edits and installer pollution.
# Pass --force to overwrite anyway.
install() {
    local force=0
    [ "${1:-}" = "--force" ] && force=1

    local src dst
    shopt -s dotglob nullglob
    for src in "$SHELL_HOME/dotfiles"/*; do
        [ -f "$src" ] || continue
        dst="$HOME/$(basename "$src")"
        if [ -L "$dst" ]; then
            # Old install left a symlink — replace with a real copy so future
            # installer writes go to $HOME, not back through the link to source.
            rm -f "$dst"
        elif [ -e "$dst" ]; then
            cmp -s "$src" "$dst" && continue
            if [ "$force" = 0 ]; then
                echo "[shell] skip $dst (differs from source — use --force to overwrite)"
                continue
            fi
        fi
        cp "$src" "$dst"
    done
    shopt -u dotglob nullglob

    # Warm zinit so gh-r binaries download here instead of on the user's
    # first interactive prompt. `@zinit-scheduler burst` flushes the wait queue.
    if [ "$(basename "$SHELL")" = "zsh" ]; then
        TERM="${TERM:-dumb}" zsh -ic '@zinit-scheduler burst'
    fi
}

upgrade() {
    if [ "$(basename "$SHELL")" = "zsh" ]; then
        TERM="${TERM:-dumb}" zsh -ic 'zi self-update && zi update'
    fi
}

bootstrap() {
    prepare
    mkdir -p "$HOME/.config"
    ln -snf "$(realpath --relative-to="$HOME/.config" "$SHELL_HOME")" "$HOME/.config/shell"
    install "$@"
}

if [ "$0" = "$BASH_SOURCE" ]; then
    if [ "$#" -eq 0 ]; then
        bootstrap
    else
        "$@"
    fi
fi
