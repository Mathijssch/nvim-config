local map = vim.api.nvim_set_keymap

local opts = { noremap = true, silent = true }

local modes = {'n', 'v'} -- normal and visual mode
--" Add your own custom formats or override the defaults

--vim.g.NERDCustomDelimiters = {
--    html = { left = '<!--', right = '-->' }
--}

for i in pairs(modes) do
        map(modes[i], '<C-/>', ':call nerdcommenter#Comment(0, "toggle")<CR>' , opts)
end


-- Align line-wise comment delimiters flush left instead of following code indentation
vim.g.NERDDefaultAlign = 'left'
