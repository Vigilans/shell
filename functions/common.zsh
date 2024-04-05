function test_vivid() {
    zi ice from"gh-r" as'program' mv'vivid*/vivid vivid'
    zi load @sharkdp/vivid
    for theme in $(vivid themes); do
        echo "Theme: $theme"
        LS_COLORS=$(vivid generate $theme)
        ls
        echo
    done
    zi unload sharkdp/vivid
}

function zi_snippet_completion_from_stdin() {
    local command=$1
    local completion
    read completion
    if [ -z "$completion" ]; then
        return 1
    fi
    if ! [ -d "$XDG_ZI_CACHE/completions" ]; then
        mkdir -p "$XDG_ZI_CACHE/completions"
    fi
    if ! [ -r "$XDG_ZI_CACHE/completions/_$command" ]; then
        echo "$completion" > "$XDG_ZI_CACHE/completions/_$command"
    fi
    zi ice wait lucid as'completion' blockf
    zi snippet "$XDG_ZI_CACHE/completions/_$command"
}
