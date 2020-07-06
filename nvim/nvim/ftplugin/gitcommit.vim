if exists("b:did_ftplugin_git")
  finish
endif

let b:did_ftplugin_git= 1 " Don't load twice in one buffer

" show the body width boundary
" Automatically wrap at 72 characters and spell check commit messages
setlocal textwidth=72
setlocal colorcolumn=73

" warning if first line too long
match ErrorMsg /\%1l.\%>51v/

" Autocompolete with dictoinary words when spell check is on
setlocal complete+=kspell
setlocal spell
setlocal spelllang=en_us
setlocal wrap
