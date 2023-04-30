local gitsigns_ok, gitsigns = pcall(require, "gitsigns")
if gitsigns_ok then
    if gitsigns ~= nil then
        gitsigns.setup() -- Git sign in statusline
    end
end

local mod = {}

local line_ok, feline = pcall(require, "feline")
if not line_ok then
    return {"SetupFeline", function() end}
end

local function get_color(group, bg)
    local color = nil
    local hl = vim.api.nvim_get_hl_by_name(group, true)
    if bg then
        color = hl.background
    else
        color = hl.foreground
    end
    return string.format("#%06x", color)
end

local function get_colorscheme()
    local colors = {}
    colors.fg = get_color("Normal", false)
    colors.bg = get_color("StatusLine", true)

    colors.green = get_color("DiagnosticSignOk", false)
    colors.red = get_color("DiagnosticError", false)
    colors.yellow = get_color("tag", false)
    colors.lsp_col = get_color("Keyword", false)
    colors.warningcolor = get_color("DiagnosticWarn", false)
    colors.git_branch_col = get_color("Special", false)
    colors.infocolor = get_color("DiagnosticInfo", false)
    colors.encoding_color = get_color("Conceal", false)
    colors.highlight_bg = get_color("Visual", true)
    colors.block = "#f75f5f"
    return colors
end


local vi_mode_colors = {
    NORMAL = "green",
    OP = "green",
    INSERT = "yellow",
    VISUAL = "lsp_col",
    LINES = "warningcolor",
    BLOCK = "block",
    REPLACE = "red",
    COMMAND = "infocolor",
}

local c = {
    vim_mode = {
        provider = {
            name = "vi_mode",
            opts = {
                show_mode_name = true,
                -- padding = "center", -- Uncomment for extra padding.
            },
        },
        hl = function()
            return {
                fg = require("feline.providers.vi_mode").get_mode_color(),
                bg = "highlight_bg",
                style = "bold",
                name = "NeovimModeHLColor",
            }
        end,
        left_sep = "block",
        right_sep = "block",
    },
    gitBranch = {
        provider = "git_branch",
        hl = {
            fg = "git_branch_col",
            bg = "highlight_bg",
            style = "bold",
        },
        left_sep = "block",
        right_sep = "block",
    },
    gitDiffAdded = {
        provider = "git_diff_added",
        hl = {
            fg = "green",
            bg = "highlight_bg",
        },
        left_sep = "block",
        right_sep = "block",
    },
    gitDiffRemoved = {
        provider = "git_diff_removed",
        hl = {
            fg = "red",
            bg = "highlight_bg",
        },
        left_sep = "block",
        right_sep = "block",
    },
    gitDiffChanged = {
        provider = "git_diff_changed",
        hl = {
            fg = "fg",
            bg = "highlight_bg",
        },
        left_sep = "block",
        right_sep = "right_filled",
    },
    separator = {
        provider = "",
    },
    fileinfo = {
        provider = {
            name = "file_info",
            opts = {
                type = "relative",
            },
        },
        hl = {
            style = "bold",
        },
        left_sep = " ",
        right_sep = " ",
    },
    session = {
        provider = function()
            local possessions_ok, possessions = pcall(
                require, "nvim-possession"
            )
            if not possessions_ok then return '' end
            local status = possessions.status()
            if status ~= nil
            then
                return status
            else
                return ''
            end
        end,
        left_sep = " | ",
        right_sep = " ",
    },
    diagnostic_errors = {
        provider = "diagnostic_errors",
        hl = {
            fg = "red",
        },
    },
    diagnostic_warnings = {
        provider = "diagnostic_warnings",
        hl = {
            fg = "warningcolor",
        },
    },
    diagnostic_hints = {
        provider = "diagnostic_hints",
        hl = {
            fg = "infocolor",
        },
    },
    diagnostic_info = {
        provider = "diagnostic_info",
    },
    lsp_client_names = {
        provider = "lsp_client_names",
        hl = {
            fg = "lsp_col",
            bg = "highlight_bg",
            style = "bold",
        },
        left_sep = "left_filled",
        right_sep = "block",
    },
    file_type = {
        provider = {
            name = "file_type",
            opts = {
                filetype_icon = true,
                case = "titlecase",
            },
        },
        hl = {
            fg = "red",
            bg = "highlight_bg",
            style = "bold",
        },
        left_sep = "block",
        right_sep = "block",
    },
    file_encoding = {
        provider = "file_encoding",
        hl = {
            fg = "encoding_color",
            bg = "highlight_bg",
            style = "italic",
        },
        left_sep = "block",
        right_sep = "block",
    },
    position = {
        provider = "position",
        hl = {
            fg = "green",
            bg = "highlight_bg",
            style = "bold",
        },
        left_sep = "block",
        right_sep = "block",
    },
    line_percentage = {
        provider = "line_percentage",
        hl = {
            fg = "infocolor",
            bg = "highlight_bg",
            style = "bold",
        },
        left_sep = "block",
        right_sep = "block",
    },
    scroll_bar = {
        provider = "scroll_bar",
        hl = {
            fg = "yellow",
            style = "bold",
        },
    },
}

local left = {
    c.vim_mode,
    c.gitBranch,
    c.gitDiffAdded,
    c.gitDiffRemoved,
    c.gitDiffChanged,
    c.separator,
}

local middle = {
    c.fileinfo,
    c.diagnostic_errors,
    c.diagnostic_warnings,
    c.diagnostic_info,
    c.diagnostic_hints,
    c.session,
}

local right = {
    c.lsp_client_names,
    c.file_type,
    c.file_encoding,
    c.position,
    --c.line_percentage,
    --c.scroll_bar,
    --c.session
}

local components = {
    active = {
        left,
        middle,
        right,
    },
    inactive = {
        left,
        middle,
        right,
    },
}


function SetupFeline()
    local colorscheme = get_colorscheme()

    feline.setup({
        components = components,
        --theme = one_monokai,
        theme = colorscheme,
        vi_mode_colors = vi_mode_colors,
        --force_inactive={},
        disable = {
            filetypes = {
                'NvimTree',
                '^NvimTree$',
                '^packer$',
                '^startify$',
                '^fugitive$',
                '^fugitiveblame$',
                '^qf$',
                '^help$'
            },
            buftypes = {
                '^NvimTree$',
                '^terminal$'
            },
            bufnames = { "NvimTree" }
        }
    })
end

SetupFeline()
--return mod

