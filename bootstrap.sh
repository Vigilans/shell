#!/bin/bash

export SHELL_HOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"; cd "$SHELL_HOME"

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
    echo "Package manager not supported for now"
    exit 1
fi

# Setup Zinit
ZINIT_HOME="${XDG_DATA_HOME:-"$HOME/.local/share"}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

# Setup Shell
mkdir -p ~/.config && ln -snf $(realpath --relative-to="$HOME/.config" "$SHELL_HOME")  "$HOME/.config/shell"
for dotfile in $(/bin/ls -A "$SHELL_HOME/dotfiles"); do
    ln -snf $(realpath --relative-to="$HOME" "$SHELL_HOME/dotfiles/$dotfile") "$HOME/$dotfile"
done
