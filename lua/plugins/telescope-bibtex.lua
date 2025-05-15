-- ~/.config/nvim/lua/plugins/telescope-bibtex.lua
return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-bibtex.nvim",
  },
  config = function()
    local status_ok, telescope = pcall(require, "telescope")
    if not status_ok then return end

    local action_state = require('telescope.actions.state')
    local actions = require("telescope.actions")


    local status_ok_util, utils = pcall(require, "telescope-bibtex.utils")
    if not status_ok_util then return end

    -- local status_utils, _utils = pcall(require, "schuurvim.util")
    -- if not status_utils then
    --   vim.notify("Could not load utilities from schuurvim.", vim.log.levels.ERROR)
    --   return
    -- end

    local status_helpers, helpers = pcall(require, "schuurvim.telescope-bibtex-utils")
    if not status_helpers then
      vim.notify("Could not load utilities from schuurvim.", vim.log.levels.ERROR)
      return
    end

    local function add_citation()
      return function(prompt_bufnr)
        local entry = action_state.get_selected_entry().id.content
        local parsed = utils.parse_entry(entry)
        actions.close(prompt_bufnr)
        if helpers.IsMarkdown() then
          helpers.CreateIfNotExists(parsed)
          helpers.WriteText(helpers.format_citation_md(parsed))
        else
          helpers.WriteText(helpers.format_citation_tex(parsed))
        end
      end
    end

    telescope.setup({
      extensions = {
        bibtex = {
          mappings = {
            i = {
              ["<cr>"] = add_citation()
            }
          }
        }
      }
    })

    telescope.load_extension("bibtex")
  end
}

