return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
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

