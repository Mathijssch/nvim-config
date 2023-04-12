vim.g.vimtex_compiler_latexmk = {
    build_dir = '',
    callback = 1,
    continuous = 1,
    executable = 'latexmk',
    hooks = {},
    options = {
    '-verbose',
    '-file-line-error',
    '-synctex=1',
    '-shell-escape',
    '-interaction=nonstopmode',
},
}

vim.keymap.set("n", "<C-A-b>", "<Cmd>VimtexCompileSS<CR>")
vim.keymap.set("i", "<C-A-b>", "<Cmd>VimtexCompileSS<CR>")
vim.keymap.set("n", "<C-A-k>", "<Cmd>VimtexStop<CR>")
vim.keymap.set("n", "<C-A-R>", "<Cmd>VimtexReload<CR>")
