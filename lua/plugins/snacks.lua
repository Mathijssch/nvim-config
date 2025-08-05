local function copy_file_path_action(_, item)
  vim.notify("File path action!")
  if not item then
    return
  end

  local vals = {
    ["BASENAME"] = vim.fn.fnamemodify(item.file, ":t:r"),
    ["EXTENSION"] = vim.fn.fnamemodify(item.file, ":t:e"),
    ["FILENAME"] = vim.fn.fnamemodify(item.file, ":t"),
    ["PATH"] = item.file,
    ["PATH (CWD)"] = vim.fn.fnamemodify(item.file, ":."),
    ["PATH (HOME)"] = vim.fn.fnamemodify(item.file, ":~"),
    ["URI"] = vim.uri_from_fname(item.file),
  }

  local options = vim.tbl_filter(function(val)
    return vals[val] ~= ""
  end, vim.tbl_keys(vals))
  if vim.tbl_isempty(options) then
    vim.notify("No values to copy", vim.log.levels.WARN)
    return
  end
  table.sort(options)
  vim.ui.select(options, {
    prompt = "Choose to copy to clipboard:",
    format_item = function(list_item)
      return ("%s: %s"):format(list_item, vals[list_item])
    end,
  }, function(choice)
    local result = vals[choice]
    if result then
      vim.fn.setreg("+", result)
      Snacks.notify.info("Yanked `" .. result .. "`")
    end
  end)
end

return {
  "snacks.nvim",
  opts = {
    dashboard = {
      preset = {
        pick = function(cmd, opts)
          return LazyVim.pick(cmd, opts)()
        end,
        header = [[
        ███    ██ ██    ██ ██ ███    ███
        ████   ██ ██    ██ ██ ████  ████
        ██ ██  ██ ██    ██ ██ ██ ████ ██
        ██  ██ ██  ██  ██  ██ ██  ██  ██
        ██   ████   ████   ██ ██      ██
 ]],
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
    },
    picker = {
      sources = {
        explorer = {
          actions = {
            copy_file_path = {
              action = copy_file_path_action
            },
          },
          win = {
            list = {
              keys = {
                ["Y"] = "copy_file_path",
                -- ["Y"] = function(_, item)
                --   print(item)
                --   -- local filename = vim.fn.fnamemodify(path, ":t")
                --   -- vim.fn.setreg("+", filename)
                -- end
              },
            },
          },
        },
      },
    },
  },
}
