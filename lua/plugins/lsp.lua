return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local caps = vim.lsp.protocol.make_client_capabilities()
      caps.offsetEncoding = { "utf-8" }
      opts.capabilities = vim.tbl_deep_extend("force", opts.capabilities or {}, caps)

      opts.servers = vim.tbl_deep_extend("force", opts.servers or {}, {
        -- pyright = {
        --   mason = false,
        --   autostart = false,
        -- },
        pylsp = {
          settings = {
            pylsp = {
              plugins = {
                pyflakes = { enabled = false },
                pycodestyle = {
                  ignore = { "E501", "E203" },
                  maxLineLength = 100,
                },
              },
            },
          },
        },
      })

      return opts
    end,
  },
}
