function s:OnTabEnter(path)
  if isdirectory(a:path)
    let dirname = a:path
  else
    let dirname = fnamemodify(a:path, ':h')
  endif
  execute 'tcd '. dirname
endfunction


" Change working directory on tab change
augroup tabwd
  autocmd!
  autocmd TabNewEntered * call <SID>OnTabEnter(expand("<amatch>"))
augroup end
