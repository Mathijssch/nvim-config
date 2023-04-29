local status_ok, lsp_signature = pcall(require, "lsp_signature")
if not status_ok then return end

local cfg = {
  hint_prefix = "  ",  -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
  timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
}

lsp_signature.setup(cfg)

