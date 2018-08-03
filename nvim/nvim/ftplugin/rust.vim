" Check Rust files with rls
let b:ale_linters = ['rls', 'cargo']
" Fix Python files with autopep8 and yapf.
let b:ale_fixers = ['rustfmt']

" LanguageServer-neovim
if executable('rls')
  let b:LanguageClient_serverCommands.rust = ['rls']
  setlocal omnifunc=LanguageClient#complete
endif

" Automatically detect and enable deoplete-rust
if !b:deoplete#sources#rust#racer_binary && executable('racer')
  let b:deoplete#sources#rust#racer_binary = systemlist('which racer')[0]
endif
" let g:deoplete#sources#rust#rust_source_path = '$HOME/dev/oss/rust/src'
if !b:deoplete#sources#rust#rust_source_path && executable('rustc')
    " if src installed via rustup, we can get it by running
    " rustc --print sysroot then appending the rest of the path
    let rustc_root = systemlist('rustc --print sysroot')[0]
    let rustc_src_dir = rustc_root . '/lib/rustlib/src/rust/src'
    if isdirectory(rustc_src_dir)
        let b:deoplete#sources#rust#rust_source_path = rustc_src_dir
    endif
endif

" Rust.vim
" let g:rust_clip_command = 'xclip -selection clipboard'

