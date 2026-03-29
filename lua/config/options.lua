-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
vim.g.autoformat = false
vim.opt.conceallevel = 1
vim.g.lazyvim_picker = "telescope"
vim.g.snacks_animate = false

require("config.max-columns")
