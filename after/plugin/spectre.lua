local spectre = require("spectre");

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

