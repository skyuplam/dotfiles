setlocal iskeyword+=-
setlocal omnifunc=csscomplete#CompleteCSS
set expandtab

let g:ale_fixers['css'] = ['prettier']
let g:ale_linters['css'] = ['stylelint']
