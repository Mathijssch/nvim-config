function SetColors(theme)
	theme = theme or "palenightfall" -- "catppuccin-frappe" -- "tokyonight" -- "kanagawa" -- "catppuccin-frappe" -- "kanagawa"
	vim.cmd.colorscheme(theme)
    --feline = require("after.plugin.feline")
    --feline.SetupFeline()
    vim.cmd([[lua SetupFeline()]])
end

function LightMode()
    --SetColors("catppuccin-latte")
    --SetColors("ayu-light")
    
    vim.cmd[[set background=light]]
    SetColors("catppuccin-latte")
    --local ayucolor="light"  " for light version of theme
    vim.cmd[[highlight Cursor guifg=white guibg=gray]]
    vim.cmd[[highlight iCursor guifg=white guibg=SlateGray]]
    vim.cmd[[set guicursor=n-v-c:block-Cursor]]
    vim.cmd[[set guicursor+=i:ver100-iCursor]]
    vim.cmd[[set guicursor+=n-v-c:blinkon0]]
    vim.cmd[[set guicursor+=i:blinkwait10]]
end

function DarkMode()
    SetColors("palenightfall")
end
vim.api.nvim_set_hl(0, 'TreesitterContextBottom', { underline = true })
vim.api.nvim_create_user_command("DarkMode", DarkMode, {})
vim.api.nvim_create_user_command("LightMode", LightMode, {})

vim.cmd([[au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=150}]])

