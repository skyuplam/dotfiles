setlocal omnifunc=javascriptcomplete#CompleteJS

if executable('javascript-typescript-stdio')
  let g:LanguageClient_serverCommands.javascript = ['javascript-typescript-stdio']
  setlocal omnifunc=LanguageClient#complete
endif
