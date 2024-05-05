#!/bin/bash

export SHELL_HOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"; cd "$SHELL_HOME"

# Setup necessary packages
if command -v pacman &> /dev/null; then
    sudo pacman --noconfirm -S wget git tar unzip inetutils
elif command -v apt-get &> /dev/null; then
    sudo apt-get -y update
    sudo apt-get -y install wget git tar unzip
elif command -v yum &> /dev/null; then
    sudo yum -y install wget git tar unzip
elif command -v apk &> /dev/null; then
    sudo apk add -q wget git tar unzip coreutils file zsh-vcs ncurses findutils
elif command -v brew &> /dev/null; then
    brew install wget coreutils # git tar unzip installed by xcode CLI tools
    export PATH="$(brew --prefix)/opt/coreutils/libexec/gnubin:$PATH"
else
    echo "Package manager not supported for now"
    exit 1
fi

# Setup ZI
[ ! -s ~/.config/zi ] && mkdir -p ~/.zi && git clone https://github.com/z-shell/zi.git ~/.zi/bin

# Setup Zsh ZI's loader
[ ! -s ~/.config/zi/init.zsh ] && mkdir -p ~/.config/zi && wget https://raw.githubusercontent.com/z-shell/zi-src/main/lib/zsh/init.zsh -O ~/.config/zi/init.zsh

# Setup Shell
mkdir -p ~/.config && ln -snf $(realpath --relative-to="$HOME/.config" "$SHELL_HOME")  "$HOME/.config/shell"
for dotfile in $(/bin/ls -A "$SHELL_HOME/dotfiles"); do
    ln -snf $(realpath --relative-to="$HOME" "$SHELL_HOME/dotfiles/$dotfile") "$HOME/$dotfile"
done
