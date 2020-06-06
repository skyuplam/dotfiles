" vim: set foldmethod=marker foldlevel=0 nomodeline:

" ============================================================================
" VIM-PLUG BLOCK {{{
" ============================================================================
call plug#begin('~/.local/share/nvim/plugged')
  Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
  Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }

  Plug 'Shougo/neco-vim'
  Plug 'neoclide/coc-neco'
  Plug 'Shougo/neoinclude.vim'
  Plug 'jsfaint/coc-neoinclude'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'Shougo/vimproc.vim', {'do' : 'make'}
  Plug 'dense-analysis/ale'
  Plug 'vim-scripts/vis'
  Plug 'sheerun/vim-polyglot'
  Plug 'editorconfig/editorconfig-vim'

  Plug 'airblade/vim-gitgutter'
  Plug 'mhinz/vim-signify'
  Plug 'tpope/vim-git'
  Plug 'tpope/vim-fugitive'

  Plug 'godlygeek/tabular'

  Plug 'christoomey/vim-tmux-navigator'
  Plug 'wellle/tmux-complete.vim'

  Plug 'iberianpig/tig-explorer.vim'
  Plug 'rbgrouleff/bclose.vim'

  " A vim script to provide CamelCase motion through words (fork of inkarkat's
  " camelcasemotion script)
  Plug 'bkad/CamelCaseMotion'

  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
  Plug 'lotabout/skim.vim'
  Plug 'ryanoasis/vim-devicons'
  Plug 'chrisbra/Colorizer'

  Plug 'junegunn/vim-slash'

  Plug 'morhetz/gruvbox'

  Plug 'vim-scripts/utl.vim'
  " Plug 'vim-scripts/taglist.vim'
  Plug 'majutsushi/tagbar'
  Plug 'janko/vim-test'
  " Plug 'ludovicchabant/vim-gutentags'
  Plug 'tpope/vim-speeddating'
  Plug 'chrisbra/NrrwRgn'
  Plug 'mattn/calendar-vim'
  Plug 'inkarkat/vim-SyntaxRange'
call plug#end()

" }}}
" ============================================================================
" Sourcing {{{
" ============================================================================

exec 'source ~/.config/nvim/osc52.vim'

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
" always show signcolumns
"set signcolumn=yes

" Backup and swap
set nobackup
set nowritebackup
set noswapfile

" set guifont=mononoki_Nerd_Font:h12,FantasqueSansMono_Nerd_Font:h12

set ignorecase                            " Case insensitive search
set smartcase                             " Smart Case search
set gdefault

set whichwrap=b,s,<,>,[,]
set scrolljump=5
set scrolloff=3

set synmaxcol=200

set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

" clipboard
set clipboard+=unnamedplus

set tabpagemax=15                              " Only show 15 tabs

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

" Always use vertical diffs
set diffopt+=vertical

" Statusline
set laststatus=2  " appear all the time

" Complete
set complete+=i,t

" ALE statusline
" function! LinterStatus() abort
"   let l:counts = ale#statusline#Count(bufnr(''))
"
"   let l:all_errors = l:counts.error + l:counts.style_error
"   let l:all_non_errors = l:counts.total - l:all_errors
"
"   return l:counts.total == 0 ? '' : printf(
"   \   '[%d⚠ %d✖]',
"   \   all_non_errors,
"   \   all_errors
"   \)
" endfunction

" coc & ale statusline
function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  let l:counts = ale#statusline#Count(bufnr(''))

  if empty(info) && l:counts.total == 0 | return '' | endif

  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  let msgs = []
  let errors = get(info, 'error', 0) + l:all_errors
  let warnings = get(info, 'warning', 0) + l:all_non_errors

  if errors
    call add(msgs, errors . '✖')
  endif
  if warnings
    call add(msgs, warnings . '⚠')
  endif
  let msgFmt = empty(msgs) ? '' : '[' . join(msgs, ' '). '] '
  return msgFmt . get(g:, 'coc_status', '')
endfunction

function! s:statusline_expr()
  let mod = "%{&modified ? '[+] ' : !&modifiable ? '[x] ' : ''}"
  let ro  = "%{&readonly ? '[RO] ' : ''}"
  let ft  = "%{len(&filetype) ? '['.&filetype.'] ' : ''}"
  " let fug = "%{exists('g:loaded_fugitive') ? fugitive#statusline() : ''}"
  let sep = ' %= '
  let pos = ' %-12(%l : %c%V%) '
  let pct = ' %P'
  " let ale = "%{len(LinterStatus()) ? LinterStatus() : ''}"
  let coc = "%{StatusDiagnostic()}"
  let coc_git = "%{get(g:,'coc_git_status','')}%{get(b:,'coc_git_status','')}%{get(b:,'coc_git_blame','')}"

  return coc.'[%n] %f %<'.mod.ro.ft.coc_git.sep.pos.'%*'.pct
endfunction

let &statusline = s:statusline_expr()

function! s:refresh()
  let &statusline = s:statusline_expr()
endfunction

" coc extensions
let g:coc_global_extensions = [
  \ 'coc-dictionary', 'coc-word', 'coc-actions',
  \ 'coc-lists', 'coc-tag', 'coc-syntax', 'coc-highlight',
  \ 'coc-tsserver', 'coc-jest', 'coc-eslint',
  \ 'coc-svg', 'coc-html',
  \ 'coc-css', 'coc-stylelint', 'coc-cssmodules',
  \ 'coc-json',
  \ 'coc-yaml',
  \ 'coc-prettier',
  \ 'coc-rust-analyzer',
  \ 'coc-git',
  \ 'coc-markdownlint', 'coc-spell-checker',
  \]

" coc-prettier:: Enable command :Prettier to format current buffer
" command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')
" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Correct comment highlight for JSON filetype
  autocmd FileType json syntax match Comment +\/\/.\+$+
  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile .{jscs,jshint,eslint,babel}rc set filetype=json
  autocmd BufRead,BufNewFile {Dockerfile,*.docker} set filetype=dockerfile
  " Mail
  autocmd BufRead,BufNewFile *mutt-*              setfiletype mail

  autocmd User CocStatusChange,CocGitStatusChange call s:refresh()
  autocmd User CocDiagnosticChange call s:refresh()

  autocmd InsertLeave,WinEnter * set cursorline
  autocmd InsertEnter,WinLeave * set nocursorline
augroup END

" }}}
" ============================================================================
" PLUGIN SETTINGS {{{
" ============================================================================

" Gruvbox
set background=dark
let g:gruvbox_contrast_dark="hard"
let g:gruvbox_bold=1
let g:gruvbox_italic=1
let g:gruvbox_italicize_comments=1
colorscheme gruvbox
" Highlight overriding
" Gruvbox Dark mode palette
" bg2=#504945
" bg3=#665c54
" bg4=#7c6f64
hi ColorColumn ctermbg=Gray guibg=#504945
hi NonText ctermfg=12 gui=bold guifg=#7c6f64
" hi Comment cterm=italic

" Transparet BG color
hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE

" vim-test
let test#strategy = "neovim"
let test#neovim#term_position = "vert"

"let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
let $SKIM_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
let g:fzf_layout = { 'down': '~40%' }
" Customize fzf colors to match your color scheme
let g:skim_colors =
  \ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

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

" ALE
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
" custom echos message
let g:ale_echo_msg_error_str = '✖'
let g:ale_echo_msg_warning_str = '⚠'
let g:ale_echo_msg_format = '[%linter%][%severity%]%[code]: %%s'

" Editorconfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
let g:EditorConfig_disable_rules = ['indent_size', 'tab_width']

" }}}
" ============================================================================
" KEY MAPPINGS {{{
" ============================================================================

" Set mapleader
let mapleader = ","
let g:mapleader = ","

" Explorer Mapping
nnoremap <C-e> :NERDTreeToggle<CR>
nnoremap <C-p> :Files<CR>

" Tagbar
nnoremap <leader>b :TagbarToggle<CR>
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

" Switch between the last two files
nnoremap <leader><leader> <c-^>

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

" Zoom view
function! s:zoom()
  if winnr('$') > 1
    tab split
  elseif len(filter(map(range(tabpagenr('$')), 'tabpagebuflist(v:val + 1)'),
                  \ 'index(v:val, '.bufnr('').') >= 0')) > 1
    tabclose
  endif
endfunction
nnoremap <silent> <leader>z :call <sid>zoom()<cr>

" vim-slash
" Places the current match at the center of the window
noremap <plug>(slash-after) zz

" Enable clipboard
noremap <silent> <F8> :set clipboard+=unnamedplus<CR>

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
nnoremap <silent> <leader>r :call CocAction('runCommand')<CR>

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

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end


" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')
autocmd CursorHold * silent call CocActionAsync("getCurrentFunctionSymbol")
" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" use <tab> for trigger completion and navigate to next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
" inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Note: \<C-g>u is used to break undo level.
" To make <cr> select the first completion item and confirm completion when no item have selected:
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
" Close preview window when completion is done.
" autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" coc-git mapping
" navigate chunks of current buffer
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)

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

" Saner command-line history
cnoremap <c-n> <down>
cnoremap <c-p> <up>

" }}}
" ============================================================================
" SOURCE LOCAL SETTINGS {{{
" ============================================================================
if filereadable(expand('~/.config/nvim/local.vim'))
  exec 'source ~/.config/nvim/local.vim'
endif

" }}}
