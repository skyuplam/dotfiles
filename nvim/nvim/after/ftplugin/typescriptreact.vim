" vim: set foldmethod=marker foldlevel=0 nomodeline:

if exists("b:did_after_ftplugin_typescriptreact")
  finish
endif

let b:did_after_ftplugin_typescriptreact = 1 " Don't load twice in one buffer


source <sfile>:h/typescript.vim
