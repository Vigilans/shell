# Speical keys
Set-PSReadLineKeyHandler -Key UpArrow   -Function HistorySearchBackward   # Up key: walk history entries that start with the typed text
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward    # Down key
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key Tab       -Function MenuComplete            # Tab: completion menu instead of cycling through candidates
Set-PSReadLineKeyHandler -Key Shift+Tab -Function Undo                    # Shift + TAB: undo last action
