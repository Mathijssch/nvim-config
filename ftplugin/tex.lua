-- LaTeX keybindings
vim.api.nvim_set_keymap('i', '<C-B>', [[\textbf{}<Esc>i]], { noremap = true })
vim.api.nvim_set_keymap('i', '<C-I>', [[\textit{}<Esc>i]], { noremap = true })
vim.api.nvim_set_keymap('v', '<C-B>', [[c\textbf{<Esc>pa}<Esc>]], { noremap = true })
vim.api.nvim_set_keymap('v', '<C-I>', [[c\textit{<Esc>pa}<Esc>]], { noremap = true })
