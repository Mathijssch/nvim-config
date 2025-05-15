return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    defaults = {
      file_ignore_patterns = { ".git", "node_modules/" },
    },
    -- You can optionally include the `pickers` config here
    -- pickers = {
    --   buffers = {
    --     mappings = {
    --       i = { ["<CR>"] = require("telescope.actions.set").edit, "tab drop" }
    --     }
    --   },
    -- }
  },
  keys = {
    { "<leader>?", function() require("telescope.builtin").oldfiles() end, desc = "[?] Find recently opened files" },
    { "<leader>pf", function() require("telescope.builtin").find_files() end, desc = "Search for [f]iles" },
    { "<leader>pF", function() require("telescope.builtin").find_files({ hidden = true }) end, desc = "Search hidden files" },
    { "<C-o>", function() require("telescope.builtin").find_files() end, desc = "Search files in directory" },
    { "<C-p>", function() require("telescope.builtin").git_files() end, desc = "Search files in Git repo" },
    { "<leader>ps", function() require("telescope.builtin").grep_string({ search = "" }) end, desc = "Search string in project" },
    { "<leader>pb", function() require("telescope.builtin").buffers() end, desc = "Search open buffers" },
    { "<leader>pg", function() require("telescope.builtin").live_grep() end, desc = "Live grep in project" },
  },
}

