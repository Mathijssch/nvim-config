-- Use the notify plugin for notifications if available
local status_ok, notify = pcall(require, "notify")
if not status_ok then return end
vim.opt.termguicolors = true

local function max_width()
    local winwidth = vim.api.nvim_win_get_width(0)
    if winwidth <= 100 then
        return 50
    elseif winwidth <= 200 then
        return 70
    else
        return 100
    end
end

notify.setup({
    stages = "fade",
    timeout = 3000,
    max_width=max_width
})
vim.notify = notify
