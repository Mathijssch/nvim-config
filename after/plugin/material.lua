local status_ok, material = pcall(require, "material")
if not status_ok then return end
local colors = require 'material.colors'
material.setup({
    contrast = {
        terminal = true,             -- Enable contrast for the built-in terminal
        sidebars = true,             -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
        floating_windows = true,     -- Enable contrast for floating windows
        cursor_line = true,          -- Enable darker background for the cursor line
        non_current_windows = false, -- Enable contrasted background for non-current windows
        filetypes = {},              -- Specify which filetypes get the contrasted (darker) background
    },

    styles = {
        -- Give comments style such as bold, italic, underline etc.
        comments = { --[[ italic = true ]] },
        strings = { --[[ bold = true ]] },
        keywords = { --[[ underline = true ]] },
        functions = { --[[ bold = true, undercurl = true ]] },
        variables = {},
        operators = {},
        types = {},
    },

    plugins = { -- Uncomment the plugins that you use to highlight them
        -- Available plugins:
        -- "dap",
        -- "dashboard",
        -- "eyeliner",
        -- "fidget",
        -- "flash",
        "gitsigns",
        -- "harpoon",
        -- "hop",
        -- "illuminate",
        -- "indent-blankline",
        -- "lspsaga",
        -- "mini",
        -- "neogit",
        -- "neotest",
        -- "neo-tree",
        -- "neorg",
        -- "noice",
        "nvim-cmp",
        -- "nvim-navic",
        "nvim-tree",
        "nvim-web-devicons",
        -- "rainbow-delimiters",
        -- "sneak",
        "telescope",
        -- "trouble",
        -- "which-key",
        "nvim-notify",
    },

    disable = {
        colored_cursor = false, -- Disable the colored cursor
        borders = false,        -- Disable borders between verticaly split windows
        background = false,     -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
        term_colors = false,    -- Prevent the theme from setting terminal colors
        eob_lines = true        -- Hide the end-of-buffer lines
    },

    high_visibility = {
        lighter = false, -- Enable higher contrast text for lighter style
        darker = false   -- Enable higher contrast text for darker style
    },

    lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )

    async_loading = true,      -- Load parts of the theme asyncronously for faster startup (turned on by default)

    custom_colors = function(colordefs)
        colordefs.git.modified = colordefs.main.orange
        colordefs.syntax.type = colordefs.main.yellow
        --colordefs.editor.fg = colordefs.main.paleblue
        --local swap = colors.editor.bg_alt
        --colordefs.editor.bg_alt = colordefs.editor.bg
        colordefs.editor.selection = "#3b5063"
    end, -- If you want to override the default colors, set this to a function

    custom_highlights = {
        NvimTreeRootFolder = { fg = colors.main.green },
        ["@constant"] = { fg = colors.main.paleblue },
        ColorColumn = { link = "NormalFloat" },
        TreeSitterContext = { link = "NormalFloat" },
        SpellBad = { italic = true, undercurl = true },
        TexCmd = { link = "Function" },
        TexCmdRef = { fg = colors.main.purple },
        TexMathCmd = { link = "@lsp.type.decorator" },
        TexCmdGreek = { link = "TexCmd" },
        TexMathSuperSub = { link = "Normal" },
        TexMathZone = { link = "@lsp.type.enumMember" },
        TexFootnoteArg = { link = "@string.escape" },
        ["@lsp.type.selfKeyword"] = { link = "@character" }
    }, -- Overwrite highlights with your own
})

require('material.functions').change_style("palenight")
