"
" -----------------------------------------------
" Config
" -----------------------------------------------
"

source ~/.vim/configs/plugins.vim  " Plugins for vim-plug
source ~/.vim/configs/settings.vim  "General settings
source ~/.vim/configs/mappings.vim  " Key Mappings


" NerdCommenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCustomDelimiters = { 'javascript.jsx': { 'left': '//', 'leftAlt': '/*', 'rightAlt': '*/' }}

" Neomake settings, run Neomake on the current file on every write
autocmd! BufWritePost * Neomake
" Neomake Javascript
let g:neomake_open_list = 0
let g:neomake_verbose = 1
let g:neomake_javascript_jsx_enabled_makers = ['eslint']
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_javascript_eslint_exe = 'eslint_d'  " Use eslint_d for faster linting
" Neomake Python
let g:neomake_python_enabled_makers = ['pyflakes']


" To ensure that this plugin works well with Tim Pope's fugitive, use the
" following patterns array:
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
let g:EditorConfig_exec_path = '/usr/local/bin/editorconfig'

" Add %{fugitive#statusline()} to your statusline to get an indicator including
" the current branch and the currently edited file's commit.  If you don't have
" a statusline, this one matches the default when 'ruler' is set:
" set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" Set airline theme
let g:airline_theme='dark'
let g:airline_powerline_fonts=1  " enable powerline fonts

" Vim-jsx
let g:jsx_ext_required = 0

" CtrlP config
" Ignore files and directories
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|\.hg|\.svn|node_modules|build|dist)$',
  \ 'file': '\v\.(exe|so|dll|pyc)$',
  \ }
let g:ctrlp_mruf_max = 250             " track recently used files
let g:ctrlp_max_height = 20            " provide more space to display results
let g:ctrlp_switch_buffer = ''         " don't try to switch buffers

if executable('ag')
    let g:ackprg = 'ag --vimgrep'
    set grepprg=ag\ --nogroup\ --nocolor
    let s:ctrlp_fallback = 'ag -Q %s --hidden --nocolor -l -g ""'
    let s:ctrlp_use_caching = 0        " ag is fast enough that ctrlp doesn't need to cache
elseif executable('ack-grep')
    let s:ctrlp_fallback = 'ack-grep %s --nocolor -f'
elseif executable('ack')
    let s:ctrlp_fallback = 'ack %s --nocolor -f'
else
    let s:ctrlp_fallback = 'find %s -type f'
endif


" NerdTree
let NERDTreeIgnore=['\.py[cd]$',
    \ '\~$', '\.swo$', '\.swp$', '^\.git$',
    \ '^\.hg$', '^\.svn$', '\.bzr$', '\.DS_Store$']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1
let g:nerdtree_tabs_open_on_gui_startup=0

" NERDTree Git plugin
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Ignored"   : "👻",
    \ "Unknown"   : "?"
    \ }

" Enable deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#enable_refresh_always = 1

" ternjs deoplete config
" Use deoplete.
let g:tern_request_timeout = 1
let g:tern_show_signature_in_pum = '0'  " This do disable full signature type on autocomplete

"Add extra filetypes
let g:tern#filetypes = [
                \ 'jsx',
                \ 'javascript.jsx',
                \ 'vue',
                \ ]

" Emmet-vim
" Enable in different mode
let g:user_emmet_mode='a'    "enable all function in all mode.
" Enable just for html/css/javascript
let g:user_emmet_install_global = 0
autocmd FileType html,css,javascript,javascript.jsx EmmetInstall

