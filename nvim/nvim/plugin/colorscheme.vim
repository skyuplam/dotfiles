let g:gruvbox_italic = 1
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_italicize_comments = 1
let g:gruvbox_italicize_strings = 1

set background=dark
colorscheme gruvbox

hi Normal guibg=NONE ctermbg=NONE

if &background ==# 'dark' | hi! VertSplit gui=NONE guibg=NONE guifg=#333333 cterm=NONE ctermbg=NONE ctermfg=14 | endif
hi link ALEError DiffDelete
hi link ALEErrorSign DiffDelete
hi link ALEWarning DiffChange
hi link ALEWarningSign DiffChange
hi link LspDiagnosticsDefaultError DiffDelete
hi link LspDiagnosticsDefaultWarning DiffChange
hi link LspDiagnosticsDefaultHint NonText
hi User5 ctermfg=Red guifg=Red
hi User6 ctermfg=Yellow guifg=Yellow
hi User7 ctermfg=Cyan guifg=Cyan
hi User8 ctermfg=LightBlue guifg=LightBlue
hi NormalFloat cterm=NONE ctermbg=0 gui=NONE guibg=#000000
