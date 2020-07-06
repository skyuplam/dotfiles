" Gruvbox
" set background=dark
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_bold=1
let g:gruvbox_italic=1
let g:gruvbox_italicize_comments=1


function s:OverrideGruvbox()
  highlight ColorColumn ctermbg=Gray guibg=#504945
  highlight NonText ctermfg=12 gui=bold guifg=#7c6f64
  highlight! Normal ctermbg=NONE guibg=NONE
  highlight! NonText ctermbg=NONE guibg=NONE
endfunction


augroup gruvboxAUG
  autocmd!
  " Override gruvbox for Transparet BG color
  autocmd ColorScheme * call <SID>OverrideGruvbox()
augroup END

colorscheme gruvbox
