" Enable spellchecking
setlocal spell
setlocal omnifunc=htmlcomplete#CompleteTags

" Automatically wrap at 80 characters
setlocal textwidth=80

" nnoremap <leader>= :s/.*/\=repeat("=", len(getline(line(".") - 1)))/<cr> <bar> :noh<cr>
" nnoremap <leader>- :s/.*/\=repeat("-", len(getline(line(".") - 1)))/<cr> <bar> :noh<cr>
" 
" autocmd insertleave,textchanged <buffer> call MarkdownUpdateHeadingUnderline()
" 
" function! MarkdownUpdateHeadingUnderline() abort
"     let lnum = line(".")
" 
"     if getline(lnum) =~ '^\s*-'
"         return
"     endif
" 
"     if getline(lnum+1) =~ '^-\+$'
"         call setline(lnum+1, repeat("-", len(getline(lnum))))
"     elseif getline(lnum+1) =~ '^=\+$'
"         call setline(lnum+1, repeat("=", len(getline(lnum))))
"     endif
" endfunction
" 
" 
" nnoremap <silent> <buffer> <esc> :call <SID>CheckToRealignTable()<cr>
" inoremap <silent> <buffer> <esc> <esc>:call <SID>CheckToRealignTable()<cr>
" function! s:CheckToRealignTable() abort
"     if getline(line(".")) =~ '^|.*|.*|'
"         TableModeRealign
"     endif
" endfunction
