# theme.ps1: setup script for shell themes.

if ($SHELL_THEME) {
    if (Test-Path "$env:SHELL_RC_HOME/themes/$SHELL_THEME.theme.ps1") {
        . "$env:SHELL_RC_HOME/themes/$SHELL_THEME.theme.ps1"
    } else {
        Write-Host "Theme $SHELL_THEME does not exist."
    }
}
