if [ -d "$HOME/.cargo/bin" ]; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi

if [ -r "$HOME/.cargo/env" ]; then
    . $HOME/.cargo/env
fi
