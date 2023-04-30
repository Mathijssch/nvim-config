function SetColors(theme)
	theme = theme or "palenightfall" -- "catppuccin-frappe" -- "tokyonight" -- "kanagawa" -- "catppuccin-frappe" -- "kanagawa"
	vim.cmd.colorscheme(theme)
    --feline = require("after.plugin.feline")
    --feline.SetupFeline()
    vim.cmd([[lua SetupFeline()]])
end

function LightMode()
    SetColors("catppuccin-latte")
end

function DarkMode()
    SetColors("palenightfall")
end


vim.cmd([[au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=150}]])
