local possession = require("nvim-possession")

vim.keymap.set("n", "<leader>sl", function() possession.list() end)
vim.keymap.set("n", "<leader>sn", function() possession.new() end)
vim.keymap.set("n", "<leader>su", function() possession.update() end)

local seshdir = vim.fn.stdpath("data") .. "/sessions/"
if vim.fn.isdirectory(seshdir) == 0 then
    vim.cmd(string.format("! mkdir -p %s", seshdir))
end

possession.setup({
    autoload = true  -- Automatically load the previous session.
})

