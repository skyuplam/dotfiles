" coc extensions
let g:coc_global_extensions = [
  \ 'coc-dictionary', 'coc-word', 'coc-actions',
  \ 'coc-lists', 'coc-tag', 'coc-syntax', 'coc-highlight',
  \ 'coc-tsserver', 'coc-jest', 'coc-eslint',
  \ 'coc-svg', 'coc-html',
  \ 'coc-css', 'coc-stylelint', 'coc-cssmodules',
  \ 'coc-json',
  \ 'coc-yaml',
  \ 'coc-prettier',
  \ 'coc-rust-analyzer',
  \ 'coc-git',
  \ 'coc-markdownlint', 'coc-spell-checker',
  \ 'coc-vimlsp',
  \]

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')
" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

augroup cocAUG
  autocmd!
  autocmd User CocStatusChange,CocGitStatusChange call local#statusline#RefreshStatusline()
  autocmd User CocDiagnosticChange call local#statusline#RefreshStatusline()
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

  " Highlight symbol under cursor on CursorHold
  autocmd CursorHold * silent call CocActionAsync('highlight')
  autocmd CursorHold * silent call CocActionAsync('getCurrentFunctionSymbol')
augroup end

" Show documentation
function s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nnoremap <Plug>(show-doc) :<C-U>call <SID>show_documentation()<CR>
