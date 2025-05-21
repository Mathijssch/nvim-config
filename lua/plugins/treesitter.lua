return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = {
        "c", "lua", "vim", "vimdoc", "query",
        "javascript", "typescript", "python",
        "bibtex", "html", "css"
      }
      opts.auto_install = true
      opts.highlight = {
        enable = true,
        disable = function(lang, buf)
          if lang == "latex" then return true end
          local max_filesize = 100 * 1024
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          return ok and stats and stats.size > max_filesize
        end,
        additional_vim_regex_highlighting = false,
      }
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      -- nothing here unless you want to force override again
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup({
        enable = true,
        max_lines = 0,
        min_window_height = 0,
        line_numbers = true,
        multiline_threshold = 20,
        trim_scope = "outer",
        mode = "cursor",
        separator = "-",
        zindex = 20,
      })
    end,
  },
}

