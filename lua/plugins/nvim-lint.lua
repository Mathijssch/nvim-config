local DOTFILES = os.getenv("DOTFILES")
require("schuurvim.pathman")

local args = {}
if DOTFILES then
  local path = DOTFILES .. "/.markdownlint-cli2.yaml"
  if (FileExists(path)) then
    args = { "--config", path, "--" }
  end
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
