if [ -d "${XDG_DATA_HOME:-${HOME}/.local/share}/zinit" ]; then
    export PATH="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/polaris/bin:$PATH"
fi
