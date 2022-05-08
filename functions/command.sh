
# Install a shell command into $HOME/.local/bin
# so it can be invoked from non-interactive shell
function command_install() {
    echo "not implemented"
}

# Uninstall a command from $HOME/.local/bin
function command_uninstall() {
    echo "not implemented"
}

#
# Get the value of an alias.
#
# Arguments:
#    1. alias - The alias to get its value from
# STDOUT:
#    The value of alias $1 (if it has one).
# Return value:
#    0 if the alias was found,
#    1 if it does not exist
#
function alias_source() {
    alias "$1" | sed "s/^$1='\(.*\)'$/\1/"
    test $(alias "$1")
}

function function_source() {
    declare -f $1
}

# Test whether a command exists
# $1 = cmd to test
function type_exists() {
    [ "$(type -P "$1")" ]
}
