# alias.ps1: setup scripts for shell aliases.

# Load shell aliases
if (Test-Path "$env:SHELL_CONFIG_HOME/aliases") {
    foreach ($alias in Get-ChildItem "$env:SHELL_CONFIG_HOME/aliases/*.ps1") {
        . $alias.FullName
    }
    Remove-Variable alias
}
