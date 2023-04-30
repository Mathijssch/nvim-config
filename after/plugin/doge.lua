vim.g.doge_mapping = "<Leader>doc"
vim.api.nvim_create_user_command("Doge", function() vim.cmd('DogeGenerate google') end, {})
