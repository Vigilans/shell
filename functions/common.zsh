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
