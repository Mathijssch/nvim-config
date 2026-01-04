  return {
    "unblevable/quick-scope",
    event = "VeryLazy",
    config = function()
      -- highlight when those keys are pressed
      vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
    end,
  }
