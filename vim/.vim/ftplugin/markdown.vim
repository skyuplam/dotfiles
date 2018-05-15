" Enable spellchecking
setlocal spell
setlocal omnifunc=htmlcomplete#CompleteTags

" Automatically wrap at 80 characters
setlocal textwidth=80

setlocal expandtab
setlocal smarttab
setlocal autoindent
setlocal linebreak
setlocal shiftwidth=2
setlocal tabstop=2

" [Plugin Repo](https://github.com/plasticboy/vim-markdown)
" Disable folding
let g:vim_markdown_folding_disabled = 1
setlocal nofoldenable

" Enable TOC window auto-fit
let g:vim_markdown_toc_autofit = 1

" Enable Syntax Concealing
set conceallevel=2

" Folow named anchors
let g:vim_markdown_follow_anchor = 1

" Front matters
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1

" Adjust new list item indent
let g:vim_markdown_new_list_item_indent = 2

" vim:set sw=2:
