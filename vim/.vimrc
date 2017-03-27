
" -----------------------------------------------
" Plugins loading for Vim Plug
" -----------------------------------------------

" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

" A tree explorer plugin for vim. https://github.com/scrooloose/nerdtree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'jistr/vim-nerdtree-tabs'

" Search
Plug 'mileszs/ack.vim'

" Active fork of kien/ctrlp.vim—Fuzzy file, buffer, mru, tag, etc finder
" http://ctrlpvim.github.com/ctrlp.vim
Plug 'ctrlpvim/ctrlp.vim'
Plug 'dyng/ctrlsf.vim'


" surround.vim: quoting/parenthesizing made simple
" http://www.vim.org/scripts/script.php?script_id=1697
Plug 'tpope/vim-surround'

" Comment functions so powerful—no comment necessary.
" https://github.com/scrooloose/nerdcommenter
Plug 'scrooloose/nerdcommenter'


" Tagbar
Plug 'majutsushi/tagbar'


Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'

" tern for vim for javascript
" Plug 'ternjs/tern_for_vim'


" YCM
" Plug 'Valloric/YouCompleteMe'
" Asynchronous keyword completion 
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" deoplete.nvim source for javascript
Plug 'carlitux/deoplete-ternjs'

Plug 'ervandew/supertab'

" vim Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

Plug 'Raimondi/delimitMate'

" Plug 'vim-syntastic/syntastic'
" Use Neomake instead of syntasitic
Plug 'neomake/neomake'

" Plug 'Yggdroot/indentLine'
" Plug 'nathanaelkane/vim-indent-guides'

Plug 'editorconfig/editorconfig-vim'

Plug 'tpope/vim-fugitive'

" A Vim plugin which shows a git diff in the gutter (sign column) and stages/undoes hunks.
Plug 'airblade/vim-gitgutter'

Plug 'tpope/vim-git'

Plug 'easymotion/vim-easymotion'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

" Vim bundle for styled-components based javascript files.
Plug 'fleischie/vim-styled-components'

Plug 'terryma/vim-multiple-cursors'

Plug 'tpope/vim-unimpaired'

Plug 'jeetsukumaran/vim-buffergator'

Plug 'ntpeters/vim-better-whitespace'

Plug 'python-mode/python-mode'

Plug 'tpope/vim-repeat'

Plug 'mattn/emmet-vim'

Plug 'mhinz/vim-startify'

Plug 'tmhedberg/matchit'

" Monokai color scheme for Vim converted from Textmate theme
Plug 'flazz/vim-colorschemes'
" Plug 'tomasr/molokai'
Plug 'ryanoasis/vim-devicons'

" Add plugins to &runtimepath
call plug#end()



"
" -----------------------------------------------
" Config
" -----------------------------------------------
"

" Set mapleader
let mapleader = ","

" NerdCommenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCustomDelimiters = { 'javascript.jsx': { 'left': '//', 'leftAlt': '/*', 'rightAlt': '*/' }}


" Syntax Color
syntax on                   " Syntax highlighting
colorscheme monokai
set mouse=a                 " Automatically enable mouse usage
set mousehide               " Hide the mouse cursor while typing
scriptencoding utf-8
" Set font
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Knack\ Regular\ Nerd\ Font\ Complete\ h12
  elseif has("gui_macvim")
    set guifont=Knack\ Regular\ Nerd\ Font\ Complete:h12
  endif
endif

set scrolloff=3
set showmode
set showcmd
set backspace=indent,eol,start  "Backspace for dummies
set linespace=0  " No extra spaces between rows
set showmatch  " Show matching brackets/parenthesis
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set winminheight=0              " Windows can be 0 line high
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set wildignore=*.swp            " ignore swp files in completion
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set scrolljump=5                " Lines to scroll when cursor leaves screen
set modeline                    " Always show modeline
set scrolloff=3                 " Minimum lines to keep above and below cursor
set foldenable                  " Auto fold code
set foldlevelstart=10           " open most folds by default to
set foldnestmax=10              " 10 nested fold max
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,sql
" set shell=/bin/zsh
set gdefault        " Add the `g` flag to search/replace by default

set tabpagemax=15  " Only show 15 tabs
set showmode  " Display the current mode
set cursorline  " Highlight the current line



if has('clipboard')
    if has('unnamedplus')  " When possible use + register for copy-paste
        set clipboard=unnamed,unnamedplus
    else
        set clipboard=unnamed
    endif
endif


" vim-syntastic/syntastic config
" let g:syntastic_mode_map = { 'mode': 'active',
"                             \ 'active_filetypes': ['python', 'javascript', 'javascript.jsx'],
"                             \ 'passive_filetypes': [] }

" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_shell = "/bin/zsh"
" let g:syntastic_aggregate_errors = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" let g:syntastic_javascript_checkers = ['eslint']
" let g:syntastic_javascript_eslint_exec = 'eslint_d'
" let g:syntastic_python_checkers = ['pylint']

" Neomake settings, run Neomake on the current file on every write
autocmd! BufWritePost * Neomake
let g:neomake_javascript_enabled_makers = ['eslint']

" To ensure that this plugin works well with Tim Pope's fugitive, use the
" following patterns array:
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

let g:EditorConfig_exec_path = '/usr/local/bin/editorconfig'
" Enable spell check for commit messages
autocmd FileType gitcommit setlocal spell

" vim-indent-guides config
" set background=dark
" hi IndentGuidesOdd  ctermbg=black
" hi IndentGuidesEven ctermbg=darkgrey
" let g:indent_guides_start_level=2
" let g:indent_guides_guide_size=1

" IndentGuide
" let g:indentLine_enabled = 1
" let g:indentLine_color_term = 239
" let g:indentLine_color_gui = '#616161'

" indent space
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=2
" when indenting with '>', use 4 spaces width
set shiftwidth=2
" on pressing tab, insert 4 spaces
set expandtab
set smarttab
set autoindent
" in makefiles, don't expand tabs to spaces, since actual tab characters are
" needed, and have indentation at 8 chars to be sure that all indents are tabs
" (despite the mappings later):
autocmd FileType make setlocal noexpandtab shiftwidth=8 softtabstop=0

" Column width guide
if exists('+colorcolumn')
  set textwidth=80
  set colorcolumn=+1
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" Line Number
set relativenumber
set number

" Add %{fugitive#statusline()} to your statusline to get an indicator including
" the current branch and the currently edited file's commit.  If you don't have
" a statusline, this one matches the default when 'ruler' is set:
" set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" Set airline theme
let g:airline_theme='dark'
let g:airline_powerline_fonts=1  " enable powerline fonts
set laststatus=2  " appear all the time

" Use 256 colors
set t_Co=256

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

" ag search
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

endif

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


" YouCompleteMe
" let g:acp_enableAtStartup = 0
" let g:ycm_python_binary_path = '/usr/local/bin/python3'
" let g:ycm_collect_identifiers_from_tags_files = 1    " Enable completion from tags

" Enable deoplete
let g:deoplete#enable_at_startup = 1

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

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
set completeopt-=preview

" Autocompolete with dictoinary words when spell check is on
set complete+=kspell

" Emmet-vim
" Enable in different mode
let g:user_emmet_mode='a'    "enable all function in all mode.
" Enable just for html/css/javascript
let g:user_emmet_install_global = 0
autocmd FileType html,css,javascript EmmetInstall

" Nvim specific config
if has('nvim')
  " Program to use for evaluating Python code. Setting this makes startup faster.
  " Also useful for working with virtualenvs.
  let g:python_host_prog  = '/usr/local/bin/python'
  let g:python3_host_prog  = '/usr/local/bin/python3'
endif

if !has('nvim')
  set ttyfast
  set encoding=utf-8
endif

set nocompatible
set nobackup
set nowritebackup
set noswapfile


" Use Truecolors
set termguicolors

" -----------------------------------------------
" Key Mapping
" -----------------------------------------------
"

" NERDTree
map <C-e> :NERDTreeToggle<CR>

" Fugitive
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gp :Git push<CR>
nnoremap <silent> <leader>gr :Gread<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>
nnoremap <silent> <leader>ge :Gedit<CR>
nnoremap <silent> <leader>gi :Git add -p %<CR>
nnoremap <silent> <leader>gg :SignifyToggle<CR>

" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" Mappings to move lines
nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==
inoremap ∆ <A-j> <Esc>:m .+1<CR>==gi
inoremap ˚ <Esc>:m .-2<CR>==gi
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv

" Tagbar
nmap <leader>tt :TagbarToggle<CR>

" incsearch.vim
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" fuzzy search
map z/ <Plug>(incsearch-fuzzy-/)
map z? <Plug>(incsearch-fuzzy-?)
map zg/ <Plug>(incsearch-fuzzy-stay)

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" JSON
nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>

" edit vimrc and reload vimrc - mnemonic: (e)dit(v)imrc, (r)eload(v)imrc
nnoremap <leader>ev :tabe $MYVIMRC<CR>
nnoremap <leader>rv :source $MYVIMRC<CR>

" ctrlsf.vim mapping
nmap <leader>sf <Plug>CtrlSFPrompt
vmap <leader>sf <Plug>CtrlSFVwordPath
vmap <leader>sF <Plug>CtrlSFVwordExec
nmap <leader>sp <Plug>CtrlSFPwordPath
nnoremap <leader>so :CtrlSFOpen<CR>
nnoremap <leader>st :CtrlSFToggle<CR>
inoremap <leader>st <Esc>:CtrlSFToggle<CR>

" Map ag
nmap <leader>ag :Ack ""<Left>
nmap <leader>af :AckFile ""<Left>


" Neomake key mapping
nmap <Leader><Space>o :lopen<CR>      " open location window
nmap <Leader><Space>c :lclose<CR>     " close location window
nmap <Leader><Space>, :ll<CR>         " go to current error/warning
nmap <Leader><Space>n :lnext<CR>      " next error/warning
nmap <Leader><Space>p :lprev<CR>      " previous error/warning

