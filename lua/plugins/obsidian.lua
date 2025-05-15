return {
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    opts = function()
      local options = {}
      options.workspaces = {}

      local function file_exists(path)
        local file = io.open(path, "r")
        if file then
          io.close(file)
          return true
        else
          return false
        end
      end

      local paths = {
        { name = "old", path = "~/Work/Obsidian-notes/Notebook" },
        { name = "new", path = "~/Work/notebook/notes" },
        { name = "fwo", path = "~/Work/Proposals/FWO/fwo-postdoc/notes" },
        { name = "fwo-macos", path = "~/repos/fwo-postdoc/notes" },
        { name = "schuurjans-macos", path = "/Users/mathijssch/Dropbox/admin/Schuurjans/schuurjans" },
        { name = "gd", path = "/Users/mathijssch/repos/gd/gdnotes/src" },
        { name = "GET", path = "~/Work/Research/GET/GET-notes/notes" },
      }

      for _, pathInfo in ipairs(paths) do
        local home = os.getenv("HOME")
        local resolvedPath = pathInfo.path
        if home then
          resolvedPath = pathInfo.path:gsub("^~", home)
        end
        if file_exists(resolvedPath) then
          table.insert(options.workspaces, pathInfo)
        end
      end

      if next(options.workspaces) == nil then return {} end

      local utils_ok, _utils = pcall(require, "schuurvim.util")
      if not utils_ok then
        vim.notify("Could not load utilities from schuurvim.", vim.log.levels.ERROR)
        return {}
      end

      local function ObsidianSmartAction(opts)
        local mode = vim.api.nvim_get_mode().mode
        if mode == "v" then
          local client = require("obsidian").get_client()
          client:command("ObsidianLink", opts)
          return
        end
        local obs_util = require("obsidian.util")
        if obs_util.cursor_on_markdown_link(nil, nil, true) then
          vim.cmd("ObsidianFollowLink")
        end
      end

      options.completion = { nvim_cmp = true, min_chars = 2 }
      options.date_format = "%d-%M-%Y"

      options.note_id_func = function(title)
        return title ~= nil and title or tostring(os.time())
      end

      options.mappings = {
        ["gf"] = {
          action = function() return require("obsidian.util").gf_passthrough() end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        ["<leader>ch"] = {
          action = function() return require("obsidian.util").toggle_checkbox() end,
          opts = { buffer = true },
        },
        ["<localleader>e"] = { action = function() vim.cmd("ObsidianTemplate") end },
        ["<localleader>E"] = {
          action = function()
            vim.api.nvim_buf_set_lines(0, 0, -1, false, {})
            vim.cmd("ObsidianTemplate")
          end,
        },
        ["<CR>"] = { action = ObsidianSmartAction },
      }

      local function get_monday_before(date, offset)
        offset = offset or 0
        local today = os.time()
        if date then
          local year, month, day = date:match("(%d+)-(%d+)-(%d+)")
          today = os.time { year = year, month = month, day = day }
        end
        local days_to_subtract = (tonumber(os.date("%w", today)) - 1) % 7
        local monday = os.date("*t", today + (7 * offset - days_to_subtract) * 86400)
        return monday
      end

      local function get_date_from_title(title)
        return string.match(title, "%d+-%d+-%d+")
      end

      local function title_to_date(offset)
        local current_buffer_name = vim.fn.bufname('%')
        local date = get_date_from_title(current_buffer_name)
        if date == nil then
          vim.notify("Could not parse date from title. Using today's date.", vim.log.levels.WARN)
        end
        local monday = get_monday_before(date, offset)
        return FormatDate(monday)
      end

      local substitutions = {
        this_week = function() return title_to_date(0) end,
        next_week = function() return title_to_date(1) end,
        last_week = function() return title_to_date(-1) end,
      }

      options.templates = {
        subdir = ".templates",
        substitutions = substitutions,
      }

      options.new_notes_location = "notes_subdir"
      options.preferred_link_style = "wiki"

      options.attachments = {
        img_folder = "Attachments",
        img_text_func = function(client, path)
          path = client:vault_relative_path(path) or path
          return string.format("![[%s]]", path)
        end,
      }

      options.ui = { enable = false }
      options.disable_frontmatter = true

      options.follow_url_func = function(url)
        vim.ui.open(url)
      end

      return options
    end,
  },
}

