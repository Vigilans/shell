# ~/.zshrc: executed by zsh(1) for interactive shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

if command -v pacman &> /dev/null; then
    export SHELL_THEME="pure"  # Use pure theme for archlinux based distros
elif command -v dpkg &> /dev/null; then
    export SHELL_THEME="90210" # Use 90210 theme for debian based distros
else
    export SHELL_THEME="90210" # Use 90210 theme for any other distros
fi


# Load initrc scripts
if [ -f "$SHELL_CONFIG_HOME/initrc.sh" ]; then
	  . "$SHELL_CONFIG_HOME/initrc.sh"
else
    echo "Shell init script not found, environment not setup correctly."
fi
