local status_ok, builtin = pcall(require, 'telescope.builtin')
if not status_ok then return end

vim.keymap.set('n', '<leader>?', builtin.oldfiles, {desc  = '[?] find recently opened files'})

vim.keymap.set('n', '<leader>pf', builtin.find_files, {desc = 'Search for [f]iles'})
vim.keymap.set('n', '<C-p>', builtin.git_files, {desc = 'Search for files in git'})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = "" }) -- vim.fn.input("Grep > ") })
end, {desc = "Find files in current git repository. Similar to <leader>pf, but faster."})
vim.keymap.set('n', '<leader>pg', builtin.live_grep)
