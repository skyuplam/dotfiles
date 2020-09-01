" vim: set foldmethod=marker foldlevel=0 nomodeline:

if exists('b:did_ftplugin_typescript')
  finish
endif

let b:did_ftplugin_typescript = 1 " Don't load twice in one buffer

setlocal formatexpr=CocAction('formatSelected')

" ============================================================================
" ALE Fixing {{{
" ============================================================================

let b:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'typescript': ['prettier', 'eslint'],
      \ 'typescript.tsx': ['prettier', 'eslint'],
      \ 'typescriptreact': ['prettier', 'eslint'],
      \}

" }}}

" Set compiler to tsc
compiler tsc
