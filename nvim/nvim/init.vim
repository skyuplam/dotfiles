scriptencoding utf-8
" vim: set foldmethod=marker foldlevel=0 nomodeline:

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
  call minpac#add('scrooloose/nerdtree')
  call minpac#add('Xuyuanp/nerdtree-git-plugin')

  call minpac#add('Shougo/neco-vim')
  call minpac#add('neoclide/coc-neco')
  call minpac#add('Shougo/neoinclude.vim')
  call minpac#add('jsfaint/coc-neoinclude')
  call minpac#add('neoclide/coc.nvim', {'branch': 'release'})
  call minpac#add('Shougo/vimproc.vim', {'do' : 'silent! !make'})
  call minpac#add('dense-analysis/ale')
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
  call minpac#add('junegunn/fzf', { 'do': {-> fzf#install()} })
  call minpac#add('junegunn/fzf.vim')
  call minpac#add('ryanoasis/vim-devicons')
  call minpac#add('chrisbra/Colorizer')

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
  \ 'coc-vimlsp',
  \]

" coc-prettier:: Enable command :Prettier to format current buffer
" command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')
" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

function! OnTabEnter(path)
  if isdirectory(a:path)
    let dirname = a:path
  else
    let dirname = fnamemodify(a:path, ':h')
  endif
  execute 'tcd '. dirname
endfunction

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Mail
  autocmd BufRead,BufNewFile *mutt-*              setfiletype mail

  autocmd User CocStatusChange,CocGitStatusChange call local#statusline#RefreshStatusline()
  autocmd User CocDiagnosticChange call local#statusline#RefreshStatusline()

  autocmd InsertLeave,WinEnter * set cursorline
  autocmd InsertEnter,WinLeave * set nocursorline

  " Change working directory on tab change
  autocmd TabNewEntered * call OnTabEnter(expand("<amatch>"))

  " FZF Hide statusline
  autocmd! FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END

" }}}
" ============================================================================
" PLUGIN SETTINGS {{{
" ============================================================================

" Gruvbox
" set background=dark
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_bold=1
let g:gruvbox_italic=1
let g:gruvbox_italicize_comments=1
colorscheme gruvbox

augroup gruvbox
  autocmd!
  " Override gruvbox for Transparet BG color
  autocmd ColorScheme * :hi ColorColumn ctermbg=Gray guibg=#504945
  autocmd ColorScheme * :hi NonText ctermfg=12 gui=bold guifg=#7c6f64
  autocmd ColorScheme * :hi! Normal ctermbg=NONE guibg=NONE
  autocmd ColorScheme * :hi! NonText ctermbg=NONE guibg=NONE
augroup END


" function! s:overrideColorscheme()
"   " Highlight overriding
"   " Gruvbox Dark mode palette
"   " bg2=#504945
"   " bg3=#665c54
"   " bg4=#7c6f64
"   hi ColorColumn ctermbg=Gray guibg=#504945
"   hi NonText ctermfg=12 gui=bold guifg=#7c6f64
"   " hi Comment cterm=italic
" 
" endfunction

" vim-test
let test#strategy = 'neovim'
let test#neovim#term_position = 'vert'

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

" ----------------------------------------------------------------------------
" FZF Config
" ----------------------------------------------------------------------------

let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
let $FZF_DEFAULT_OPTS .= ' --inline-info'

" Fzf actions
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit',
  \ 'ctrl-y': {lines -> setreg('*', split(join(lines, "\n"), ":")[0])}}

" All files
command! -nargs=? -complete=dir AF
  \ call fzf#run(fzf#wrap(fzf#vim#with_preview({
  \   'source': 'fd --type f --hidden --follow --exclude .git --no-ignore . '.expand(<q-args>)
  \ })))

" Interactive mode of Rg
function! RipgrepFzf(query, fullscreen)
  let spec = {}
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec.options = ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]

  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors =
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

" ----------------------------------------------------------------------------
" vim-markdown
" ----------------------------------------------------------------------------
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_conceal = 2
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_math = 1
let g:vim_markdown_follow_anchor = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_fenced_languages = [
      \ 'viml=vim', 'javascript', 'typescript', 'rust', 'bash=sh', 'zsh']
" Syntax
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
" let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_strikethrough = 1

" ----------------------------------------------------------------------------
" UltiSnips
" ----------------------------------------------------------------------------
let g:UltiSnipsSnippetDirectories=['UltiSnips', 'ftsnippets']
" Trigger configuration.
let g:UltiSnipsExpandTrigger='<tab>'
" shortcut to go to next position
let g:UltiSnipsJumpForwardTrigger='<c-j>'
" shortcut to go to previous position
let g:UltiSnipsJumpBackwardTrigger='<c-k>'

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

" shortcuts for 3-way merge
" map <Leader>1 :diffget LOCAL<CR>
" map <Leader>2 :diffget BASE<CR>
" map <Leader>3 :diffget REMOTE<CR>

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
augroup cocGroup
  autocmd CursorHold * silent call CocActionAsync('highlight')
  autocmd CursorHold * silent call CocActionAsync('getCurrentFunctionSymbol')
augroup end
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

" coc-git mapping
" navigate chunks of current buffer
" nmap [c <Plug>(coc-git-prevchunk)
" nmap ]c <Plug>(coc-git-nextchunk)

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
command! PackUpdate call PackInit() | call minpac#update('', {'do': 'call minpac#status()'})
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

" ----------------------------------------------------------------------------
" Notes
" ----------------------------------------------------------------------------
command! -nargs=* Zet call local#zettel#edit(<f-args>)
" New note
nmap <expr><leader>nz ':Zet '
" Search note file names
nmap <expr><leader>nf ':Files ' . expand(g:zettel_note_dir). '<CR>'
" Rg note contents with fzf
function! RgFzfZettel(query, fullscreen)
  let spec = {}
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec.options = ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]
  let spec.dir = expand(g:zettel_note_dir)

  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(fzf#wrap(spec)), a:fullscreen)
endfunction
command! -nargs=* -bang ZG call RgFzfZettel(<q-args>, <bang>0)
nmap <expr><leader>ng ':ZG '
" note tag completion with fzf
inoremap <expr> <c-x><c-z> fzf#vim#complete('rg tags $NOTES_DIR \| teip -og "\".\w+\",*" -v -- sed "s/.*//g" \| tr , "\n" \| sort \| uniq')

" }}}
" ============================================================================
" SOURCE LOCAL SETTINGS {{{
" ============================================================================
if filereadable(expand('~/.config/nvim/local.vim'))
  exec 'source ~/.config/nvim/local.vim'
endif

" }}}
