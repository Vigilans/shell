# Replace some commands with bat-extras version
if command -v batman &> /dev/null; then
    alias man="batman"
fi
if command -v batgrep &> /dev/null; then
    alias ripgrep="command rg"
fi
if command -v batdiff &> /dev/null && command -v delta &> /dev/null; then
    alias batdiff="batdiff --delta"
fi
