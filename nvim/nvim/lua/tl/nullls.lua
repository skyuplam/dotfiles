local has_null_ls, null_ls = pcall(require, 'null-ls')

if not has_null_ls then return end

local sources = {
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.lua_format,
    null_ls.builtins.diagnostics.write_good,
    null_ls.builtins.code_actions.gitsigns
}

null_ls.setup({debug = true, sources = sources})
