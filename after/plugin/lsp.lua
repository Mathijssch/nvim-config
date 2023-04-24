local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
--local cmp = require('cmp')
--local cmp_select = {behavior = cmp.SelectBehavior.Select}
--cmp_select = lsp.defaults.cmp_mappings({
	--['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	--['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	--['<Tab>'] = cmp.mapping.confirm( {select = true} ),
	--['<C-Space>'] = cmp.mapping.complete(),
--})


local lsp = require('lsp-zero').preset({
  name = 'minimal',
  set_lsp_keymaps = true,
  manage_nvim_cmp = true,
  suggest_lsp_servers = false
})

lsp.setup_nvim_cmp({
  select_behavior = 'insert'
})

lsp.setup()
