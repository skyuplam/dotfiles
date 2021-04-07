" vim: set foldmethod=marker foldlevel=0 nomodeline:
scriptencoding utf-8

set termguicolors

" ============================================================================
" SKIP VIM PLUGINS {{{
" ============================================================================
" Skip loading menu.vim, saves ~100ms
let g:did_install_default_menus = 1
let g:loaded_getscript          = 1
let g:loaded_getscriptPlugin    = 1
let g:loaded_vimball            = 1
let g:loaded_vimballPlugin      = 1
let g:loaded_rrhelper           = 1
" }}}
" ============================================================================
" PROVIDERS {{{
" ============================================================================
" Set them directly if they are installed, otherwise disable them. To avoid the
" runtime check cost, which can be slow.
if has('nvim')
  " Python This must be here becasue it makes loading vim VERY SLOW otherwise
  let g:python_host_skip_check = 1
  " Disable python2 provider
  let g:loaded_python_provider = 0

  let g:python3_host_skip_check = 1
  if executable('python3')
    let g:python3_host_prog = exepath('python3')
  else
    let g:loaded_python3_provider = 0
  endif

  if executable('neovim-node-host')
    let g:node_host_prog = exepath('neovim-node-host')
  else
    let g:loaded_node_provider = 0
  endif

  if executable('neovim-ruby-host')
    let g:ruby_host_prog = exepath('neovim-ruby-host')
  else
    let g:loaded_ruby_provider = 0
  endif

  let g:loaded_perl_provider = 0
endif
" }}}
" ============================================================================
" LOAD PLUGINS {{{
" ============================================================================
lua require('_.plugins')

" }}}
" ============================================================================
" SOURCE LOCAL SETTINGS {{{
" ============================================================================
if filereadable(expand('$XDG_CONFIG_HOME/nvim/local.vim'))
  exec 'source $XDG_CONFIG_HOME/nvim/local.vim'
endif

" }}}
