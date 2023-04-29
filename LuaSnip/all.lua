local status_ok, luasnip = pcall(require, 'luasnip')
if not status_ok then return end

local t = luasnip.text_node
-- Place this in ${HOME}/.config/nvim/LuaSnip/all.lua
return {}
