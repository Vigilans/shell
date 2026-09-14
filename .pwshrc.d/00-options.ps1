# History
Set-PSReadLineOption -MaximumHistoryCount 100000
Set-PSReadLineOption -HistoryNoDuplicates                       # If a new command is a duplicate, recall only the newest one
Set-PSReadLineOption -HistorySaveStyle SaveIncrementally        # Save commands to the history file immediately, otherwise only when shell exits
Set-PSReadLineOption -AddToHistoryHandler {                     # Don't save commands that start with space
    param($line)
    if ($line -match '^\s') { return 'SkipAdding' }
    [Microsoft.PowerShell.PSConsoleReadLine]::GetDefaultAddToHistoryOption($line) # Keep the built-in filter that hides secrets
}

# Suggestions
Set-PSReadLineOption -PredictionSource History                  # Inline suggestion from history, accepted with Right key (zsh-autosuggestions)

# Miscellaneous
Set-PSReadLineOption -BellStyle None                            # No beep
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8        # Windows consoles default to the OEM code page, which cannot draw the prompt symbols
