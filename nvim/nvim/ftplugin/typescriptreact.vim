" vim: set foldmethod=marker foldlevel=0 nomodeline:

if exists("b:did_ftplugin_typescriptreact")
  finish
endif

let b:did_ftplugin_typescriptreact = 1 " Don't load twice in one buffer

" ============================================================================
" ALE Fixing {{{
" ============================================================================

let b:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'typescript': ['prettier', 'eslint'],
      \ 'typescript.tsx': ['prettier', 'eslint'],
      \}

" }}}

" ============================================================================
" TSC compiler {{{
" ============================================================================

source <sfile>:h/typescript.vim

" }}}
