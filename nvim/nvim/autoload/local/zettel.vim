" vim: set foldmethod=marker foldlevel=0 nomodeline:

" Create a timstamped file in notes directory
func! local#zettel#edit(...)

  " Build the file name
  let l:sep = ''
  if len(a:000) > 0
    let l:sep = '-'
  endif
  let l:slug = strftime("%F-%H%M") . l:sep . tolower(join(a:000, '-'))
  let l:fname = expand(g:zettel_note_dir) . l:slug . '.md'

  " Edit the new file
  exec "e " . l:fname

  " Create front matter vars
  let l:title = len(a:000) > 0 ? join(a:000) : ''
  let l:datetime = strftime('%Y-%m-%d %H:%M')

  " Use UltiSnips to add TOM front matter, matadata for the notes
  exec "normal ggOtomfm\<tab>".l:title."\<c-j>".l:datetime."\<c-j>".l:slug."\<c-j>\<esc>G"
endfunc

function local#zettel#RgFzfZettel(query, fullscreen)
  let spec = {}
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec.options = ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]
  let spec.dir = expand(g:zettel_note_dir)

  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(fzf#wrap(spec)), a:fullscreen)
endfunction
