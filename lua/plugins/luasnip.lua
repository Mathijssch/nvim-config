return {
  {
    "L3MON4D3/LuaSnip",
    config = function()
      local luasnip = require("luasnip")

      luasnip.config.set_config({
        enable_autosnippets = true,
        store_selection_keys = "<Tab>",
      })

      -- Load your custom snippets
      require("luasnip.loaders.from_lua").load({ paths = { "~/.config/nvim/LuaSnip/" } })

      -- Stop snippets when you leave insert or select mode
      vim.api.nvim_create_autocmd("ModeChanged", {
        pattern = "*",
        callback = function()
          if
            ((vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n")
            or vim.v.event.old_mode == "i")
            and luasnip.session.current_nodes[vim.api.nvim_get_current_buf()]
            and not luasnip.session.jump_active
          then
            luasnip.unlink_current()
          end
        end,
      })

      vim.api.nvim_create_user_command("Snipload", function()
        require("luasnip.loaders.from_lua").load({ paths = { "~/.config/nvim/LuaSnip/" } })
      end, {})
    end,
  },
}

