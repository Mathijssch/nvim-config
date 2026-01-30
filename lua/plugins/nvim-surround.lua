return {
  "kylechui/nvim-surround",
  version = "^3.0.0",
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({
      surrounds = {
        e = {
          add = function()
            local env = vim.fn.input("Environment: ")
            return {
              { "\\begin{" .. env .. "}\n" },
              { "\n\\end{" .. env .. "}" },
            }
          end,
        },
      },
    })
  end,
}

