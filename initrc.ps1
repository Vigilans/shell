# initrc.ps1: setup script for interactive pwsh sessions.

# RC scripts location setup
$env:SHELL_RC_HOME = "$env:SHELL_CONFIG_HOME/.pwshrc.d"

# Interactive mode setup: the host loads PSReadLine only when it is about to read commands from the user
if ((Get-Module PSReadLine) -and (Test-Path $env:SHELL_RC_HOME)) {
    foreach ($rc in Get-ChildItem "$env:SHELL_RC_HOME/*.ps1" | Sort-Object Name) {
        . $rc.FullName
    }
    Remove-Variable rc
}
