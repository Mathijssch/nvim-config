-- Markdown keybindings
vim.api.nvim_set_keymap('i', '<C-B>', [[****<Esc>hi]], {noremap = true})
vim.api.nvim_set_keymap('i', '<C-I>', [[**<Esc>i]], {noremap = true})
vim.api.nvim_set_keymap('v', '<C-B>', [[c**<Esc>pa**]], {noremap = true})
vim.api.nvim_set_keymap('v', '<C-I>', [[c*<Esc>pa*]], {noremap = true})
--vim.api.nvim_set_keymap('v', '<C-b>', [[d]], {noremap = true})
--
--vim.api.nvim_set_keymap('v', '<C-i>', '**<Esc>hi', {noremap = true})

