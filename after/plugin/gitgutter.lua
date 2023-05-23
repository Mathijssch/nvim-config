vim.cmd("let g:gitgutter_map_keys = 0")

vim.keymap.set("n", "<Leader>gx", "<Plug>GitGutterRevertHunk")
vim.keymap.set("n", "<Leader>gs", "<Plug>GitGutterStageHunk")
