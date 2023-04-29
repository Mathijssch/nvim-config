local lsp_signature = require("lsp_signature")

local cfg = {
  hint_prefix = "  ",  -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
  timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
}

lsp_signature.setup(cfg)

