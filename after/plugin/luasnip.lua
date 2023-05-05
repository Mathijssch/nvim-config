-- Somewhere in your Neovim startup, e.g. init.lua
local status_ok, luasnip = pcall(require, "luasnip")
if not status_ok then return end
luasnip.config.set_config({
                            -- Setting LuaSnip config

    -- Enable autotriggered snippets
    enable_autosnippets = true,

    -- Use Tab (or some other key if you prefer) to trigger visual selection
    store_selection_keys = "<Tab>",
})

--vim.cmd[[
--" Use Tab to expand and jump through snippets
--imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
--smap <silent><expr> <Tab> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>'
--]]

--vim.keymap.set({"i", "s"}, "<Tab>",
--function()
--if luasnip.expand_or_jumpable() then
--luasnip.expand_or_jump()
--else
--vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
--end
--end,
--{silent = true})


local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local status_ok_cmp, cmp = pcall(require, "cmp")
if not status_ok_cmp then return end

function leave_snippet()
    if
        ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
        and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
        and not require('luasnip').session.jump_active
    then
        require('luasnip').unlink_current()
    end
end

-- stop snippets when you leave to normal mode
vim.api.nvim_command([[
    autocmd ModeChanged * lua leave_snippet()
]])


cmp.setup({
    -- ... Your other configuration ...

    mapping = {
        -- ... Your other mappings ...

        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
                -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                -- they way you will only jump inside the snippet region
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),

        -- ... Your other mappings ...
    },

    -- ... Your other configuration ...
})

local function reload()
    require("luasnip.loaders.from_lua").load({ paths = { "~/.config/nvim/LuaSnip/" } })
end

reload()

vim.api.nvim_create_user_command("Snipload", reload, {})

