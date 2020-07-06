scriptencoding utf-8

" coc & ale statusline
function local#statusline#DiagnosticCocAleStatus() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  let l:counts = ale#statusline#Count(bufnr(''))

  if empty(info) && l:counts.total == 0 | return '' | endif

  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  let msgs = []
  let errors = get(info, 'error', 0) + l:all_errors
  let warnings = get(info, 'warning', 0) + l:all_non_errors

  if errors
    call add(msgs, errors . '✖')
  endif
  if warnings
    call add(msgs, warnings . '⚠')
  endif
  let msgFmt = empty(msgs) ? '' : '[' . join(msgs, ' '). '] '
  return msgFmt . get(g:, 'coc_status', '')
endfunction

function local#statusline#SummarizeGitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction

function local#statusline#ConstructStatusline()
  let mod = "%{&modified ? '[+] ' : !&modifiable ? '[x] ' : ''}"
  let ro  = "%{&readonly ? '[RO] ' : ''}"
  let ft  = "%{len(&filetype) ? '['.&filetype.'] ' : ''}"
  " let fug = "%{exists('g:loaded_fugitive') ? fugitive#statusline() : ''}"
  let sep = ' %= '
  let pos = ' %-12(%l : %c%V%) '
  let pct = ' %P'
  " let ale = "%{len(LinterStatus()) ? LinterStatus() : ''}"
  let coc = '%{local#statusline#DiagnosticCocAleStatus()}'
  let coc_git = "%{get(g:,'coc_git_status','')}%{get(b:,'coc_git_status','')}%{get(b:,'coc_git_blame','')}"
  let git_status = '%{local#statusline#SummarizeGitStatus()}'

  return coc.'[%n] %f %<'.mod.ro.ft.coc_git.git_status.sep.pos.'%*'.pct
endfunction

function local#statusline#RefreshStatusline()
  let &statusline = local#statusline#ConstructStatusline()
endfunction
