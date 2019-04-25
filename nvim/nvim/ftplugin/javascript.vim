" vim: set foldmethod=marker foldlevel=0 nomodeline:

if exists("b:did_ftplugin_javascript")
  finish
endif

let b:did_ftplugin_javascript = 1 " Don't load twice in one buffer

" ============================================================================
" ALE Fixing {{{
" ============================================================================

let b:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'javascript': ['prettier', 'eslint'],
      \ 'javascript.jsx': ['prettier', 'eslint'],
      \}

" }}}
