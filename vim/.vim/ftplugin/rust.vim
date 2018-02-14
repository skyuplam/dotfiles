" Check Rust files with rls
let b:ale_linters = ['rls', 'cargo']
" Fix Python files with autopep8 and yapf.
let b:ale_fixers = ['rustfmt']

" LanguageServer-neovim
if executable('rls')
  let g:LanguageClient_serverCommands.rust = ['rls']
  setlocal omnifunc=LanguageClient#complete
endif
