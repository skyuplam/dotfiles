" vim: set foldmethod=marker foldlevel=0 nomodeline:

if exists("b:did_ftplugin_markdown")
  finish
endif

let b:did_ftplugin_markdown = 1 " Don't load twice in one buffer

setlocal textwidth=0
setlocal suffixesadd+=.md
setlocal spell
setlocal spelllang=en_us
setlocal tabstop=2
setlocal shiftwidth=2

setlocal formatexpr=CocAction('formatSelected')
