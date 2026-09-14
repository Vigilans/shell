# $PROFILE.CurrentUserAllHosts: executed by pwsh(1) for every host, that is
# ~/Documents/PowerShell/profile.ps1 on Windows and ~/.config/powershell/profile.ps1 elsewhere.

# Set shell config home varibale
if (-not $env:XDG_CONFIG_HOME) {
    $env:XDG_CONFIG_HOME = "$HOME/.config"
}
$env:SHELL_CONFIG_HOME = "$env:XDG_CONFIG_HOME/shell"

# Determine default theme
$SHELL_THEME = if ($env:SHELL_THEME) { $env:SHELL_THEME } else { "pure" }

# Load initrc scripts
if (Test-Path "$env:SHELL_CONFIG_HOME/initrc.ps1") {
    . "$env:SHELL_CONFIG_HOME/initrc.ps1"
} else {
    Write-Host "Shell init script not found, environment not setup correctly."
}
