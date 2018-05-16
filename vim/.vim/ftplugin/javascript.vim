setlocal omnifunc=javascriptcomplete#CompleteJS

let g:ale_fixers['javascript'] = ['prettier']
let g:ale_javascript_prettier_options = '--single-quote --trailing-comma es5'
