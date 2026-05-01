# Reload profile when the loaded profile revision is stale.
if [ -n "$SHELL_PROFILE_REV" ] && [ -r "$SHELL_CONFIG_HOME/.git" ]; then
    git_dir="$SHELL_CONFIG_HOME/.git"
    if [ -f "$git_dir" ]; then # submodule .git is a pointer file
        IFS= read -r git_dir_ref < "$git_dir"
        git_dir="$SHELL_CONFIG_HOME/${git_dir_ref#gitdir: }"
    fi

    IFS= read -r profile_rev < "$git_dir/HEAD"
    case "$profile_rev" in # branch HEAD stores a ref; detached HEAD stores an oid
        "ref: "*) IFS= read -r profile_rev < "$git_dir/${profile_rev#ref: }" ;;
    esac

    if [ "$profile_rev" != "$SHELL_PROFILE_REV" ]; then
        old_profile_tree=$(git -C "$SHELL_CONFIG_HOME" rev-parse "$SHELL_PROFILE_REV:profile.sh" "$SHELL_PROFILE_REV:profiles" 2>/dev/null)
        new_profile_tree=$(git -C "$SHELL_CONFIG_HOME" rev-parse "$profile_rev:profile.sh" "$profile_rev:profiles" 2>/dev/null)
        if [ "$old_profile_tree" != "$new_profile_tree" ]; then
            unset _SHELL_PROFILE_LOCAL_LOADED _SHELL_PROFILE_SYSTEM_LOADED _SHELL_PROFILE_USER_LOADED
            . "$SHELL_CONFIG_HOME/profile.sh"
        else
            export SHELL_PROFILE_REV=$profile_rev
        fi
    fi
    unset git_dir git_dir_ref profile_rev old_profile_tree new_profile_tree
fi
