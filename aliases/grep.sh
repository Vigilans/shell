# Vendored from oh-my-bash <https://github.com/ohmybash/oh-my-bash>
# (lib/grep.sh), which carries it over from Bash-it
# <https://github.com/Bash-it/bash-it>. MIT License, see LICENSE for the text:
#   Copyright (c) 2009-2017 Robby Russell and contributors
#   Copyright (c) 2017-2020 Toan Nguyen and contributors
#   Copyright (c) 2020-2021 Bash-it
#
# Sets the default grep options.

# is x grep argument available?
grep_flag_available() {
    echo | grep $1 "" >/dev/null 2>&1
}

GREP_OPTIONS=""

# color grep results
if grep_flag_available --color=auto; then
    GREP_OPTIONS+=( " --color=auto" )
fi

# ignore VCS folders (if the necessary grep flags are available)
VCS_FOLDERS="{.bzr,CVS,.git,.hg,.svn}"

if grep_flag_available --exclude-dir=.cvs; then
    GREP_OPTIONS+=( " --exclude-dir=$VCS_FOLDERS" )
elif grep_flag_available --exclude=.cvs; then
    GREP_OPTIONS+=( " --exclude=$VCS_FOLDERS" )
fi

# export grep settings
alias grep="grep $GREP_OPTIONS"

# clean up
unset GREP_OPTIONS
unset VCS_FOLDERS
unset -f grep_flag_available
