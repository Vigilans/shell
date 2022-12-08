if [ -z "$RUSTUP_HOME" ]; then
    export RUSTUP_HOME="$HOME/.rustup"
fi

if [ -z "$CARGO_HOME" ]; then
    export CARGO_HOME="$HOME/.cargo"
fi

if [ -d "$CARGO_HOME/bin" ]; then
    export PATH="$CARGO_HOME/bin:$PATH"
fi

if [ -r "$CARGO_HOME/env" ]; then
    . $CARGO_HOME/env
fi
