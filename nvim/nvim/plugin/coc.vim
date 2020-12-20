command! -nargs=0  Format :call CocAction('format')<CR>
command! -nargs=?  Fold :call     CocAction('fold', <f-args>)
command! -nargs=0  OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
