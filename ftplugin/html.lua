-- HTML keybindings
vim.api.nvim_set_keymap('i', '<C-B>', [[<b></b><Esc>3hi]], { noremap = true })
vim.api.nvim_set_keymap('i', '<C-I>', [[<i>\</i><Esc>3hi]], { noremap = true })
vim.api.nvim_set_keymap('v', '<C-B>', [[c<b><Esc>pa</b><Esc>]], { noremap = true })
vim.api.nvim_set_keymap('v', '<C-I>', [[c<i><Esc>pa</i><Esc>]], { noremap = true })

vim.keymap.set('n', [[<localleader>lv]], [[<cmd>GotoPage<CR>]], { buffer = true})
