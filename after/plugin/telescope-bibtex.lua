local status_ok, telescope = pcall(require, "telescope")
if not status_ok then return end
local action_state = require('telescope.actions.state')
local actions = require "telescope.actions"
local status_ok_util, utils = pcall(require, "telescope-bibtex.utils")
if not status_ok_util then return end

local status_utils, _utils = pcall(require, "schuurvim.util")  -- Expose FormatDate
if not status_utils then
    vim.notify("Could not load utilities from schuurvim.", vim.log.levels.ERROR)
    return
end

local options = {}
options.literature_dir = "literature"

local function write_text(txt)
    local mode = vim.api.nvim_get_mode().mode
    if mode == 'i' then
        vim.api.nvim_put({ txt }, '', false, true)
        vim.api.nvim_feedkeys('a', 'n', true)
    else
        vim.api.nvim_put({ txt }, '', true, true)
    end
end


local function replace_templates(template, values)
    return (template:gsub("{{(.-)}}", function(match)
        return values[match] or match
    end)
    )
end

local function join(list, map, sep)
    sep = sep or ","
    map = map or function(item) return item end
    local result = ""
    for i, item in ipairs(list) do
        if i > 1 then
            result = result .. sep .. " "
        end
        result = result .. map(item)
    end
    return result
end

local function sluggify(str)
    local slug = require "schuurvim.slug_unicode"
    str = str or ""
    str = slug.slug_unicode(str)
    return str:gsub(" ", "_"):gsub("%(", "-"):gsub("%)", "-"):lower()
end

local function split(str, pat)
    pat = pat or '%s+'
    local st, g = 1, str:gmatch("()(" .. pat .. ")")
    local function getter(segs, seps, sep, cap1, ...)
        st = sep and seps + #sep
        return str:sub(segs, (seps or 0) - 1), cap1 or sep, ...
    end
    return function() if st then return getter(st, g()) end end
end

local function trim(s)
    return s:match("^%s*(.-)%s*$")
end

local function authors_to_list(authors)
    authors = authors or ""
    local result = {}
    for names in split(authors, " and ") do
        local author = {}
        local splits = {}
        for res in split(names, ",") do
            table.insert(splits, trim(res))
        end
        author.first = splits[2] or ""
        author.last = splits[1] or ""
        table.insert(result, author)
    end
    return result
end

local function format_authors_short(author_list, opts)
    local sep = opts.sep or ", "
    local result = ""
    local max_cnt = opts.max_authors or 2
    local use_etal = opts.etal or true
    for cnt, author in ipairs(author_list) do
        if cnt > max_cnt then
            if use_etal then
                result = result .. " et al"
            end
            break
        end
        if cnt > 1 then
            result = result .. sep
        end
        result = result .. author.last
    end
    return result
end

local function get_initial(s)
    s = s or ""
    if string.len(s) >= 1 then
        return trim(string.sub(s, 1, 1) .. ".")
    else
        return ""
    end
end

local function format_authors_long(author_list)
    local result = join(author_list,
        function(auth)
            return string.format(
                "[[%s %s]]",
                get_initial(auth.first), auth.last
            )
        end
    )
    if result:len() > 0 then
        return "\nBy " .. result .. "\n"
    end
    return ""
end

local function truncate_title(title, max)
    max = max or 4
    title = title or ""
    local result = ""
    local i = 0
    for word in split(title) do
        if i > 0 then
            result = result .. " "
        end

        result = result .. word
        i = i + 1
    end
    return result
end

local function format_year(year)
    local result = ""
    if year then
        result = string.format("(%s)", year)
    end
    return result
end

local function format_author_list(author_list)
    local format_single_author = function(author)
        return string.format("%s %s", author.first, author.last)
    end
    local authors = join(author_list, format_single_author)
    return string.format("[%s]", authors)
end

local function generate_filename(reference)
    local authors = format_authors_short(authors_to_list(reference.author), { sep = "_" })
    local year = format_year(reference.year)
    local prefix = string.format("%s%s", authors, year)
    local separator = ""
    if prefix:len() > 0 then
        separator = "-"
    end

    local filename = sluggify(string.format("%s%s%s", prefix, separator, truncate_title(reference.title)))

    if options.literature_dir ~= nil then
        filename = options.literature_dir .. "/" .. filename;
    end
    return filename
end

local function format_citation_tex(reference)
    return string.format([[\cite{%s}]], reference.label)
end


local function format_citation_md(reference)
    local authors = authors_to_list(reference.author)
    local author_str = format_authors_short(authors, { max_authors = 1 })
    local year = format_year(reference.year)
    local filename = generate_filename(reference)
    return string.format("[[%s|%s %s]]", filename, author_str, year)
end

local function format_abstract(abstract)
    if not abstract then return "" end
    return string.format([[
<span class="abstract">
%s
</span>
    ]], abstract)
end

local function generate_literature_page(reference)
    local template = [[
---
title: "{{author_short}} {{year}} - {{title}}"
year: {{year}}
author: {{author_list}}
URL: {{url}}
citekey: {{label}}
date_created: {{today}}
---
#literature/{{type}}

# {{title}}
{{author}}{{link}}{{abstract}}
---

]]

    local all_authors = authors_to_list(reference.author)
    local replacements = {}
    replacements.title = reference.title
    replacements.author_short = format_authors_short(all_authors, { max_authors = 1 })
    replacements.author_list = format_author_list(all_authors)
    replacements.author = format_authors_long(all_authors)
    replacements.year = reference.year
    replacements.url = reference.url
    replacements.label = reference.label
    replacements.type = reference.type
    replacements.today= FormatDate(os.date("*t", os.time()))

    replacements.link = ""
    if reference.url then
        replacements.link = string.format("\n[Online](%s)\n", reference.url)
    end
    replacements.abstract = format_abstract(reference.abstract)
    return replace_templates(template, replacements)
end


local function file_exists(path)
    local file = io.open(path, "r")
    if file then
        io.close(file)
        return true
    else
        return false
    end
end

local function create_dir(path)
    local mkdir = io.popen('mkdir -p "' .. path .. '"')
    if mkdir ~= nil then
        local result = mkdir:read('*a')
        mkdir:close()
        return true
    else
        vim.notify(string.format("Could not make the directory %s", path),
            vim.log.levels.ERROR
        )
        return false
    end
end

local function strip_filename(path)
    return path:match("(.+)/") -- Match everything up to the last '/'
end

local function create_if_not_exists(ref)
    local path = generate_filename(ref) .. ".md"
    if not file_exists(path) then
        local directory = strip_filename(path)
        if not create_dir(directory) then return false end

        local file = io.open(path, "w")
        if file then
            local contents = generate_literature_page(ref)
            file:write(contents)
            file:close()
            vim.notify("Created new note")
            return true
        else
            vim.notify("Error creating note path", vim.log.levels.ERROR)
            return false
        end
    else
        vim.notify("File for reference already exists")
        return false
    end
end

local function is_md()
    local filetype = vim.api.nvim_get_option_value('filetype', {})
    return filetype == 'markdown'
end

local add_citation = function()
    return function(prompt_bufnr)
        local entry = action_state.get_selected_entry().id.content;
        local parsed = utils.parse_entry(entry)
        actions.close(prompt_bufnr)
        if is_md() then
            create_if_not_exists(parsed)
            write_text(format_citation_md(parsed))
        else
            write_text(format_citation_tex(parsed))
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
