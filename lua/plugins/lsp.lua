return {
  -- Example: customize LSP config
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pylsp = {
          settings = {
            pylsp = {
              plugins = {
                pycodestyle = {
                  ignore = { "E501" },
                  maxLineLength = 100, -- Optional, override the default 79
                },
              },
            },
          },
        },
      },
    },
  },
}
