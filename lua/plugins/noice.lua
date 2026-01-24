return {
  "folke/noice.nvim",
  opts = function(_, opts)
    opts.routes = opts.routes or {}
    table.insert(opts.routes, {
      filter = {
        event = "msg_show",
        find = " Compilation",
      },
      opts = { skip = true },
    })
  end,
}
