
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
set synmaxcol=1000              " Don't syntax highlight long lines
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,sql
" set shell=/bin/zsh
set gdefault        " Add the `g` flag to search/replace by default

set tabpagemax=15  " Only show 15 tabs
set showmode  " Display the current mode
set cursorline  " Highlight the current line

" Open splits more naturally
set splitbelow
set splitright


if has('clipboard')
    if has('unnamedplus')  " When possible use + register for copy-paste
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
set smarttab
set autoindent

" Enable spell check for commit messages
autocmd FileType gitcommit setlocal spell
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

set laststatus=2  " appear all the time

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
set completeopt-=preview

" Autocompolete with dictoinary words when spell check is on
set complete+=kspell

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
" Use 256 colors
" set t_Co=256

" Nvim specific config
if has('nvim')
  " Program to use for evaluating Python code. Setting this makes startup faster.
  " Also useful for working with virtualenvs.
  let g:python_host_prog  = '/usr/local/bin/python'
  let g:python3_host_prog  = '/usr/local/bin/python3'
endif
