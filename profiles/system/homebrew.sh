if [ -r /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -r /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
elif command -v brew &> /dev/null; then
    eval "$(brew shellenv)"
fi

if [ -d "$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin" ]; then
    export PATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"
fi
