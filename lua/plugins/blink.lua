return {
  "saghen/blink.cmp",
  dependencies = { "L3MON4D3/LuaSnip" },
  opts = function(_, opts)
    local cmp = require("blink.cmp")
    local has_luasnip, luasnip = pcall(require, "luasnip")

    local function has_words_before()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    local function tab_complete(_, fallback)
      if cmp.is_visible() and cmp.get_selected_item_idx() == 1 then
        -- if nothing is selected, use select_and_accept
        -- this selects the first item then confirms it
        return cmp.select_and_accept()
      end

      if cmp.is_visible() then
        return cmp.select_next()
      end

      if has_luasnip and luasnip.expand_or_jumpable() then
        return luasnip.expand_or_jump()
      end

      if has_words_before() then
        return cmp.show({ initial_selected_item_idx = 2 }) -- shows and preselects
      end
    end

    local function shift_tab_complete(_, fallback)
      if cmp.is_visible() then
        return cmp.select_prev()
      end
      if has_luasnip and luasnip.jumpable(-1) then
        return luasnip.jump(-1)
      end
      return fallback()
    end

    opts.keymap = vim.tbl_extend("force", opts.keymap or {}, {
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = { tab_complete, "fallback" },
      ["<S-Tab>"] = { shift_tab_complete, "fallback" },
    })
  end,
}
