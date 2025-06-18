local DOTFILES = os.getenv("DOTFILES")
require("schuurvim.pathman")

local path = DOTFILES .. "/.markdownlint-cli2.yaml"
local args = {}
if (FileExists(path)) then
  args = { "--config", path, "--" }
end

return {
  "mfussenegger/nvim-lint",
  optional = true,
  opts = {
    linters = {
      ["markdownlint-cli2"] = {
        args = args,
      },
    },
  },
}
