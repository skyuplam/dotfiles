" vim: set foldmethod=marker foldlevel=0 nomodeline:

if exists("b:did_after_ftplugin_typescript")
  finish
endif

let b:did_after_ftplugin_typescript = 1 " Don't load twice in one buffer

" Set compiler to tsc
compiler tsc
