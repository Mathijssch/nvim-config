local status_ok, lsp_signature = pcall(require, "lsp_signature")
if not status_ok then return end

local cfg = {
  hint_prefix = "  ",  -- Icond for parameter 
  timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
  toggle_key = "<C-\\>", -- Toggling 
  transparency = 10
}

lsp_signature.setup(cfg)
