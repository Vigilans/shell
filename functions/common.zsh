function test_vivid() {
    zinit ice from"gh-r" as'program' mv'vivid*/vivid vivid'
    zinit load @sharkdp/vivid
    for theme in $(vivid themes); do
        echo "Theme: $theme"
        LS_COLORS=$(vivid generate $theme)
        ls
        echo
    done
    zinit unload sharkdp/vivid
}
