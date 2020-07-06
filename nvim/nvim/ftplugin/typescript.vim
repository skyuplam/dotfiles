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
      \}

" }}}

" ============================================================================
" TSC compiler {{{
" ============================================================================

let g:typescript_compiler_binary = 'yarn -s tsc'
" Project-wise compilation
let g:typescript_compiler_options = '-p tsconfig.json --noEmit'

" }}}
