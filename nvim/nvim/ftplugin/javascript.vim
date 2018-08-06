" setlocal omnifunc=javascriptcomplete#CompleteJS
" 
" let g:ale_fixers['javascript'] = ['prettier']
" let g:ale_javascript_prettier_options = '--single-quote --trailing-comma es5'
" 
" let g:javascript_plugin_jsdoc = 1
" let g:javascript_plugin_ngdoc = 1
" let g:javascript_plugin_flow = 1
" if executable('javascript-typescript-langserver')
"   let g:LanguageClient_serverCommands = {
"         \ 'javascript': ['javascript-typescript-langserver'],
"         \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
"         \ }
"   autocmd FileType javascript setlocal omnifunc=LanguageClient#complete
" endif
