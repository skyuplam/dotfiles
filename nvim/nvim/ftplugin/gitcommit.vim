if exists("b:did_ftplugin")
  finish
endif

let b:did_ftplugin = 1 " Don't load twice in one buffer

setlocal spell
" Automatically wrap at 72 characters and spell check commit messages
setlocal textwidth=72

" Autocompolete with dictoinary words when spell check is on
setlocal complete+=kspell
setlocal wrap
