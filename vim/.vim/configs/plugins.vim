" vim-plug

" -----------------------------------------------
" Plugins loading for Vim Plug
" -----------------------------------------------

" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

" A tree explorer plugin for vim. https://github.com/scrooloose/nerdtree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'jistr/vim-nerdtree-tabs'

" Search
Plug 'mileszs/ack.vim'

" Active fork of kien/ctrlp.vim—Fuzzy file, buffer, mru, tag, etc finder
" http://ctrlpvim.github.com/ctrlp.vim
Plug 'ctrlpvim/ctrlp.vim'
Plug 'dyng/ctrlsf.vim'


" surround.vim: quoting/parenthesizing made simple
" http://www.vim.org/scripts/script.php?script_id=1697
Plug 'tpope/vim-surround'

" Comment functions so powerful—no comment necessary.
" https://github.com/scrooloose/nerdcommenter
Plug 'scrooloose/nerdcommenter'

Plug 'ludovicchabant/vim-gutentags'

" Tagbar
Plug 'majutsushi/tagbar'


Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'

" tern for vim for javascript
" Plug 'ternjs/tern_for_vim'


" YCM
" Plug 'Valloric/YouCompleteMe'
" Asynchronous keyword completion 
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" deoplete.nvim source for javascript
Plug 'carlitux/deoplete-ternjs'

Plug 'ervandew/supertab'

" vim Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

Plug 'Raimondi/delimitMate'

" Plug 'vim-syntastic/syntastic'
" Use Neomake instead of syntasitic
Plug 'neomake/neomake'

" Plug 'Yggdroot/indentLine'
" Plug 'nathanaelkane/vim-indent-guides'

Plug 'editorconfig/editorconfig-vim'

Plug 'tpope/vim-fugitive'

" A Vim plugin which shows a git diff in the gutter (sign column) and stages/undoes hunks.
Plug 'airblade/vim-gitgutter'

Plug 'tpope/vim-git'

Plug 'easymotion/vim-easymotion'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

" Vim bundle for styled-components based javascript files.
Plug 'fleischie/vim-styled-components'

Plug 'terryma/vim-multiple-cursors'

Plug 'tpope/vim-unimpaired'

Plug 'jeetsukumaran/vim-buffergator'

Plug 'ntpeters/vim-better-whitespace'

Plug 'python-mode/python-mode'

Plug 'tpope/vim-repeat'

Plug 'mattn/emmet-vim'

Plug 'mhinz/vim-startify'

Plug 'tmhedberg/matchit'

" Monokai color scheme for Vim converted from Textmate theme
Plug 'flazz/vim-colorschemes'
" Plug 'tomasr/molokai'
Plug 'ryanoasis/vim-devicons'

" Add plugins to &runtimepath
call plug#end()

