" vim: set foldmethod=marker foldlevel=0 nomodeline:
" }}}
" ============================================================================
" BASIC SETTINGS {{{
" ============================================================================
" if hidden is not set, TextEdit might fail.
set hidden

" Mouse
set mouse=a
set mousehide

" Better display for messages
set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=number

" Protect changes between writes. Default values of
" updatecount (200 keystrokes) and updatetime
" (4 seconds) are fine
set swapfile
set directory^=$XDG_DATA_HOME/nvim/swap//

" protect against crash-during-write
set writebackup
" but do not persist backup after successful write
set nobackup
" use rename-and-write-new method whenever safe
set backupcopy=auto
" consolidate the writebackups -- not a big
" deal either way, since they usually get deleted
set backupdir^=$XDG_DATA_HOME/nvim/backup

" persist the undo tree for each file
set undofile
set undodir^=$XDG_DATA_HOME/nvim/undo

set ignorecase                            " Case insensitive search
set smartcase                             " Smart Case search
set gdefault

set whichwrap=b,s,<,>,[,]
set scrolljump=5
set scrolloff=3

set formatoptions+=1
set formatoptions+=j

set synmaxcol=300

" "split"	 : Also shows partial off-screen results in a preview window.
" Works for |:substitute|, |:smagic|, |:snomagic|. |hl-Substitute|
set inccommand=split

set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

" clipboard
set clipboard+=unnamedplus

set tabpagemax=15                              " Only show 15 tabs

" set grep to rg
set grepprg=rg\ --vimgrep
set grepformat=%f:%l:%c:%m

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

" Diffs
set diffopt+=vertical
set diffopt+=internal,algorithm:patience
set diffopt+=indent-heuristic

" Highlight git commit merge conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" }}}
