function SetColors(theme)
	theme = theme or "palenightfall" -- "catppuccin-frappe" -- "tokyonight" -- "kanagawa" -- "catppuccin-frappe" -- "kanagawa"
	vim.cmd.colorscheme(theme)
end

--require('palenightfall').setup({
  --color_overrides = {
    --references = '#3E4B6E',
--}})



SetColors()
