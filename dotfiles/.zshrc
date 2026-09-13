# ~/.zshrc: executed by zsh(1) for interactive shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) [ -n "$_INITRC_SH_FORCE_LOAD" ] || return;;
esac

# Determine default theme according to systemd distro
if [ -z "$SHELL_THEME" ]; then
    if command -v pacman &> /dev/null; then
        SHELL_THEME="pure"  # Use pure theme for archlinux based distros
    elif command -v brew &> /dev/null; then
        SHELL_THEME="pure"  # Use pure theme for macos
    elif command -v dpkg &> /dev/null; then
        SHELL_THEME="90210" # Use 90210 theme for debian based distros
    else
        SHELL_THEME="90210" # Use 90210 theme for any other distros
    fi
fi

# Load initrc scripts
if [ -f "$SHELL_CONFIG_HOME/initrc.sh" ]; then
	  . "$SHELL_CONFIG_HOME/initrc.sh"
else
    echo "Shell init script not found, environment not setup correctly."
fi
