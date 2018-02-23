setlocal omnifunc=javascriptcomplete#CompleteJS

let g:deoplete#omni#functions.javascript = ['tern#Complete', 'jspc#omni']

" if executable('javascript-typescript-stdio')
"   let g:LanguageClient_serverCommands = {
"         \'javascript': ['javascript-typescript-stdio'],
"         \'javascript.jsx': ['javascript-typescript-stdio'],
"         \}
"   setlocal omnifunc=LanguageClient#complete
" endif
