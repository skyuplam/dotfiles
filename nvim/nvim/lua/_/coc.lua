local M = {}

function M.setup()
    vim.g.coc_global_extensions = {
        'coc-dictionary', 'coc-word', 'coc-actions', 'coc-lists', 'coc-tag',
        'coc-syntax', 'coc-highlight', 'coc-tsserver', 'coc-jest', 'coc-eslint',
        'coc-svg', 'coc-html', 'coc-css', 'coc-cssmodules', 'coc-json',
        'coc-yaml', 'coc-prettier', 'coc-rust-analyzer', 'coc-git',
        'coc-vimlsp', 'coc-spell-checker', 'coc-markdownlint'
    }

    vim.cmd([[augroup cocAUG]])
    vim.cmd(
        [[autocmd User CocStatusChange,CocGitStatusChange call local#statusline#RefreshStatusline()]])
    vim.cmd(
        [[autocmd User CocDiagnosticChange call local#statusline#RefreshStatusline()]])
    vim.cmd(
        [[autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')]])
    vim.cmd([[autocmd CursorHold * silent call CocActionAsync('highlight')]])
    -- vim.cmd([[autocmd CursorHold * silent call CocActionAsync('getCurrentFunctionSymbol')]])
    vim.cmd([[augroup end]])

    vim.fn.execute([[
    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
      else
        execute '!' . &keywordprg . " " . expand('<cword>')
      endif
    endfunction

    nnoremap <Plug>(show-doc) :<C-U>call <SID>show_documentation()<CR>

    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gD <Plug>(coc-declaration)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)
    nmap <silent> gS :call CocAction('jumpDefinition', 'split')<CR>
    nmap <silent> gV :call CocAction('jumpDefinition', 'vsplit')<CR>

    xmap <leader>f <Plug>(coc-format-selected)
    nmap <leader>f <Plug>(coc-format-selected)

    xmap <leader>a <Plug>(coc-codeaction-selected)
    nmap <leader>a <Plug>(coc-codeaction-selected)
    nmap <leader>ac  <Plug>(coc-codeaction)
    nmap <leader>qf  <Plug>(coc-fix-current)

    xmap if <Plug>(coc-funcobj-i)
    omap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap af <Plug>(coc-funcobj-a)
    xmap ic <Plug>(coc-classobj-i)
    omap ic <Plug>(coc-classobj-i)
    xmap ac <Plug>(coc-classobj-a)
    omap ac <Plug>(coc-classobj-a)

    if has('nvim-0.4.0') || has('patch-8.2.0750')
      nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
      nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
      inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
      inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
      vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
      vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    endif

    nmap <silent> <C-s> <Plug>(coc-range-select)
    xmap <silent> <C-s> <Plug>(coc-range-select)

    nmap <silent> K <Plug>(show-doc)

    nmap <leader>rn <Plug>(coc-rename)

    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

    nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
    nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
    nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
    nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
    nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
    nnoremap <silent> <space>j  :<C-u>CocNext<CR>
    nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
    nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

    command! -nargs=?  Fold :call     CocAction('fold', <f-args>)
    command! -nargs=0  OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
    ]], "")
end

return M
