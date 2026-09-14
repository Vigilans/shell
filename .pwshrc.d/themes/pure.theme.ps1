# Pure prompt <https://github.com/sindresorhus/pure> rebuilt in PowerShell, composed like the zsh
# theme: [time]-[user@host]-[path]-[branch git_extras]-(exec_time) over a ❯ colored by the last exit
# status, with a failing exit code on the right of the input line.

$prompt_pure_colors = @{
    execution_time = "`e[36m"
    user           = "`e[38;5;78m"
    user_root      = "`e[31m"
    host           = "`e[38;5;78m"
    path           = "`e[34m"
    git_branch     = "`e[38;5;214m"
    git_dirty      = "`e[38;5;242m"
    git_arrow      = "`e[36m"
    git_stash      = "`e[36m"
    prompt_success = "`e[38;5;36m"
    prompt_error   = "`e[31m"
    virtualenv     = "`e[38;5;242m"
    continuation   = "`e[38;5;242m"
}

# If FQDN has a real domain (not local/localdomain), show hostname as full FQDN
$SHELL_DOMAIN_NAME = if ($IsWindows) { $env:USERDNSDOMAIN } else { (hostname -f) -replace '^[^.]*\.?' } # Windows sets USERDNSDOMAIN on domain-joined machines
if ($SHELL_DOMAIN_NAME -in 'local', 'localdomain') { $SHELL_DOMAIN_NAME = $null }

# Show user@host over SSH and as root, whose name is red; Windows' root is SYSTEM, elevation alone is not
$prompt_pure_root = if ($IsWindows) { [Security.Principal.WindowsIdentity]::GetCurrent().IsSystem } else { (id -u) -eq 0 }
$prompt_pure_user_host = $null
if ($env:SSH_CONNECTION -or $prompt_pure_root) {
    $user_color = $prompt_pure_colors[$(if ($prompt_pure_root) { 'user_root' } else { 'user' })]
    $machine = [Environment]::MachineName
    if ($SHELL_DOMAIN_NAME) { $machine += ".$SHELL_DOMAIN_NAME" }
    $prompt_pure_user_host = "$user_color$([Environment]::UserName)$($prompt_pure_colors.host)@$machine`e[39m"
    Remove-Variable user_color, machine
}

# Git branch, dirty mark, up/down arrows and stash mark, from a single git call
function prompt_pure_git_info {
    # Look for the repository ourselves, so directories outside one cost no git call
    $dir = if ($PWD.Provider.Name -eq 'FileSystem') { $PWD.ProviderPath }
    while ($dir -and -not (Test-Path "$dir/.git")) { $dir = Split-Path $dir }
    if (-not $dir) { return }

    $git = @{}
    foreach ($line in git status --porcelain=v2 --branch --show-stash -uno --ignore-submodules 2>$null) {
        switch -Regex ($line) {
            '^# branch\.oid (.{7})'        { $git.oid = $Matches[1] }
            '^# branch\.head (.*)'         { $git.branch = $Matches[1] }
            '^# branch\.ab \+(\d+) -(\d+)' { $git.ahead = [int]$Matches[1]; $git.behind = [int]$Matches[2] }
            '^# stash'                     { $git.stash = $true }
            '^[^#]'                        { $git.dirty = $true }
        }
    }
    if (-not $git.branch) { return }

    $c = $prompt_pure_colors
    $info = "$($c.git_branch)$(if ($git.branch -eq '(detached)') { $git.oid } else { $git.branch })"
    if ($git.dirty) { $info += "$($c.git_dirty)*" }
    $arrows = "$(if ($git.behind) { '⇣' })$(if ($git.ahead) { '⇡' })"
    if ($arrows) { $info += " $($c.git_arrow)$arrows" }
    if ($git.stash) { $info += " $($c.git_stash)≡" }
    "$info`e[39m"
}

# 1d 2h 3m 4s, dropping the leading zero units
function prompt_pure_human_time([timespan]$span) {
    $parts = @()
    if ($span.Days) { $parts += "$($span.Days)d" }
    if ($span.Hours) { $parts += "$($span.Hours)h" }
    if ($span.Minutes) { $parts += "$($span.Minutes)m" }
    $parts += "$($span.Seconds)s"
    $parts -join ' '
}

function prompt {
    $success = $?; $exitcode = $global:LASTEXITCODE # Read before anything below overwrites them
    $c = $prompt_pure_colors

    # An empty line runs nothing and leaves $? as is; like zsh, treat it as a fresh success
    $last = Get-History -Count 1
    $ran = $last -and $last.Id -ne $global:prompt_pure_last_history_id
    if ($ran) { $global:prompt_pure_last_history_id = $last.Id } else { $success = $true }

    $path = $PWD.Path # Not folded into ~, so the drive letter tells this prompt from the zsh one
    $Host.UI.RawUI.WindowTitle = $path

    # Preprompt: [time]-[user@host?]-[path]-[branch git_extras?]-(exec_time)?
    $parts = @("[$($c.execution_time)$(Get-Date -Format HH:mm:ss)`e[39m]")
    if ($prompt_pure_user_host) { $parts += "[$prompt_pure_user_host]" }
    $parts += "[$($c.path)$path`e[39m]"
    if ($git = prompt_pure_git_info) { $parts += "[$git]" }
    if ($ran) { # Execution time of the command that just finished, when it took at least 5 seconds
        $elapsed = $last.EndExecutionTime - $last.StartExecutionTime
        if ($elapsed.TotalSeconds -ge 5) { $parts += "($($c.execution_time)$(prompt_pure_human_time $elapsed)`e[39m)" }
    }

    # Prompt: venv? ❯ with a failing exit code drawn at the right edge first, which long input overwrites
    $rprompt = ''
    if (-not $success -and $exitcode) {
        $code = "[$exitcode]"
        $rprompt = "`e[$($Host.UI.RawUI.WindowSize.Width - $code.Length)G$($c.prompt_error)$code`e[39m`r"
    }
    $venv = if ($env:VIRTUAL_ENV_PROMPT) { $env:VIRTUAL_ENV_PROMPT -replace '[()]' } # Most activate scripts write "(name) "
        elseif ($env:CONDA_DEFAULT_ENV) { $env:CONDA_DEFAULT_ENV }
        elseif ($env:VIRTUAL_ENV) { Split-Path $env:VIRTUAL_ENV -Leaf }
    if ($venv) { $venv = "$($c.virtualenv)$($venv.Trim())`e[39m " }
    $symbol = if ($success) { $c.prompt_success } else { $c.prompt_error }

    $global:LASTEXITCODE = $exitcode
    "`e[0m$($parts -join '-')`n$rprompt$venv$symbol❯ `e[0m" # Reset at both ends: zsh does, PowerShell leaves the last color on for whatever prints next
}
$env:VIRTUAL_ENV_DISABLE_PROMPT = 1 # Keep activate scripts from wrapping the prompt; the venv is drawn above

# Parse errors turn the symbol red while typing; continuation lines mirror pure's PROMPT2
Set-PSReadLineOption -PromptText "$($prompt_pure_colors.prompt_success)❯ ", "$($prompt_pure_colors.prompt_error)❯ "
Set-PSReadLineOption -ContinuationPrompt '… ❯ ' -Colors @{ ContinuationPrompt = $prompt_pure_colors.continuation }

# Setup LS_COLORS
if (Get-Command vivid -ErrorAction SilentlyContinue) {
    $env:LS_COLORS = vivid generate one-dark
}
