zi ice as"command" from"gh-r" \
  atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
  atpull"%atclone" src"init.zsh"
zi light starship/starship

zi ice from"gh-r" as'program' bpick"*$(host_triplet)*" mv'vivid*/vivid vivid'
zi load @sharkdp/vivid
export LS_COLORS="$(vivid generate one-dark)"
zi unload -q sharkdp/vivid
