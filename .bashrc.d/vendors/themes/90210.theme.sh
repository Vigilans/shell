#!/usr/bin/env bash
# Vendored from oh-my-bash <https://github.com/ohmybash/oh-my-bash>
# (themes/90210/90210.theme.sh), which carries it over from Bash-it
# <https://github.com/Bash-it/bash-it>. MIT License, see LICENSE for the text:
#   Copyright (c) 2009-2017 Robby Russell and contributors
#   Copyright (c) 2017-2020 Toan Nguyen and contributors
#   Copyright (c) 2020-2021 Bash-it

SCM_THEME_PROMPT_DIRTY=" ${red}✗"
SCM_THEME_PROMPT_CLEAN=" ${bold_green}✓"
SCM_THEME_PROMPT_PREFIX=" |"
SCM_THEME_PROMPT_SUFFIX="${green}|"

GIT_THEME_PROMPT_DIRTY=" ${red}✗"
GIT_THEME_PROMPT_CLEAN=" ${bold_green}✓"
GIT_THEME_PROMPT_PREFIX=" ${green}|"
GIT_THEME_PROMPT_SUFFIX="${green}|"

# Nicely formatted terminal prompt
function prompt_command(){
  export PS1="${bold_black}[${blue}\@${bold_black}]-${bold_black}[${green}\u${yellow}@${green}\h${bold_black}]-${bold_black}[${purple}\w${bold_black}]-\n${reset_color}\$ "
}

safe_append_prompt_command prompt_command
