# Shortcut env for user-dir folders
if command -v xdg-user-dir &> /dev/null; then
    export Downloads=$(xdg-user-dir DOWNLOAD)
    export Projects=$(xdg-user-dir PROJECTS)
    export Documents=$(xdg-user-dir DOCUMENTS)
    export Public=$(xdg-user-dir PUBLICSHARE)
    export Music=$(xdg-user-dir MUSIC)
    export Videos=$(xdg-user-dir VIDEOS)
    export Pictures=$(xdg-user-dir PICTURES)
fi
