" -----------------------------------------------
" Plugins
" -----------------------------------------------

" Helper function for conditional loading plugin
function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')
  " A tree explorer plugin for vim. https://github.com/scrooloose/nerdtree
  Plug 'scrooloose/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'jistr/vim-nerdtree-tabs'
  Plug 'majutsushi/tagbar'
  " Active fork of kien/ctrlp.vim—Fuzzy file, buffer, mru, tag, etc finder
  " http://ctrlpvim.github.com/ctrlp.vim
  Plug 'ctrlpvim/ctrlp.vim'
  " surround.vim: quoting/parenthesizing made simple
  " http://www.vim.org/scripts/script.php?script_id=1697
  Plug 'tpope/vim-surround'
  " Comment functions so powerful—no comment necessary.
  " https://github.com/scrooloose/nerdcommenter
  Plug 'scrooloose/nerdcommenter'
  " Asynchronous keyword completion
  Plug 'Shougo/deoplete.nvim', Cond(has('nvim'), { 'do': ':UpdateRemotePlugins' })
  " deoplete.nvim source for javascript
  Plug 'carlitux/deoplete-ternjs', Cond(has('nvim'))
  " deoplete.nvim for jedi for python
  Plug 'zchee/deoplete-jedi'
  Plug 'ervandew/supertab'
  " vim Markdown
  Plug 'godlygeek/tabular'
  Plug 'plasticboy/vim-markdown'
  Plug 'Raimondi/delimitMate'
  " Use Neomake instead of syntasitic
  Plug 'neomake/neomake', Cond(has('nvim'))
  Plug 'benjie/neomake-local-eslint.vim', Cond(has('nvim'))
  Plug 'tpope/vim-fugitive'
  " Interactive command execution in Vim
  Plug 'Shougo/vimproc.vim', {'do' : 'make'}
  " Yank stack
  Plug 'maxbrunsfeld/vim-yankstack'
  " A Vim plugin which shows a git diff in the gutter (sign column) and stages/undoes hunks.
  Plug 'airblade/vim-gitgutter'
  Plug 'mhinz/vim-signify'
  Plug 'tpope/vim-git'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'pangloss/vim-javascript'
  Plug 'rust-lang/rust.vim'
  Plug 'sebastianmarkow/deoplete-rust'
  Plug 'mxw/vim-jsx'
  Plug 'elzr/vim-json'
  Plug 'moll/vim-node'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'tpope/vim-unimpaired'
  Plug 'jeetsukumaran/vim-buffergator'
  Plug 'ntpeters/vim-better-whitespace'
  " Plug 'python-mode/python-mode'
  Plug 'tpope/vim-repeat'
  Plug 'mattn/emmet-vim'
  Plug 'mhinz/vim-startify'
  Plug 'tmhedberg/matchit'
  " Plug 'mileszs/ack.vim'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  " Monokai color scheme for Vim converted from Textmate theme
  Plug 'crusoexia/vim-monokai'
  Plug 'ryanoasis/vim-devicons'
  " Add plugins to &runtimepath
call plug#end()



" -----------------------------------------------
" General Config
" -----------------------------------------------

set nocompatible
set nobackup
set nowritebackup
set noswapfile
set mouse=a                 " Automatically enable mouse usage
set mousehide               " Hide the mouse cursor while typing
scriptencoding utf-8
" Set font
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Knack\ Regular\ Nerd\ Font\ Complete\ h13
  elseif has("gui_macvim")
    set guifont=Knack\ Regular\ Nerd\ Font\ Complete:h12
  endif
endif

set scrolloff=3
set showmode
set showcmd
set modeline                    " Always show modeline
set backspace=indent,eol,start  "Backspace for dummies
set linespace=0                 " No extra spaces between rows
set showmatch                   " Show matching brackets/parenthesis
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set winminheight=0              " Windows can be 0 line high
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set wildmenu                    " Show list instead of just completing
set wildignore=*.swp            " ignore swp files in completion
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set foldenable                  " Auto fold code
set foldlevelstart=10           " open most folds by default to
set foldnestmax=10              " 10 nested fold max
set synmaxcol=200               " Don't syntax highlight long lines
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
" set shell=/bin/zsh
set gdefault                    " Add the `g` flag to search/replace by default

set tabpagemax=15               " Only show 15 tabs
set cursorline                  " Highlight the current line

" Open splits more naturally
set splitbelow
set splitright


if has('clipboard')
    if has('unnamedplus')       " When possible use + register for copy-paste
        set clipboard=unnamed,unnamedplus
    else
        set clipboard=unnamed
    endif
endif

" Indent space
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=2
" when indenting with '>', use 4 spaces width
set shiftwidth=2
" on pressing tab, insert 4 spaces
set expandtab
set shiftround
set smarttab
set autoindent

" Use one space, not two, after punctuation.
set nojoinspaces

" Column width guide
if exists('+colorcolumn')
  set textwidth=80
  set colorcolumn=+1
endif

" Line Number
set relativenumber
set number

set laststatus=2  " appear all the time

" The PC is fast enough, do syntax highlight syncing from start unless 200 lines
augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync maxlines=200
augroup END

" Enable spell check for commit messages
autocmd FileType gitcommit setlocal spell
" in makefiles, don't expand tabs to spaces, since actual tab characters are
" needed, and have indentation at 8 chars to be sure that all indents are tabs
" (despite the mappings later):
autocmd FileType make setlocal noexpandtab shiftwidth=4 softtabstop=0
" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
" set completeopt-=preview

" Autocompolete with dictoinary words when spell check is on
set complete+=kspell

if !has('nvim')
  set ttyfast
  set encoding=utf-8
endif

" Nvim specific config
if has('nvim')
  " Program to use for evaluating Python code. Setting this makes startup faster.
  " Also useful for working with virtualenvs.
  if (system('uname') =~ "darwin")
    let g:python_host_prog  = '/usr/local/bin/python'
  else
    let g:python3_host_prog  = '/usr/bin/python'
  endif

  " Use Truecolors
  set termguicolors
endif

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile .{jscs,jshint,eslint,babel}rc set filetype=json
augroup END

" Always use vertical diffs
set diffopt+=vertical

" -----------------------------------------------
" Plugin config
" -----------------------------------------------

" Color Scheme
colorscheme monokai

" NerdCommenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCustomDelimiters = { 'javascript.jsx': { 'left': '//', 'leftAlt': '/*', 'rightAlt': '*/' }}

" Startify
let g:startify_change_to_dir = 0

if has('nvim')
  " Neomake settings, run Neomake on the current file on every write autocmd! BufWritePost * Neomake
  " Neomake Javascript
  autocmd! BufWritePost * Neomake

  " This maker should be run explicitly using the command `:Neomake! clippy`.
  " It needs a nightly build of Rust, and supports rustup.

  let g:neomake_open_list = 0
  let g:neomake_verbose = 1
  let g:neomake_javascript_enabled_makers = ['eslint']
  let g:neomake_javascript_jsx_enabled_makers = ['eslint']
  let g:neomake_rust_enabled_makers = ['cargo', 'rustc']
  " Neomake Python
  let g:neomake_python_enabled_makers = ['pyflakes', 'mypy', 'pylint', 'flake8']


  " Enable deoplete
  let g:deoplete#enable_at_startup = 1
  " jedi deoplete config
  let g:deoplete#sources#jedi#show_docstring = 0
  " ternjs deoplete config
  " Use deoplete.
  let g:tern_request_timeout = 1
  let g:tern_show_signature_in_pum = '0'  " This do disable full signature type on autocomplete
  let g:deoplete#auto_complete_delay = 50
  "Add extra filetypes
  let g:tern#filetypes = [
                  \ 'jsx',
                  \ 'javascript.jsx',
                  \ 'vue',
                  \ ]
  " Rust Racer for autocomplete with deoplete
  let g:deoplete#sources#rust#racer_binary=$HOME.'/.cargo/bin/racer'
  let g:deoplete#sources#rust#rust_source_path=$RUST_SRC_PATH
  let g:deoplete#sources#rust#documentation_max_height=20
endif


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
" Airline workaround for [neovim](https://github.com/neovim/neovim/issues/4487)
" TODO: enable it back when the bug fixed
if has('nvim')
  let g:airline#extensions#branch#enabled = 0
endif

" Vim-jsx
let g:jsx_ext_required = 0

" CtrlP config
" Ignore files and directories
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|\.hg|\.svn|node_modules|build|dist)$',
  \ 'file': '\v\.(exe|so|dll|pyc)$',
  \ }
let g:ctrlp_mruf_max = 50             " track recently used files
let g:ctrlp_max_height = 20            " provide more space to display results
let g:ctrlp_switch_buffer = 0         " don't try to switch buffers

" :Find <expr>
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

if executable('rg')
  set grepprg=rg\ --vimgrep
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
elseif executable('ag')
  " let g:ackprg = 'ag --vimgrep --smart-case'
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag -Q -l --nocolor -g "" %s'
  let g:ctrlp_use_caching = 0
  cnoreabbrev ag Ack

  if !exists(":Ag")
    command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
    nnoremap \ :Ag<SPACE>
  endif
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


" Emmet-vim
" Enable in different mode
let g:user_emmet_mode='a'    "enable all function in all mode.
" Enable just for html/css/javascript
let g:user_emmet_install_global = 0
autocmd FileType html,css,javascript,javascript.jsx EmmetInstall

" Yankstack
" Load yankstack without default key mappings
let g:yankstack_map_keys = 0

" JSON
let g:vim_json_syntax_conceal = 0

" -----------------------------------------------
" Key Mapping
" -----------------------------------------------
"

" Set mapleader
let mapleader = ","

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

nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

nnoremap <A-Down> :m .+1<CR>==
nnoremap <A-Up> :m .-2<CR>==
inoremap <A-Down> <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-Up> <Esc>:m .-2<CR>==gi
vnoremap <A-Down> :m '>+1<CR>gv=gv
vnoremap <A-Up> :m '<-2<CR>gv=gv

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

" Neomake key mapping
nmap <Leader><Space>o :lopen<CR>      " open location window
nmap <Leader><Space>c :lclose<CR>     " close location window
nmap <Leader><Space>, :ll<CR>         " go to current error/warning
nmap <Leader><Space>n :lnext<CR>      " next error/warning
nmap <Leader><Space>p :lprev<CR>      " previous error/warning

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" Rust
nmap <Leader>rf :RustFmt<CR>          " format your code with rustfmt

" Yankstack
nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste

" Tagbar
nmap <F8> :TagbarToggle<CR>
