# Git for Windows' own prompt with a clock in front: time, user@host, MSYSTEM,
# working directory, git branch. __git_ps1 comes from Git's completion
# directory, which /etc/profile.d/git-prompt.sh loads for interactive shells.

PS1='\[\e]0;$MSYSTEM:$PWD\a\]\n'    # window title
PS1+=$blue'\A '
PS1+=$green'\u@\h '
PS1+=$purple'$MSYSTEM '
PS1+=$yellow'\w'
if [ "$(type -t __git_ps1)" = function ]; then
    # Backticks on purpose: Git for Windows' bash mis-parses `$(...)` in PS1
    # when the `\n` escape follows it.
    PS1+=$cyan'`__git_ps1`'
fi
PS1+=$normal'\n$ '
