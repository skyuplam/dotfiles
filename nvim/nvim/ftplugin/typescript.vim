" vim: set foldmethod=marker foldlevel=0 nomodeline:

if exists('b:did_ftplugin_typescript')
  finish
endif

let b:did_ftplugin_typescript = 1 " Don't load twice in one buffer

setlocal formatexpr=CocAction('formatSelected')

" Set compiler to tsc
compiler tsc
