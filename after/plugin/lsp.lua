local lsp = require('lsp-zero').preset({
  name = 'minimal',
  set_lsp_keymaps = true,
  manage_nvim_cmp = true,
  suggest_lsp_servers = true
})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

-- (Optional) Configure lua language server for neovim
local lspconfig = require("lspconfig")
lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
lspconfig.pyright.setup{
    settings = {
        pyright = {
            autoImportCompletion = true,
        },
        python = {
            analysis = {
                autoSearchPaths = true,
                autoImportCompletions = true,
                diagnosticMode = 'openFilesOnly',
                useLibraryCodeForTypes = true,
                reportPrivateImportUsage = false,
                typeCheckingMode = 'off'}
            }
        }
    }
--local cmp = require('cmp')
--local cmp_select = {behavior = cmp.SelectBehavior.Select}
--cmp_select = lsp.defaults.cmp_mappings({
	--['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	--['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	--['<Tab>'] = cmp.mapping.confirm( {select = true} ),
	--['<C-Space>'] = cmp.mapping.complete(),
--})


lsp.setup_nvim_cmp({
  select_behavior = 'insert'
})

lsp.set_sign_icons({
  error = '✘',
  warn = '▲',
  hint = '⚑',
  info = '»'
})

lsp.setup()
