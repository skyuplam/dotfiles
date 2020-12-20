" vim: set foldmethod=marker foldlevel=0 nomodeline:
scriptencoding utf-8

lua require('init')

" ============================================================================
" Sourcing {{{
" ============================================================================

if filereadable(expand('$XDG_CONFIG_HOME/nvim/osc52.vim'))
  exec 'source $XDG_CONFIG_HOME/nvim/osc52.vim'
endif

" Use fzf from nixpkgs
set runtimepath^=$HOME/.nix-profile/share/vim-plugins/fzf/

" }}}
" ============================================================================
" BASIC SETTINGS {{{
" ============================================================================
set termguicolors

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
set directory^=$XDG_CONFIG_HOME/nvim/swap//

" protect against crash-during-write
set writebackup
" but do not persist backup after successful write
set nobackup
" use rename-and-write-new method whenever safe
set backupcopy=auto
" consolidate the writebackups -- not a big
" deal either way, since they usually get deleted
set backupdir^=$XDG_CONFIG_HOME/nvim/backup//

" persist the undo tree for each file
set undofile
set undodir^=$XDG_CONFIG_HOME/nvim/undo//

set ignorecase                            " Case insensitive search
set smartcase                             " Smart Case search
set gdefault

set whichwrap=b,s,<,>,[,]
set scrolljump=5
set scrolloff=3

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

" Complete
"set complete+=i,t

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  autocmd InsertLeave,WinEnter * set cursorline
  autocmd InsertEnter,WinLeave * set nocursorline

augroup END

" }}}
" ============================================================================
" KEY MAPPINGS {{{
" ============================================================================

" Set mapleader
let mapleader = ','
let g:mapleader = ','

" Explorer Mapping
nnoremap <C-e> :NERDTreeToggle<CR>
nnoremap <C-p> :Files<CR>
nnoremap <silent> <space>t :TagbarToggle<CR>

" Terminal
nnoremap <leader>nt :bo 15sp +term<CR>

" Git mapping
nnoremap <silent> <Leader>gs :TigStatus<CR>

" CamelCaseMotion
let g:camelcasemotion_key = '<leader>'

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

" vim-slash https://github.com/junegunn/vim-slash
" Places the current match at the center of the window
noremap <plug>(slash-after) zz

" Select the text in visual mode then `y` to copy them to clipboard
vmap y y:call SendViaOSC52(getreg('"'))<CR>

" Vim
nnoremap <Leader>ev :tabe $MYINITVIM<CR>
nnoremap <Leader>rv :source $MYINITVIM<CR>

" Scrolling sync
nnoremap <silent> <F9> :set scb!<CR>

" vim-test
nmap <silent> <leader>tt :TestNearest<CR>
nmap <silent> <leader>tT :TestFile<CR>
nmap <silent> <leader>ta :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tg :TestVisit<CR>

" Change the current working directory to the filepath of current buffer
nnoremap <leader>cd :cd %:p:h<CR>

" Map common terminal mappings
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-d> <Delete>

cnoremap <M-f> <S-Right>
cnoremap <M-b> <S-Left>

" OSX specific
cnoremap ƒ <S-Right>
cnoremap ∫ <S-Left>

" Quickfix list navigation
nmap ]q :cnext<CR>
nmap ]Q :clast<CR>
nmap [q :cprev<CR>
nmap [Q :cfirst<CR>

" Location list navigation
nmap ]l :lnext<CR>
nmap ]L :lfirst<CR>
nmap [l :lprev<CR>
nmap [L :llast<CR>

" Diff and merge tool
" +-----------+------------+------------+
" |           |            |            |
" |           |            |            |
" |   LOCAL   |    BASE    |   REMOTE   |
" +-----------+------------+------------+
" |                                     |
" |                                     |
" |             (edit me)               |
" +-------------------------------------+
" shortcuts for 3-way merge
map <Leader>1 :diffget LOCAL<CR>
map <Leader>2 :diffget BASE<CR>
map <Leader>3 :diffget REMOTE<CR>

" FZF completion mappings
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <expr> <c-x><c-f> fzf#vim#complete#path('fd')
imap <c-x><c-l> <plug>(fzf-complete-line)

nmap <silent> <leader>z <Plug>(zoom)

" ----------------------------------------------------------------------------
" Notes
" ----------------------------------------------------------------------------
command! -nargs=* Zet call local#zettel#edit(<f-args>)
" New note
nmap <expr><leader>nz ':Zet '
" Search note file names
nmap <expr><leader>nf ':Files ' . expand(g:zettel_note_dir). '<CR>'
" Rg note contents with fzf
command! -nargs=* -bang ZG call local#zettel#RgFzfZettel(<q-args>, <bang>0)
nmap <expr><leader>ng ':ZG '
" note tag completion with fzf
inoremap <expr> <c-x><c-z> fzf#vim#complete('rg tags $NOTES_DIR \| teip -og "\".\w+\",*" -v -- sed "s/.*//g" \| tr , "\n" \| sort -u')

" }}}
" ============================================================================
" SOURCE LOCAL SETTINGS {{{
" ============================================================================
if filereadable(expand('$XDG_CONFIG_HOME/nvim/local.vim'))
  exec 'source $XDG_CONFIG_HOME/nvim/local.vim'
endif

" }}}
