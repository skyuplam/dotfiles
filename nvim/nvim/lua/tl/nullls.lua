local has_null_ls, null_ls = pcall(require, 'null-ls')

if not has_null_ls then return end
local command_resolver = require("null-ls.helpers.command_resolver")

local sources = {
    null_ls.builtins.formatting.prettier.with({
        dynamic_command = command_resolver.from_yarn_pnp()
    }), null_ls.builtins.formatting.lua_format,
    null_ls.builtins.diagnostics.write_good,
    null_ls.builtins.code_actions.gitsigns
}

null_ls.setup({debug = true, sources = sources})
