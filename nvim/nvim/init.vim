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
  Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
  Plug 'Shougo/vimproc.vim', {'do' : 'make'}
  Plug 'w0rp/ale'
  " Plug 'wellle/tmux-complete.vim'

  Plug 'airblade/vim-gitgutter'
  Plug 'mhinz/vim-signify'
  Plug 'tpope/vim-git'

  Plug 'godlygeek/tabular'
  Plug 'plasticboy/vim-markdown'

  " Plug 'christoomey/vim-tmux-navigator'

  Plug 'rust-lang/rust.vim', { 'for': 'rust' }

  " JS
  Plug 'pangloss/vim-javascript', { 'for': [
        \ 'javascript', 'javascript.jsx'] }
  Plug 'mxw/vim-jsx', { 'for': ['javascript.jsx'] }
  " Typescript
  Plug 'HerringtonDarkholme/yats.vim', { 'for': [
        \ 'typescript', 'typescript.tsx'] }

  Plug 'elzr/vim-json', { 'for': 'json' }

  " CSS
  Plug 'styled-components/vim-styled-components', {
        \ 'branch': 'main',
        \ 'for': [
        \ 'javascript', 'javascript.jsx', 'typescript', 'typescript.tsx'] }
  Plug 'hail2u/vim-css3-syntax', { 'for': [
        \ 'javascript', 'javascript.jsx', 'typescript', 'typescript.tsx'] }


  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'ryanoasis/vim-devicons'
  Plug 'chrisbra/Colorizer'

  Plug 'junegunn/vim-slash'

  Plug 'junegunn/seoul256.vim'

  " Plug for orgmode and related/suggested plugins
  Plug 'jceb/vim-orgmode'
  Plug 'vim-scripts/utl.vim'
  Plug 'vim-scripts/taglist.vim'
  Plug 'majutsushi/tagbar'
  Plug 'ludovicchabant/vim-gutentags'
  Plug 'tpope/vim-speeddating'
  Plug 'chrisbra/NrrwRgn'
  Plug 'mattn/calendar-vim'
  Plug 'inkarkat/vim-SyntaxRange'
call plug#end()

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
" set cmdheight=2

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

set guifont=Hack\ Nerd\ Font\ Mono:h12,\ FantasqueSansMono\ Nerd\ Font\ Mono:h12

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
function! LinterStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))

  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  return l:counts.total == 0 ? '' : printf(
  \   '[%d⚠ %d✖]',
  \   all_non_errors,
  \   all_errors
  \)
endfunction

" coc statusline
function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif
  return join(msgs, ' '). ' ' . get(g:, 'coc_status', '')
endfunction

function! s:statusline_expr()
  let mod = "%{&modified ? '[+] ' : !&modifiable ? '[x] ' : ''}"
  let ro  = "%{&readonly ? '[RO] ' : ''}"
  let ft  = "%{len(&filetype) ? '['.&filetype.'] ' : ''}"
"  let fug = "%{exists('g:loaded_fugitive') ? fugitive#statusline() : ''}"
  let sep = ' %= '
  let pos = ' %-12(%l : %c%V%) '
  let pct = ' %P'
  let ale = "%{len(LinterStatus()) ? LinterStatus() : ''}"
  let coc = "%{StatusDiagnostic()}"

  return ale.coc.'[%n] %f %<'.mod.ro.ft.sep.pos.'%*'.pct
endfunction

let &statusline = s:statusline_expr()

" coc extensions
let g:coc_global_extensions = [
  \ 'coc-lists', 'coc-omni', 'coc-tag', 'coc-syntax', 'coc-highlight',
  \ 'coc-tsserver', 'coc-tslint-plugin', 'coc-jest', 'coc-eslint',
  \ 'coc-svg', 'coc-html',
  \ 'coc-css', 'coc-stylelint',
  \ 'coc-json',
  \ 'coc-yaml',
  \ 'coc-prettier',
  \ 'coc-rls',
  \ 'coc-python'
  \]

" coc-prettier:: Enable command :Prettier to format current buffer
command! -nargs=0 Prettier :CocCommand prettier.formatFile

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
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile .{jscs,jshint,eslint,babel}rc set filetype=json
  autocmd BufRead,BufNewFile {Dockerfile,*.docker} set filetype=dockerfile
  " Mail
  autocmd BufRead,BufNewFile *mutt-*              setfiletype mail
augroup END

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

" }}}
" ============================================================================
" PLUGIN SETTINGS {{{
" ============================================================================

" Deoplete
" let g:deoplete#enable_at_startup = 1
" deoplete-options
" call deoplete#custom#option({
" \ 'auto_complete_delay': 200,
" \ 'smart_case': v:true,
" \ })
" No trigger needed
" let g:tmuxcomplete#trigger = ''
" set completeopt=menuone

" vim-javascript
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1
" vim-jsx
" let g:jsx_ext_required = 0

" Seoul256
let g:seoul256_background = 233
colo seoul256

" Transparet BG color
hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE

let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
" let g:rg_cmd ='rg --column --line-number --no-heading --fixed-strings
"   \ --ignore-case --color "always" --no-ignore --hidden --follow
"   \ --glob "!.git/*" '
" command! -bang -nargs=* Rg
"   \ call fzf#vim#grep(g:rg_cmd .shellescape(<q-args>), 1,
"   \ <bang>0 ? fzf#vim#with_preview('up:60%')
"   \         : fzf#vim#with_preview('right:50%:hidden', '?'),
"   \ <bang>0)
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

" ALE
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
" custom echos message
let g:ale_echo_msg_error_str = '✖'
let g:ale_echo_msg_warning_str = '⚠'
let g:ale_echo_msg_format = '[%linter%][%severity%]%[code]: %%s'
" let g:ale_completion_enabled = 1

" vim-json
let g:vim_json_syntax_conceal = 0

" vim-markdown
" Disable folding
let g:vim_markdown_folding_disabled = 1
" Disable conceal
let g:vim_markdown_conceal = 0

" vim-orgmode
let g:org_agenda_files = ['~/Dropbox/org/home-tasks.org', '~/Dropbox/org/work-tasks.org']

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
nnoremap <C-t> :Tagbar<CR>

" Terminal
nnoremap <leader>t :bo 15sp +term<CR>

" Tig
nnoremap <silent> <Leader>gs :Tig<CR>

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

" yank until EOL (y$) instead of the entire line (yy)
nnoremap Y y$

" Terminal keybinding
" To map <Esc> to exit terminal-mode
" tnoremap <Esc> <C-\><C-N>

" Vim
nnoremap <Leader>ev :tabe $MYINITVIM<CR>
nnoremap <Leader>rv :source $MYINITVIM<CR>

" coc.nvim
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
vmap <leader> f <Plug>(coc-format-selected)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')
" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)
" use <tab> for trigger completion and navigate to next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
" Use <Tab> and <S-Tab> for navigate completion list:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Use <cr> to confirm complete
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Note: \<C-g>u is used to break undo level.
" To make <cr> select the first completion item and confirm completion when no item have selected:
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
" Close preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Scrolling sync
nnoremap <silent> <F9> :set scb!<CR>

" }}}
" ============================================================================
" SOURCE LOCAL SETTINGS {{{
" ============================================================================
if filereadable(expand('~/.config/nvim/local.vim'))
  exec 'source ~/.config/nvim/local.vim'
endif

" }}}
