" vim: set foldmethod=marker foldlevel=0 nomodeline:

if exists('b:did_ftplugin_typescript_tsx')
  finish
endif

let b:did_ftplugin_typescript_tsx = 1 " Don't load twice in one buffer

setlocal formatexpr=CocAction('formatSelected')

" Source typescript ft config
source <sfile>:h/typescript.vim
