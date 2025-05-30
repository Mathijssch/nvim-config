local options = {};
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
    {
        name = "old",
        path = "~/Work/Obsidian-notes/Notebook",
    },
    {
        name = "new",
        path = "~/Work/notebook/notes",
    },
    {
        name = "fwo",
        path = "~/Work/Proposals/FWO/fwo-postdoc/notes",
    },
    {
        name = "fwo-macos",
        path = "~/repos/fwo-postdoc/notes",
    },
    {
        name = "schuurjans-macos",
        path = "/Users/mathijssch/Dropbox/admin/Schuurjans/schuurjans",
    },
    {
        name = "gd",
        path = "/Users/mathijssch/repos/gd/gdnotes/src",
    },
    {
        name = "GET",
        path = "~/Work/Research/GET/GET-notes/notes",
    },
}

for _, pathInfo in ipairs(paths) do
    local home = os.getenv("HOME")
    local resolvedPath = pathInfo.path
    if home ~= nil then
        resolvedPath = pathInfo.path:gsub("^~", home)
    end
    if file_exists(resolvedPath) then
        table.insert(options.workspaces, pathInfo)
    end
end

if next(options.workspaces) == nil then return end


local status_ok, obsidian = pcall(require, "obsidian")
if not status_ok then return end

local status_utils, _utils = pcall(require, "schuurvim.util") -- Exposes FormatDate
if not status_utils then
    vim.notify("Could not load utilities from schuurvim.", vim.log.levels.ERROR)
    return
end


options.completion = {
    -- Set to false to disable completion.
    nvim_cmp = true,
    -- Trigger completion at 2 chars.
    min_chars = 2,
};

local ObsidianSmartAction = function(opts)
    -- opts comes from the user command
    -- https://neovim.io/doc/user/lua-guide.html#lua-guide-commands-create
    -- print(vim.inspect(opts))

    local mode = vim.api.nvim_get_mode().mode
    if mode == "v" then
        local client = require("obsidian").get_client()
        client:command("ObsidianLink", opts)
        return
    end
    local obs_util = require("obsidian.util")
    if obs_util.cursor_on_markdown_link(nil, nil, true) then
        vim.cmd("ObsidianFollowLink")
        --else
        --    vim.cmd("ObsidianToggleCheckbox")
    end
end

options.date_format = "%d-%M-%Y"


-- Optional, customize how names/IDs for new notes are created.
options.note_id_func = function(title)
    if title ~= nil then
        -- If title is given, transform it into valid file name.
        --return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        return title
    else
        return tostring(os.time())
    end
end

options.mappings = {
    -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
    ["gf"] = {
        action = function()
            return obsidian.util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
    },
    -- Toggle check-boxes.
    ["<leader>ch"] = {
        action = function()
            return obsidian.util.toggle_checkbox()
        end,
        opts = { buffer = true },
    },
    ["<localleader>e"] = {
        action = function()
            vim.cmd([[:ObsidianTemplate]])
        end
    },
    ["<localleader>E"] = {
        action = function()
            -- clear the buffer
            vim.api.nvim_buf_set_lines(0, 0, -1, false, {})

            vim.cmd([[:ObsidianTemplate]])
        end
    },
    ["<cr>"] = { action = ObsidianSmartAction }
};

options.templates = {}
options.templates.subdir = ".templates"

local function get_monday_before(date, offset)
    offset = offset or 0
    local today = os.time()
    if date then
        local year, month, day = date:match("(%d+)-(%d+)-(%d+)")
        --year, month, day = tonumber(year), tonumber(month), tonumber(day)
        today = os.time { year = year, month = month, day = day }
    end
    local days_to_subtract = (tonumber(os.date("%w", today)) - 1) % 7;
    local monday = os.date("*t", today + (7 * offset - days_to_subtract) * 24 * 60 * 60);
    return monday
    --print(string.format("%04d-%02d-%02d", monday.year, monday.month, monday.day))
end

local substitutions = {};

--- Expecting to get a title in the form YYYY-MM-DD - <whatever>
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

substitutions.this_week = function() return title_to_date(0) end
substitutions.next_week = function() return title_to_date(1) end
substitutions.last_week = function() return title_to_date(-1) end

options.templates.substitutions = substitutions;

options.new_notes_location = "notes_subdir";
-- Either 'wiki' or 'markdown'.
options.preferred_link_style = "wiki";
options.attachments = {};
options.attachments.img_folder = "Attachments";

-- A function that determines the text to insert in the note when pasting an image.
-- It takes two arguments, the `obsidian.Client` and an `obsidian.Path` to the image file.
-- This is the default implementation.
---@param client obsidian.Client
---@param path obsidian.Path the absolute path to the image file
---@return string
options.attachments.img_text_func = function(client, path)
    path = client:vault_relative_path(path) or path
    return string.format("![[%s]]", path)
end

vim.keymap.set("n", "<localleader>p", "<cmd>ObsidianPasteImg<CR>")

options.ui = { enable = false }
options.disable_frontmatter = true;
--options.note_frontmatter_func = function(note)
--    local today = os.date("%d-%m-%Y")
--    local out = { date_created = today }

--    -- `note.metadata` contains any manually added fields in the frontmatter.
--    -- So here we just make sure those fields are kept in the frontmatter.
--    if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
--        for k, v in pairs(note.metadata) do
--            out[k] = v
--        end
--    end

--    return out
--end

options.follow_url_func = function(url)
    -- Open the URL in the default web browser.
    --vim.fn.jobstart({"open", url})  -- Mac OS
    --vim.fn.jobstart({ "xdg-open", url }) -- linux
    vim.ui.open(url)
end

obsidian.setup(options)

local function get_weekly_note_file(date, offset)
    local monday = get_monday_before(date, offset)
    return "weekly/" .. FormatDate(monday) .. " - weekly update.md"
end

vim.api.nvim_create_user_command("WeekNote", function()
    local weekly_path = get_weekly_note_file()
    require('schuurvim.pathman')
    local is_empty = not FileExists(weekly_path)
    NewFile(weekly_path)
    if is_empty then
        vim.cmd("ObsidianTemplate weekly.md")
        vim.cmd("write")
    end
end, {})

vim.api.nvim_create_user_command("FromTemplate", function()
    vim.cmd("ObsidianNew")
    vim.cmd("normal! gg")
    vim.cmd("normal! dG") -- go to end of file
    vim.cmd("ObsidianTemplate")
end, {})

vim.api.nvim_create_user_command("FillWeeklyGap", function()
    local current_buffer_name = vim.fn.bufname('%')
    local curr_date = get_date_from_title(current_buffer_name)
    if curr_date == nil then
        vim.notify("Could not parse date from title. Stopping.", vim.log.levels.WARN)
        return
    end

    local offset = -1
    local file = get_weekly_note_file(curr_date, offset)
    require('schuurvim.pathman')
    local list_of_offsets = {}
    local max_weeks = 50

    while not FileExists(file) and -offset <= max_weeks do
        table.insert(list_of_offsets, offset)
        offset = offset - 1
        file = get_weekly_note_file(curr_date, offset)
        --NewFile(file)
        --vim.cmd(string.format("ObsidianTemplate weekly.md"))
    end
    local choice = vim.fn.confirm(string.format("Updating %d notes. Proceed?", -1 - offset), "&Yes\n&No", 2) -- 2 is the default selection (No)
    if choice == 1 then                                                                                      -- 1 corresponds to 'Yes'
        for i, o in ipairs(list_of_offsets) do
            file = get_weekly_note_file(curr_date, o)
            NewFile(file)
            vim.cmd(string.format("ObsidianTemplate weekly.md"))
            vim.cmd("write")
        end
    else
        vim.notify("Cancelled creation of weekly notes.")
    end
end, {})

-- Define a function to handle opening URLs
local function openUrl(url)
    --vim.fn.system({ 'firefox', url })
    local uname = vim.loop.os_uname().sysname
    url = url:gsub("%s+$", "") -- Removes any trailing whitespace, including newlines
    if uname == "Darwin" then
        -- macOS detected
        vim.fn.system({ 'open', url })
        --os.execute('open "' .. url .. '"')
    elseif uname == "Linux" then
        -- Linux detected
        vim.fn.system({ 'xdg-open', url })
        --os.execute('xdg-open "' .. url .. '"')
    else
        print("Unsupported OS: " .. uname)
    end
end


local function retrievePort(dir)
    local port = "8080"
    local file_path = dir .. "/" .. ".live_port"

    if not file_exists(file_path) then return port end

    local lines = vim.fn.readfile(file_path)
    if #lines < 1 then return port end

    port = lines[1]
    return port
end

vim.api.nvim_create_user_command("GotoPage", function()
    local relative_filename = vim.fn.expand('%:~:.')
    local filename_in_output = vim.fn.system('oxidian where --file \"' .. relative_filename .. '\" ' .. vim.fn.getcwd())
    local port = retrievePort(vim.fn.getcwd())
    local url = 'http://localhost:' .. port .. '/' .. filename_in_output
    vim.notify('Opening ' .. url)
    openUrl(url)
end, {})
