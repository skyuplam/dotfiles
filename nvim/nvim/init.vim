" vim: set foldmethod=marker foldlevel=0 nomodeline:
scriptencoding utf-8

" ============================================================================
" Minpac https://github.com/k-takata/minpac {{{
" ============================================================================
function! PackInit() abort
  packadd minpac

  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  " Additional plugins here.
  call minpac#add('vim-jp/syntax-vim-ex')
  call minpac#add('tyru/open-browser.vim')
  call minpac#add('preservim/nerdtree')
  call minpac#add('Xuyuanp/nerdtree-git-plugin')

  call minpac#add('Shougo/neco-vim')
  call minpac#add('neoclide/coc-neco')
  call minpac#add('Shougo/neoinclude.vim')
  call minpac#add('jsfaint/coc-neoinclude')
  call minpac#add('neoclide/coc.nvim', {'branch': 'release', 'do': {-> coc#util#install()}})
  call minpac#add('Shougo/vimproc.vim', {'do' : 'silent! !make'})
  call minpac#add('vim-scripts/vis')
  call minpac#add('sheerun/vim-polyglot')
  call minpac#add('editorconfig/editorconfig-vim')

  call minpac#add('mbbill/undotree')

  call minpac#add('airblade/vim-gitgutter')
  call minpac#add('mhinz/vim-signify')
  call minpac#add('tpope/vim-git')
  call minpac#add('tpope/vim-fugitive')
  call minpac#add('tpope/vim-rhubarb')
  call minpac#add('tpope/vim-sleuth')

  call minpac#add('godlygeek/tabular')

  call minpac#add('christoomey/vim-tmux-navigator')
  call minpac#add('wellle/tmux-complete.vim')

  call minpac#add('SirVer/ultisnips')

  call minpac#add('iberianpig/tig-explorer.vim')
  call minpac#add('rbgrouleff/bclose.vim')

  " A vim script to provide CamelCase motion through words (fork of inkarkat's
  " camelcasemotion script)
  call minpac#add('bkad/CamelCaseMotion')

  call minpac#add('tpope/vim-surround')
  call minpac#add('tpope/vim-repeat')
  " call minpac#add('junegunn/fzf', { 'do': {-> fzf#install()} })
  call minpac#add('junegunn/fzf.vim')
  call minpac#add('ryanoasis/vim-devicons')
  call minpac#add('norcalli/nvim-colorizer.lua')

  call minpac#add('junegunn/vim-slash')
  call minpac#add('junegunn/gv.vim')
  call minpac#add('junegunn/vim-peekaboo')

  call minpac#add('gruvbox-community/gruvbox' , { 'type': 'opt' })

  call minpac#add('plasticboy/vim-markdown')
  call minpac#add('mzlogin/vim-markdown-toc')
  call minpac#add('iamcco/markdown-preview.nvim', {'do': {-> mkdp#util#install()} })

  call minpac#add('vim-scripts/utl.vim')
  call minpac#add('majutsushi/tagbar')
  call minpac#add('janko/vim-test')
  call minpac#add('tpope/vim-speeddating')
  call minpac#add('chrisbra/NrrwRgn')
  call minpac#add('mattn/calendar-vim')
  call minpac#add('inkarkat/vim-SyntaxRange')
endfunction
" }}}
" ============================================================================
" Sourcing {{{
" ============================================================================

exec 'source ~/.config/nvim/osc52.vim'

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
" patch required to honor double slash at end
if has('patch-8.1.0251')
  " consolidate the writebackups -- not a big
  " deal either way, since they usually get deleted
  set backupdir^=$XDG_CONFIG_HOME/backup//
end

" persist the undo tree for each file
set undofile
set undodir^=$XDG_CONFIG_HOME/undo//

set ignorecase                            " Case insensitive search
set smartcase                             " Smart Case search
set gdefault

set whichwrap=b,s,<,>,[,]
set scrolljump=5
set scrolloff=3

set synmaxcol=200

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
set complete+=i,t

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

" vim-slash
" Places the current match at the center of the window
noremap <plug>(slash-after) zz

" Select the text in visual mode then `y` to copy them to clipboard
vmap y y:call SendViaOSC52(getreg('"'))<CR>

" Terminal keybinding
" To map <Esc> to exit terminal-mode
" tnoremap <Esc> <C-\><C-N>

" Vim
nnoremap <Leader>ev :tabe $MYINITVIM<CR>
nnoremap <Leader>rv :source $MYINITVIM<CR>

" coc.nvim
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD <Plug>(coc-declaration)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gS :call CocAction('jumpDefinition', 'split')<CR>
nmap <silent> gV :call CocAction('jumpDefinition', 'vsplit')<CR>
" nnoremap <silent> <leader>r :call CocAction('runCommand')<CR>

" Remap for format selected region
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

" Remap for do codeAction of selected region
xmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)
" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Use K for show documentation in preview window
nmap <silent> K <Plug>(show-doc)

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" Use `complete_info` if your (Neo)Vim version supports it.
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Scrolling sync
nnoremap <silent> <F9> :set scb!<CR>

" vim-test
" these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
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

" Minpac mappings
command! PackUpdate call PackInit() | call minpac#update()
command! PackClean  call PackInit() | call minpac#clean()
command! PackStatus call PackInit() | call minpac#status()

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
if filereadable(expand('~/.config/nvim/local.vim'))
  exec 'source ~/.config/nvim/local.vim'
endif

" }}}
