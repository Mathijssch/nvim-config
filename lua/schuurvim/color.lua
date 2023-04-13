function SetColors(theme)
	theme = theme or "kanagawa" -- "catppuccin-frappe" -- "kanagawa"
	vim.cmd.colorscheme(theme)
end

SetColors()
