scriptencoding utf-8

" coc & ale statusline
function local#statusline#DiagnosticCocStatus() abort
  let info = get(b:, 'coc_diagnostic_info', {})

  if empty(info) | return '' | endif

  let msgs = []

  if get(info, 'error', 0)
    call add(msgs, info['error'] . '✖ ')
  endif

  if get(info, 'warning', 0)
    call add(msgs, info['warning'] . '⚠ ')
  endif

  let msgFmt = empty(msgs) ? '' : '[' . join(msgs, ' '). '] '
  return msgFmt . get(g:, 'coc_status', '') . get(b:,'coc_current_function','')
endfunction

function local#statusline#SummarizeGitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction

function local#statusline#ConstructStatusline()
  let mod = "%{&modified ? '[+] ' : !&modifiable ? '[x] ' : ''}"
  let ro  = "%{&readonly ? '[RO] ' : ''}"
  let ft  = "%{len(&filetype) ? '['.&filetype.'] ' : ''}"
  let sep = ' %= '
  let pos = ' %-12(%l : %c%V%) '
  let pct = ' %P'
  let coc = '%{local#statusline#DiagnosticCocStatus()}'
  let coc_git = "%{get(g:,'coc_git_status','')}%{get(b:,'coc_git_status','')}%{get(b:,'coc_git_blame','')}"
  let git_status = '%{local#statusline#SummarizeGitStatus()}'

  return coc.'[%n] %f %<'.mod.ro.ft.coc_git.git_status.sep.pos.'%*'.pct
endfunction

function local#statusline#RefreshStatusline()
  let &statusline = local#statusline#ConstructStatusline()
endfunction
