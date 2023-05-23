local status_ok, builtin = pcall(require, 'telescope.builtin')
if not status_ok then return end

local telescope = require("telescope")

telescope.setup({defaults = {file_ignore_patterns = { ".git", "node_modules/" }}})

vim.keymap.set('n', '<leader>?', builtin.oldfiles, {desc  = '[?] find recently opened files'})

vim.keymap.set('n', '<leader>pf', builtin.find_files, {desc = 'Search for [f]iles'})
vim.keymap.set('n', '<leader>pF', function() 
    builtin.find_files({hidden=true})
end, 
    {desc = 'Search for [f]iles'})

vim.keymap.set('n', '<C-p>', builtin.git_files, {desc = 'Search for files in git'})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = "" }) -- vim.fn.input("Grep > ") })
vim.keymap.set('n', '<leader>pb', builtin.buffers, {desc = "Search for open buffers" })
end, {desc = "Find files in current git repository. Similar to <leader>pf, but faster."})
vim.keymap.set('n', '<leader>pg', builtin.live_grep)


--local telescope_ok, telescope = pcall(require, "telescope")
--if not telescope_ok then return end
--local actions_ok, actions = pcall(require, "telescope.actions.set")
--if not actions_ok then return end

--local function tab_drop(bufnr)
--    actions.edit(bufnr, "tab drop")
--end


--telescope.setup({
--        pickers = {
--            buffers = {
--                mappings = {
--                    i = { ["<CR>"] = tab_drop }
--                }
--            },
--            find_files = {
--                mappings = {
--                    i = { ["<CR>"] = tab_drop }
--                }
--            },
--            git_files = {
--                mappings = {
--                    i = { ["<CR>"] = tab_drop }
--                }
--            },
--            old_files = {
--                mappings = {
--                    i = { ["<CR>"] = tab_drop }
--                }
--            },
--    },
--})

