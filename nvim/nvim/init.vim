" vim: set foldmethod=marker foldlevel=0 nomodeline:
scriptencoding utf-8

set termguicolors

lua require('_.plugins')

" ============================================================================
" SOURCE LOCAL SETTINGS {{{
" ============================================================================
if filereadable(expand('$XDG_CONFIG_HOME/nvim/local.vim'))
  exec 'source $XDG_CONFIG_HOME/nvim/local.vim'
endif

" }}}
