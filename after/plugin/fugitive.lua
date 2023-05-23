vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Open Git menu" });
vim.keymap.set("n", "<leader>gx", "<Cmd>Gdiff<cr>gv:diffget<cr><C-w><C-w>ZZ", { desc = "Revert current commit" })
