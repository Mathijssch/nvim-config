local status_ok, spectre = pcall(require, "spectre")
if not status_ok then return end;

vim.keymap.set('n', '<leader>H', spectre.open, {
    desc = "Open Spectre"
})
vim.keymap.set('n', '<leader>sw', function() 
    spectre.open_visual({ select_word = true })
end, {
    desc = "Search current word."
})
vim.keymap.set('v', '<leader>sw',
    function()
        vim.cmd.esc()
        spectre.open_visual()
    end,
    {
        desc = "Search current word."
    }
)
vim.keymap.set('n', '<leader>sp',
    function()
        spectre.open_file_search({ select_word = true })
    end,
    {
        desc = "Search on current file"
    })

