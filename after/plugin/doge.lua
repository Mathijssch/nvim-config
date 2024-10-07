-- Generate comment for current line
vim.cmd([[let g:doge_doc_standard_python = 'numpy']])
vim.keymap.set('n', '<Leader>d', '<Plug>(doge-generate)')
