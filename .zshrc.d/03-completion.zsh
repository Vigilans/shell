# Completion
zstyle ':completion:*:git-checkout:*' sort false                # disable sort when completing `git checkout`
zstyle ':completion:*:descriptions' format '[%d]'               # set descriptions format to enable group support
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # automatically find new executables in path
zstyle ':completion:*' accept-exact '*(N)'                      # Speed up completions
zstyle ':completion:*' use-cache on                             # Speed up completions
zstyle ':completion:*' cache-path ~/.zsh/cache                  # Speed up completions
