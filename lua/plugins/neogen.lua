return {
  "danymat/neogen",
  config = true,
  opts = function(_, opts)
    opts.snippet_engine = "luasnip"
    table.insert(opts,
      {
        languages = {
          python = {
            template = {
              annotation_convention = "numpydoc" }
          }
        }
      }
    )
  end,
  keys = {
    { "<leader>dg", ":lua require('neogen').generate()<CR>", desc = "Auto-generate docstring" }
  },
  version = "*" -- Only stable versions
}
