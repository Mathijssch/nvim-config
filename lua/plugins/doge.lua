return {
  "kkoomen/vim-doge",
  keys = {
    { "<Leader>dg", "<Plug>(doge-generate)", desc = "Generate a docstring for the function under the cursor." }
  },
  opts = function()
    vim.cmd([[let g:doge_doc_standard_python = 'numpy']])
  end,
}
