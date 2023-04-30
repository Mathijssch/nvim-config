local status_ok, lsp = pcall(require, 'lsp-zero')
if not status_ok then return end

lsp.preset({
  name = 'minimal',
  set_lsp_keymaps = true,
  manage_nvim_cmp = true,
  suggest_lsp_servers = true
})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

-- (Optional) Configure lua language server for neovim
local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then return end
lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
lspconfig.pylsp.setup {
    capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
    settings = {
        pylsp = {
            plugins = {
                jedi_completion = {
                    enabled = true, 
                    include_params = true,
                },
                pycodestyle = {
                    ignore = {"E501"}
                }
            },
        },
    },
}
--lspconfig.pyright.setup{
    --settings = {
        --pyright = {
            --autoImportCompletion = true,
        --},
        --python = {
            --analysis = {
                --autoSearchPaths = true,
                --autoImportCompletions = true,
                --diagnosticMode = 'openFilesOnly',
                --useLibraryCodeForTypes = true,
                --reportPrivateImportUsage = false,
                --typeCheckingMode = 'off'}
            --}
        --}
    --}
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
  error = ' ',
  warn = ' ',
  hint = '󱡴 ',
  info = '󰋼 '
})


lsp.setup()

