# Programs that zinit installed for zsh
$ZINIT_HOME = "$(if ($env:XDG_DATA_HOME) { $env:XDG_DATA_HOME } else { "$HOME/.local/share" })/zinit"
if (Test-Path $ZINIT_HOME) {
    $env:PATH = "$ZINIT_HOME/polaris/bin$([IO.Path]::PathSeparator)$env:PATH"
}
