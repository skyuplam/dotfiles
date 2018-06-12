setlocal omnifunc=javascriptcomplete#CompleteJS

let g:ale_fixers['javascript.jsx'] = ['prettier']
let g:ale_javascript_prettier_options = '--single-quote --trailing-comma es5'

let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1
