" vim: set foldmethod=marker foldlevel=0 nomodeline:

if exists('b:did_ftplugin_json')
  finish
endif

let b:did_ftplugin_json = 1 " Don't load twice in one buffer

setlocal formatexpr=CocAction('formatSelected')
