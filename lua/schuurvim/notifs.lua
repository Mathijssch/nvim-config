-- Use the notify plugin for notifications if available
local status_ok, notify = pcall(require, "notify")

if not status_ok then return end

vim.notify = notify
