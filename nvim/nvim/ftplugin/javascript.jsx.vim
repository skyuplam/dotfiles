" vim: set foldmethod=marker foldlevel=0 nomodeline:

if exists("b:did_ftplugin_javascript_jsx")
  finish
endif

let b:did_ftplugin_javascript_jsx = 1 " Don't load twice in one buffer

source <sfile>:h/javascript.vim

" }}}
