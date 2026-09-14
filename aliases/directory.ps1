# Directories
if (Get-Command eza -ErrorAction SilentlyContinue) {
    $EZA_OPTIONS = "--group", "--color-scale", "--time-style=iso"
    $EZA_TABLE_OPTIONS = "--header", "--icons", "--classify", "--group-directories-first"
    $EZA_FULL_TABLE_OPTIONS = "--git", "--links", "--inode", "--extended", "--created", "--modified", "--changed", "--accessed"

    Remove-Alias ls -ErrorAction SilentlyContinue # Windows aliases ls to Get-ChildItem, and aliases win over functions
    function ls   { eza -h @args }
    function la   { eza -a @EZA_OPTIONS @args }
    function ll   { eza -l @EZA_OPTIONS @EZA_TABLE_OPTIONS @args }
    function lla  { eza -l -a @EZA_OPTIONS @EZA_TABLE_OPTIONS @args }
    function lll  { eza -l @EZA_OPTIONS @EZA_TABLE_OPTIONS @EZA_FULL_TABLE_OPTIONS @args }
    function llla { eza -l -a @EZA_OPTIONS @EZA_TABLE_OPTIONS @EZA_FULL_TABLE_OPTIONS @args }
    function lt   { eza --tree @EZA_OPTIONS @EZA_TABLE_OPTIONS @args }
    function lta  { eza --tree -a @EZA_OPTIONS @EZA_TABLE_OPTIONS @args }
}

# Dots
function ..    { Set-Location .. }
function ...   { Set-Location ../.. }
function ....  { Set-Location ../../.. }
function ..... { Set-Location ../../../.. }
