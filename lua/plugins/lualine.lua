local tiny = function()
  return vim.fn.winwidth(0) < 50
end

local function is_fugitive()
  return vim.bo.filetype == 'fugitive'
end

return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    local conditions = {
      buffer_is_git = function()
        return is_fugitive()
      end,
      buffer_not_terminal = function()
        if tiny() then return false end
        if is_fugitive() then return false end
        return vim.bo.buftype ~= 'terminal'
      end,
      not_tiny = function() return not tiny() end,
      buffer_not_empty = function()
        if tiny() then return false end
        return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
      end,
      hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end,
      check_git_workspace = function()
        local filepath = vim.fn.expand('%:p:h')
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end,
    }
    local git_config = {
      function()
        return "Git status"
      end,
      cond = conditions.buffer_is_git
    }

    local term_config = {
      function()
        return "Terminal"
      end,
      cond = function() return not conditions.buffer_not_terminal() end
    }

    local filename_config = {
      'filename',
      cond = conditions.buffer_not_terminal,
      path = 1,
      symbols = { modified = '●', unmodified = ' ' },
    }
    local empty_content = function() return " " end
    local empty_config = { empty_content, cond = conditions.not_tiny };

    opts.winbar = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {}
    }
    opts.inactive_winbar = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {}
    }

    table.insert(opts.winbar.lualine_b, empty_config)
    table.insert(opts.winbar.lualine_c, filename_config)
    table.insert(opts.winbar.lualine_c, git_config)
    table.insert(opts.winbar.lualine_c, term_config)
    table.insert(opts.inactive_winbar.lualine_c, filename_config)
    table.insert(opts.inactive_winbar.lualine_c, git_config)
    table.insert(opts.inactive_winbar.lualine_c, term_config)

    -- Add LSP component to lualine sections (usually 'lualine_c' or 'lualine_x')
    local function lsp_client_names()
      local clients = vim.lsp.get_active_clients({ bufnr = 0 })
      if next(clients) == nil then
        return "No LSP"
      end
      local names = {}
      for _, client in ipairs(clients) do
        table.insert(names, client.name)
      end
      return table.concat(names, ", ")
    end

    -- Insert into lualine_c (or wherever you want)
    table.insert(opts.sections.lualine_x, { lsp_client_names, icon = " " })

    return opts
  end,
}
