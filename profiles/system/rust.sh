if [ -n "$CARGO_HOME" ]; then
    if [ -d "$CARGO_HOME/bin" ]; then
        export PATH="$CARGO_HOME/bin:$PATH"
    fi

    if [ -r "$CARGO_HOME/env" ]; then
        . $CARGO_HOME/env
    fi
fi
