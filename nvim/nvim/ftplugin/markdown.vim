" vim: set foldmethod=marker foldlevel=0 nomodeline:

if exists("b:did_ftplugin_markdown")
  finish
endif

let b:did_ftplugin_markdown = 1 " Don't load twice in one buffer

setlocal textwidth=0
setlocal suffixesadd+=.md
