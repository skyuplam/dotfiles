" vim: set foldmethod=marker foldlevel=0 nomodeline:
" }}}
" ============================================================================
" BASIC SETTINGS {{{
" ============================================================================
" if hidden is not set, TextEdit might fail.
set hidden

set encoding=utf-8
scriptencoding utf-8

" Mouse
set mouse=a
set mousehide

set showmatch
set title

" Better display for messages
set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=number

if exists('$SUDO_USER')
  set noswapfile                      " don't create root-owned files
else
  " Protect changes between writes. Default values of
  " updatecount (200 keystrokes) and updatetime
  " (4 seconds) are fine
  set swapfile
  set directory^=$XDG_DATA_HOME/nvim/swap//
endif

if exists('$SUDO_USER')
  set nobackup                        " don't create root-owned files
  set nowritebackup                   " don't create root-owned files
else
  " protect against crash-during-write
  set writebackup
  " but do not persist backup after successful write
  set nobackup
  " use rename-and-write-new method whenever safe
  set backupcopy=auto
  " consolidate the writebackups -- not a big
  " deal either way, since they usually get deleted
  set backupdir^=$XDG_DATA_HOME/nvim/backup
endif

if exists('$SUDO_USER')
  set noundofile                    " don't create root-owned files
else
  " persist the undo tree for each file
  set undofile
  set undodir^=$XDG_DATA_HOME/nvim/undo
endif

if exists('$SUDO_USER')               " don't create root-owned files
  set shada=
else
  " default in nvim: !,'100,<50,s10,h
  set shada=!,'100,<500,:10000,/10000,s10,h
  augroup MyNeovimShada
    autocmd!
    autocmd CursorHold,FocusGained,FocusLost * rshada|wshada
  augroup END
endif

set inccommand=nosplit                " incremental command live feedback"

set ignorecase                            " Case insensitive search
set smartcase                             " Smart Case search
set gdefault

set whichwrap=b,s,<,>,[,]
set scrolljump=5
set scrolloff=3

set formatoptions+=j
set formatoptions+=n
set formatoptions+=r1

syntax sync minlines=256              " start highlighting from 256 lines backwards
set synmaxcol=300                     " do not highlight very long lines

set noshowmode                        " Don't Display the mode you're in. since it's already shown on the statusline

" "split"	 : Also shows partial off-screen results in a preview window.
" Works for |:substitute|, |:smagic|, |:snomagic|. |hl-Substitute|
set inccommand=split

set list
set listchars=tab:›\ ,trail:•,precedes:«,extends:#,nbsp:. " Highlight problematic whitespace

" clipboard
set clipboard+=unnamedplus

set tabpagemax=15                              " Only show 15 tabs

" set grep to rg
if executable('rg')
  set grepprg=rg\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif

set complete+=kspell
set completeopt=menuone,noselect

" Open splits more naturally
set splitbelow
set splitright

" Tab and Indent
set tabstop=2
set shiftwidth=2
set expandtab
set shiftround
set autoindent
set smartindent

" Use one space, not two, after punctuation
set nojoinspaces

set textwidth=80
set colorcolumn=+1

" Line Number
set relativenumber
set number

" fuzzy path
set path+=**
set wildmenu

" show a navigable menu for tab completion
set wildmode=longest:full,list,full
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem,*.pyc
set wildignore+=*.swp,*~,*/.DS_Store
set tagcase=followscs
set tags^=./.git/tags;

set pumblend=10
set pumheight=50

set spellcapcheck=                            " don't check for capital letters at start of sentence
" Prevent CJK characters from being marked as spell errors
" https://neovim.io/doc/user/options.html#'spelllang'
set spelllang=en,nb,cjk
" Show nine spell checking candidates at most
set spellsuggest=best,9
let &spellfile=stdpath("config").'/spell/en.utf-8.add'


set virtualedit=block

" Diffs
set diffopt+=vertical
set diffopt+=internal,algorithm:patience
set diffopt+=indent-heuristic

" Highlight git commit merge conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" }}}
