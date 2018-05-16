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

  Plug 'christoomey/vim-tmux-navigator'
  Plug 'benmills/vimux'
  " surround.vim: quoting/parenthesizing made simple
  Plug 'tpope/vim-surround'
  " Asynchronous keyword completion
  if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
  endif
  Plug 'zchee/deoplete-jedi', { 'for': 'python' }
  Plug 'Shougo/context_filetype.vim'
  Plug 'carlitux/deoplete-ternjs'
  Plug 'sebastianmarkow/deoplete-rust', { 'for': 'rust' }

  " org-mode
  Plug 'mattn/calendar-vim'
  Plug 'jceb/vim-orgmode'
  Plug 'tpope/vim-speeddating'

  Plug 'ervandew/supertab'
  " vim Markdown
  Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
  " ALE
  Plug 'w0rp/ale'
  " Plug 'tpope/vim-fugitive'
  " Interactive command execution in Vim
  Plug 'Shougo/vimproc.vim', {'do' : 'make'}
  " A Vim plugin which shows a git diff in the gutter (sign column) and stages/undoes hunks.
  Plug 'airblade/vim-gitgutter'
  Plug 'mhinz/vim-signify'
  Plug 'tpope/vim-git'
  Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'jsx', 'javascript.jsx'] }
  Plug 'dag/vim-fish', { 'for': ['fish'] }
  Plug 'rust-lang/rust.vim', { 'for': 'rust' }
  Plug 'cespare/vim-toml', { 'for': 'toml' }
  Plug 'mxw/vim-jsx', { 'for': ['javascript', 'jsx', 'javascript.jsx'] }
  Plug 'autozimu/LanguageClient-neovim', Cond(has('nvim'),
        \ { 'branch': 'next', 'do': 'bash install.sh', 'for': ['rust', 'python'] })
  Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
  Plug 'elzr/vim-json', { 'for': 'json' }
  " Plug 'tpope/vim-unimpaired'
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'tpope/vim-repeat'
  Plug 'mattn/emmet-vim', { 'for': ['javascript', 'jsx', 'javascript.jsx', 'html'], 'do': ':EmmetInstall' }
  Plug 'mhinz/vim-startify'
  Plug 'tmhedberg/matchit'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
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
    set guifont=Knack\ Regular\ Nerd\ Font\ Complete\ h12
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
set gdefault                    " Add the `g` flag to search/replace by default

" if &shell =~# 'fish$'
"   set shell=$(which zsh)
" endif

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
" show existing tab with 2 spaces width
set tabstop=2
" when indenting with '>', use 2 spaces width
set shiftwidth=2
" on pressing tab, insert 2 spaces
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

" Statusline
set laststatus=2  " appear all the time

function! LinterStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))

  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  return l:counts.total == 0 ? '' : printf(
  \   '[%dW %dE]',
  \   all_non_errors,
  \   all_errors
  \)
endfunction

" Add %{fugitive#statusline()} to your statusline to get an indicator including
" the current branch and the currently edited file's commit.  If you don't have
" a statusline, this one matches the default when 'ruler' is set:
set statusline=
set statusline+=%7*\%{LinterStatus()}                     "Linter
set statusline+=%0*\[%n]                                  "buffernr
set statusline+=%8*\ %<%f\                                "File+path
" set statusline+=%4*\ \[%{fugitive#head()}]%h%m%r%w\       "Fugitive
set statusline+=%2*\ %y\                                  "FileType
set statusline+=%3*\ %{''.(&fenc!=''?&fenc:&enc).''}      "Encoding
set statusline+=%3*\ %{(&bomb?\",BOM\":\"\")}\            "Encoding2
set statusline+=%4*\ %{&ff}\                              "FileFormat (dos/unix..)
set statusline+=%8*\ %=(%l,%c%V)\                         "(row,col)
set statusline+=%5*\ %P\                                  "Modified? Readonly? Top/bot.

" Encoding
if !has('nvim')
  set ttyfast
  set encoding=utf-8
  set encoding=utf-8
  set termencoding=utf-8
  set fileencoding=utf-8
  set fileencodings=utf-8
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
  autocmd BufRead,BufNewFile *.{js,jsx} set filetype=javascript
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile .{jscs,jshint,eslint,babel}rc set filetype=json
  autocmd BufRead,BufNewFile {Dockerfile,*.docker} set filetype=dockerfile
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

" Startify
let g:startify_change_to_dir = 0

" ALE
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
" custom echos message
let g:ale_echo_msg_error_str = '✖'
let g:ale_echo_msg_warning_str = '⚠'
let g:ale_echo_msg_warning_str = '!'
let g:ale_echo_msg_format = '%severity%[%linter%]%code: %%s'

" Do not lint or fix minified files.
let g:ale_pattern_options = {
\ '\.min\.js$': {'ale_linters': [], 'ale_fixers': []},
\ '\.min\.css$': {'ale_linters': [], 'ale_fixers': []},
\}

" Deoplete
let g:deoplete#enable_at_startup = 1
" Use smartcase
let g:deoplete#enable_smart_case = 1
let g:neosnippet#enable_completed_snippet = 1
set completeopt-=preview

" LanguageClient-neovim
" https://github.com/autozimu/LanguageClient-neovim
set hidden
let g:LanguageClient_autoStart = 1
" Minimal LSP configuration
let g:LanguageClient_serverCommands = {}


" Denite
" if has('nvim')
"   call denite#custom#var('file_rec', 'command',
"       \ ['rg', '--files', '--glob', '!.git'])
"   call denite#custom#var('grep', 'command', ['rg'])
"   call denite#custom#var('grep', 'default_opts',
"       \ ['--vimgrep', '--no-heading'])
"   call denite#custom#var('grep', 'recursive_opts', [])
"   call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
"   call denite#custom#var('grep', 'separator', ['--'])
"   call denite#custom#var('grep', 'final_opts', [])
" endif


" To ensure that this plugin works well with Tim Pope's fugitive, use the
" following patterns array:
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
let g:EditorConfig_exec_path = '/usr/local/bin/editorconfig'


" Vim-jsx
let g:jsx_ext_required = 0

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
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
let g:rg_cmd ='rg --column --line-number --no-heading --fixed-strings
  \ --ignore-case --color "always" --no-ignore --hidden --follow
  \ --glob "!.git/*" '
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(g:rg_cmd .shellescape(<q-args>), 1,
  \ <bang>0 ? fzf#vim#with_preview('up:60%')
  \         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \ <bang>0)
let g:fzf_layout = { 'down': '~40%' }

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
" Disable while zoomed
let g:tmux_navigator_no_mappings=1


" -----------------------------------------------
" Tig
" -----------------------------------------------
if has('nvim')
  if !exists('g:tig_executable')
    let g:tig_executable = 'tig'
  endif

  if !exists('g:tig_default_command')
    let g:tig_default_command = 'status'
  endif

  if !exists('g:tig_on_exit')
    let g:tig_on_exit = 'bw!'
  endif

  if !exists('g:tig_open_command')
    let g:tig_open_command = 'enew'
  endif

  function! s:tig(bang, ...)
    let s:callback = {}
    let current = expand('%')

    function! s:callback.on_exit(id, status, event)
      exec g:tig_on_exit
    endfunction

    function! s:tigopen(arg)
      call termopen(g:tig_executable . ' ' . a:arg, s:callback)
    endfunction

    exec g:tig_open_command
    if a:bang > 0
      call s:tigopen(current)
    elseif a:0 > 0
      call s:tigopen(a:1)
    else
      call s:tigopen(g:tig_default_command)
    endif
    startinsert
  endfunction

  command! -bang -nargs=? Tig call s:tig(<bang>0, <f-args>)
endif

" -----------------------------------------------
" Key Mapping
" -----------------------------------------------

" Set mapleader
let mapleader = ","
let g:mapleader = ","

" Explorer Mapping
nnoremap <C-e> :NERDTreeToggle<CR>
nnoremap <C-p> :Files<CR>

" Undotree
nnoremap <leader>ut :UndotreeToggle<CR>

" Tig
nnoremap <silent> <Leader>gs :Tig<CR>

" Use ctrl-[hjkl] to select the active split!
nnoremap <silent> <c-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <c-j> :TmuxNavigateDown<CR>
nnoremap <silent> <c-k> :TmuxNavigateUp<CR>
nnoremap <silent> <c-l> :TmuxNavigateRight<CR>

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

" yank until EOL (y$) instead of the entire line (yy)
nnoremap Y y$

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

" Vimux
map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vl :VimuxRunLastCommand<CR>

" LanguageClient-neovim
nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
nnoremap <silent> <leader>f :call LanguageClient_textDocument_documentSymbol()<CR>
