local status_ok, lualine = pcall(require, "lualine")
if not status_ok then return end

-- Color table for highlights
-- stylua: ignore
local colors = {
    bg       = '#202328',
    fg       = '#bbc2cf',
    yellow   = '#ECBE7B',
    cyan     = '#008080',
    darkblue = '#081633',
    green    = '#98be65',
    orange   = '#FF8800',
    violet   = '#a9a1e1',
    magenta  = '#c678dd',
    blue     = '#51afef',
    red      = '#ec5f67',
}

local colors_ok, material_colors
require "material.colors"

if colors_ok then
    colors.bg = material_colors.editor.bg_alt
end


local conditions = {
    buffer_not_terminal = function()
        return vim.bo.buftype ~= 'terminal'
    end,
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
    end,
    hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
        local filepath = vim.fn.expand('%:p:h')
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
}

-- Config
local config = {
    options = {
        always_divide_middle = false,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        theme = 'auto',
        disabled_filetypes = {
            statusline = { "NvimTree", "packer", "fugitive", "fugitiveblame", "qf", "help" },
            winbar = { "NvimTree", "packer", "fugitive", "fugitiveblame", "qf", "help" },
        },
    },
    sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        -- These will be filled later
        lualine_c = {},
        lualine_x = {},
    },
    inactive_sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        -- These will be filled later
        lualine_c = {},
        lualine_x = {},
    },
}

local function ins_c_inactive(component)
    table.insert(config.inactive_sections.lualine_c, component)
end

-- Inserts a component in lualine_a at left section
local function ins_a(component)
    table.insert(config.sections.lualine_a, component)
end

-- Inserts a component in lualine_b at left section
local function ins_b(component)
    table.insert(config.sections.lualine_b, component)
end

-- Inserts a component in lualine_c at left section
local function ins_c(component)
    table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x at right section
local function ins_x(component)
    table.insert(config.sections.lualine_x, component)
end

-- Inserts a component in lualine_z at right section
local function ins_z(component)
    table.insert(config.sections.lualine_z, component)
end

-- Inserts a component in lualine_y at right section
local function ins_y(component)
    table.insert(config.sections.lualine_y, component)
end

-- Inserts a component in lualine_a at left section
local function ins_a_inactive(component)
    table.insert(config.inactive_sections.lualine_a, component)
end

-- Inserts a component in lualine_b at left section
local function ins_b_inactive(component)
    table.insert(config.inactive_sections.lualine_b, component)
end

-- Inserts a component in lualine_x at right section
local function ins_x_inactive(component)
    table.insert(config.inactive_sections.lualine_x, component)
end
-- Inserts a component in lualine_z at right section
local function ins_z_inactive(component)
    table.insert(config.inactive_sections.lualine_z, component)
end
-- Inserts a component in lualine_y at right section
local function ins_y_inactive(component)
    table.insert(config.inactive_sections.lualine_y, component)
end

ins_a_inactive {
    function()
        return " "
    end,
    color = { fg = colors.fg }
}

ins_x_inactive {
    draw_empty=true,
    color = { bg = colors.bg }
}

ins_y_inactive {
    draw_empty=true,
    color = { bg = colors.bg }
}

ins_b_inactive {
    'filename',
    cond = conditions.buffer_not_terminal,
    path = 1,
    symbols = { modified = '●', unmodified = ' ' },
    color = { bg = colors.bg }
}

ins_c_inactive {
    function()
        return ""
    end,
    color = { bg = colors.bg }
}

ins_a {
    -- mode component
    function()
        return string.upper(vim.fn.mode())
    end,
    color = function()
        -- auto change color according to neovims mode
        local mode_color = {
            n = colors.red,
            i = colors.green,
            v = colors.blue,
            [''] = colors.blue,
            V = colors.blue,
            c = colors.magenta,
            no = colors.red,
            s = colors.orange,
            S = colors.orange,
            [''] = colors.orange,
            ic = colors.yellow,
            R = colors.violet,
            Rv = colors.violet,
            cv = colors.red,
            ce = colors.red,
            r = colors.cyan,
            rm = colors.cyan,
            ['r?'] = colors.cyan,
            ['!'] = colors.red,
            t = colors.red,
        }
        return { bg = mode_color[vim.fn.mode()] }
    end,
    color = { gui = 'bold' }
}

ins_y {
    -- filesize component
    'filesize',
    cond = conditions.buffer_not_empty,
}

ins_b {
    'diagnostics',
    sources = { 'nvim_diagnostic' },
    symbols = { error = ' ', warn = ' ', info = ' ' },
    --diagnostics_color = {
    --    color_error = { fg = colors.red },
    --    color_warn = { fg = colors.orange },
    --    color_info = { fg = colors.cyan },
    --},
}

ins_c {
    'filename',
    cond = conditions.buffer_not_empty,
    path = 1,
    symbols = { modified = '●', unmodified = ' ' },
    color = {
        --fg = colors.magenta,
        gui = 'bold'
    },
}

ins_x {
    -- Lsp server name .
    function()
        local msg = 'No Active Lsp'
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
            return msg
        end
        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return client.name
            end
        end
        return msg
    end,
    icon = ' ',
    --color = { fg = '#ffffff', gui = 'bold' },
}

-- Add components to right sections
ins_y {
    'o:encoding',
    fmt = string.upper,
    cond = conditions.hide_in_width,
    color = { fg = colors.green, gui = 'bold' },
}

ins_b {
    'branch',
    icon = '',
    --color = { gui = 'bold' },
}

ins_b {
    'diff',
    symbols = { added = ' ', modified = ' ', removed = ' ' },
    diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.orange },
        removed = { fg = colors.red },
    },
    cond = conditions.hide_in_width,
}

lualine.setup(config)
