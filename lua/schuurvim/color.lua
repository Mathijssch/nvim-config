function SetColors(theme)
	theme = theme or "tokyonight" -- "kanagawa" -- "catppuccin-frappe" -- "kanagawa"
	vim.cmd.colorscheme(theme)
end

SetColors()
