vim.diagnostic.config({
    underline = true,
    signs = true,
    virtual_text = false, -- Turn off inline diagnostics
    float = {
        show_header = true,
        focusable = false,
        border = 'rounded'
    },
})

-- Use this if you want it to automatically show all diagnostics on the
-- current line in a floating window.
-- The CursorHold event happens when after `updatetime` milliseconds.
-- The default is 4000.
--vim.cmd('autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()')
vim.o.updatetime = 1000
vim.api.nvim_create_autocmd("CursorHold", {
    callback = function(e) vim.diagnostic.open_float( {focusable = false} ) end,
})

---------------------------
-- KEYMAPS
--------------------------

vim.keymap.set("n", "<leader>ls", vim.diagnostic.show, { desc = "Show linting diagnostics" })
vim.keymap.set("n", "<leader>lh", vim.diagnostic.hide, { desc = "Hide linting diagnostics" })

-- Show all diagnostics on current line in floating window
vim.keymap.set(
    'n', '<Leader>lo', vim.diagnostic.open_float,
    { noremap = true, silent = true, desc = "[O]pen [l]inting diagnostics" }
)

-- Go to next diagnostic (if there are multiple on the same line, only shows
-- one at a time in the floating window)
vim.keymap.set(
    'n', '<Leader>ln', vim.diagnostic.goto_next,
    { noremap = true, silent = true, desc = "Show [n]ext diagnostics on the current line." }
)
-- Go to prev diagnostic (if there are multiple on the same line, only shows
-- one at a time in the floating window)
vim.keymap.set(
    'n', '<Leader>lp', vim.diagnostic.goto_prev,
    { noremap = true, silent = true, desc = "Show [p]revious diagnostic on the current line." }
)
