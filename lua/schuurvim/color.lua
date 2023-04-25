function SetColors(theme)
	theme = theme or "palenightfall" -- "catppuccin-frappe" -- "tokyonight" -- "kanagawa" -- "catppuccin-frappe" -- "kanagawa"
	vim.cmd.colorscheme(theme)
end

SetColors()
