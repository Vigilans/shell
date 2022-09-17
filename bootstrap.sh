#!/bin/bash

export SHELL_HOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"; cd "$SHELL_HOME"

# Setup necessary packages
if command -v pacman &> /dev/null; then
    sudo pacman -S wget git tar unzip
elif command -v apt-get &> /dev/null; then
    sudo apt-get update
    sudo apt-get install wget git tar unzip
else
    echo "Package manager not supported for now"
    return 1
fi

# Setup ZI
mkdir -p ~/.zi && git clone git@github.com:z-shell/zi.git ~/.zi/bin

# Setup Zsh ZI's loader
mkdir -p ~/.config/zi && wget https://raw.githubusercontent.com/z-shell/zi-src/main/lib/zsh/init.zsh -O ~/.config/zi/init.zsh

# Setup Shell
mkdir -p ~/.config && ln -snf "$SHELL_HOME" ~/.config/shell
for dotfile in $(/bin/ls -A "$SHELL_HOME/.initrc.d/dotfiles"); do
    ln -snf "$SHELL_HOME/.initrc.d/dotfiles/$dotfile" ~/$dotfile
done
