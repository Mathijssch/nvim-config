return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- local caps = vim.lsp.protocol.make_client_capabilities()
      -- caps.offsetEncoding = { "utf-8" }
      opts.servers = vim.tbl_deep_extend("force", opts.servers or {}, {
        -- pyright = {
        --   mason = false,
        --   autostart = false,
        -- },
        --
        -- capabilities = vim.tbl_deep_extend("force", opts.servers.capabilities or {}, caps),
        pylsp = {
          settings = {
            pylsp = {
              plugins = {
                pyflakes = { enabled = false }, -- All of these are replaced by Ruff
                mccabe = { enabled = false },
                pylint = { enabled = false },
                pycodestyle = {
                  enabled = false,
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
