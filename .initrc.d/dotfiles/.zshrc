# ~/.zshrc: executed by zsh(1) for interactive shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Load initrc scripts
if [ -f "$SHELL_CONFIG_HOME/initrc.sh" ]; then
	  . "$SHELL_CONFIG_HOME/initrc.sh"
else
    echo "Shell init script not found, environment not setup correctly."
fi
