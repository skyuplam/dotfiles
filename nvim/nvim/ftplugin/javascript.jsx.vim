" vim: set foldmethod=marker foldlevel=0 nomodeline:

" ============================================================================
" Language Client Config {{{
" ============================================================================
" setlocal omnifunc=javascriptcomplete#CompleteJS

" let g:ale_fixers['javascript.jsx'] = ['prettier']
" let g:ale_javascript_prettier_options = '--single-quote --trailing-comma es5'

" let g:javascript_plugin_jsdoc = 1
" let g:javascript_plugin_ngdoc = 1
" let g:javascript_plugin_flow = 1

" let g:LanguageClient_serverCommands['javascript'] = ['javascript-typescript-stdio']
let g:LanguageClient_serverCommands = {
      \ 'javascript': ['javascript-typescript-stdio'],
      \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
      \}
autocmd FileType javascript setlocal omnifunc=LanguageClient#complete
autocmd FileType javascript.jsx setlocal omnifunc=LanguageClient#complete

" }}}
