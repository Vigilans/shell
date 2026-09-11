#  ---------------------------------------------------------------------------
#  Environment and PATH helpers.
#  ---------------------------------------------------------------------------

# /proc/[pid]/environ
#       This file contains the environment for the process.  The entries
#       are separated by null bytes ('\0'), and there may be a null byte
#       at  the  end.
envcat() {
    xargs -0 -L1 -a $@
}

function path_append () {
    case ":$PATH:" in
        *:"$1":*)
            ;;
        *)
            PATH="${PATH:+$PATH:}$1"
    esac
}

function path_remove() {
    PATH="$(echo $PATH | sed -e "s;\(^\|:\)${1%/}\(:\|\$\);\1\2;g" -e 's;^:\|:$;;g' -e 's;::;:;g')"
}

function profile_reload() {
    unset _SHELL_PROFILE_LOCAL_LOADED _SHELL_PROFILE_SYSTEM_LOADED _SHELL_PROFILE_USER_LOADED
    . "$SHELL_CONFIG_HOME/profile.sh"
}
