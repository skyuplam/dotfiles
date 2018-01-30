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
  Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
  Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
  Plug 'jistr/vim-nerdtree-tabs', { 'on': 'NERDTreeToggle' }
  Plug 'jlanzarotta/bufexplorer', { 'on': 'BufExplorer' }
  Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }

  " Active fork of kien/ctrlp.vim—Fuzzy file, buffer, mru, tag, etc finder
  " http://ctrlpvim.github.com/ctrlp.vim
  Plug 'tpope/vim-sensible'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'benmills/vimux'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'Shougo/denite.nvim', Cond(has('nvim'))
  " surround.vim: quoting/parenthesizing made simple
  " http://www.vim.org/scripts/script.php?script_id=1697
  Plug 'tpope/vim-surround'
  " Comment functions so powerful—no comment necessary.
  " https://github.com/scrooloose/nerdcommenter
  Plug 'scrooloose/nerdcommenter'
  " Asynchronous keyword completion
  if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
  endif
  Plug 'wokalski/autocomplete-flow', { 'for': ['javascript', 'jsx', 'javascript.jsx'] }
  Plug 'zchee/deoplete-jedi', { 'for': 'python' }
  " For func argument completion
  Plug 'Shougo/neosnippet'
  Plug 'Shougo/neosnippet-snippets'
  Plug 'sebastianmarkow/deoplete-rust'

  Plug 'ervandew/supertab'
  " vim Markdown
  Plug 'godlygeek/tabular'
  Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
  Plug 'Raimondi/delimitMate'
  " Use Neomake instead of syntasitic
  " Plug 'neomake/neomake', Cond(has('nvim'))
  " Plug 'benjie/neomake-local-eslint.vim', Cond(has('nvim'))
  " ALE
  Plug 'w0rp/ale'
  Plug 'tpope/vim-fugitive'
  Plug 'bfredl/nvim-miniyank', Cond(has('nvim'))
  " Interactive command execution in Vim
  Plug 'Shougo/vimproc.vim', {'do' : 'make'}
  " A Vim plugin which shows a git diff in the gutter (sign column) and stages/undoes hunks.
  Plug 'airblade/vim-gitgutter'
  Plug 'mhinz/vim-signify'
  Plug 'tpope/vim-git'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'jsx', 'javascript.jsx'] }
  Plug 'dag/vim-fish', { 'for': ['fish'] }
  Plug 'rust-lang/rust.vim', { 'for': 'rust' }
  Plug 'mxw/vim-jsx', { 'for': ['javascript', 'jsx', 'javascript.jsx'] }
  Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
  Plug 'elzr/vim-json', { 'for': 'json' }
  Plug 'tpope/vim-unimpaired'
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'tpope/vim-repeat'
  Plug 'mattn/emmet-vim', { 'for': ['javascript', 'jsx', 'javascript.jsx', 'html'], 'do': ':EmmetInstall' }
  Plug 'mhinz/vim-startify'
  Plug 'tmhedberg/matchit'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'rafi/awesome-vim-colorschemes'
  Plug 'ryanoasis/vim-devicons'
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
" set cursorline                  " Highlight the current line

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
" augroup vimrc-sync-fromstart
"   autocmd!
"   autocmd BufEnter * :syntax sync maxlines=200
" augroup END


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
  " autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile .{jscs,jshint,eslint,babel}rc set filetype=json
augroup END

" Always use vertical diffs
set diffopt+=vertical

" -----------------------------------------------
" Plugin config
" -----------------------------------------------

" Color Scheme
" syntax enable
set background=dark
let g:solarized_termtrans=1
let g:solarized_visibility='high'
colorscheme solarized8

" NerdCommenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCustomDelimiters = { 'javascript.jsx': { 'left': '//', 'leftAlt': '/*', 'rightAlt': '*/' }}
let g:NERDTrimTrailingWhitespace = 1

" Startify
let g:startify_change_to_dir = 0

" ALE
" Enable airline
let g:airline#extensions#ale#enabled = 1
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
" custom echos message
let g:ale_echo_msg_error_str = '✖'
let g:ale_echo_msg_warning_str = '⚠'
let g:ale_echo_msg_warning_str = '!'
let g:ale_echo_msg_format = '%severity%[%linter%]%code: %%s'

" Deoplete
let g:deoplete#enable_at_startup = 1
let g:neosnippet#enable_completed_snippet = 1
let g:deoplete#sources#rust#racer_binary='$HOME/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path='$HOME/dev/oss/rust/src'
set completeopt-=preview


" Denite
if has('nvim')
  call denite#custom#var('file_rec', 'command',
      \ ['rg', '--files', '--glob', '!.git'])
  call denite#custom#var('grep', 'command', ['rg'])
  call denite#custom#var('grep', 'default_opts',
      \ ['--vimgrep', '--no-heading'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'final_opts', [])
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
" let g:ctrlp_custom_ignore = {
"   \ 'dir':  '\v[\/](\.git|\.hg|\.svn|node_modules|build|dist)$',
"   \ 'file': '\v\.(exe|so|dll|pyc)$',
"   \ }
let g:ctrlp_mruf_max = 30              " track recently used files
let g:ctrlp_max_height = 20            " provide more space to display results
let g:ctrlp_switch_buffer = 0          " don't try to switch buffers
let g:ctrlp_match_window = 'bottom,order:ttb'

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
let g:rg_cmd ='rg --column --line-number --no-heading --fixed-strings
  \ --ignore-case --color "always" --no-ignore --hidden --follow
  \ --glob "!.git/*" '
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(g:rg_cmd .shellescape(<q-args>), 1,
  \ <bang>0 ? fzf#vim#with_preview('up:60%')
  \         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \ <bang>0)
let g:fzf_layout = { 'down': '~40%' }

if executable('rg')
  set grepprg=rg\ --vimgrep
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 1
elseif executable('ag')
  " let g:ackprg = 'ag --vimgrep --smart-case'
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag -Q -l --nocolor -g "" %s'
  let g:ctrlp_use_caching = 1
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

" Undotree persistent
if has("persistent_undo")
    set undodir=~/.vim/.undodir/
    set undofile
endif

" JSON
let g:vim_json_syntax_conceal = 0

" Tmux
" allows cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" -----------------------------------------------
" Key Mapping
" -----------------------------------------------

" Set mapleader
let mapleader = ","

" Explorer Mapping
nnoremap <C-e> :NERDTreeToggle<CR>
nnoremap <c-p> :CtrlP<cr>

" Undotree
nnoremap <leader>ut :UndotreeToggle<CR>

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

" ALE keymapping
nmap <silent> <Leader><Space>p <Plug>(ale_previous_wrap)
nmap <silent> <Leader><Space>n <Plug>(ale_next_wrap)
nmap <silent> <Leader><Space>l :lopen<CR>


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

" nvim-miniyank
map p <Plug>(miniyank-autoput)
map P <Plug>(miniyank-autoPut)
map <leader>p <Plug>(miniyank-startput)
map <leader>P <Plug>(miniyank-startPut)
map <leader>n <Plug>(miniyank-cycle)
if has('nvim')
  map <leader>l :Denite miniyank<CR>
endif

" Vimux
map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vl :VimuxRunLastCommand<CR>
