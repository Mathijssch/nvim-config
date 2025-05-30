vim.g.vimtex_compiler_latexmk = {
    build_dir = '',
    callback = 1,
    continuous = 1,
    executable = 'latexmk',
    hooks = {},
    options = {
        '-verbose',
        '-file-line-error',
        '-synctex=1',
        '-shell-escape',
        '-interaction=nonstopmode',
    },
}

vim.keymap.set("n", "<C-A-b>", "<Cmd>wa<CR><Cmd>VimtexCompileSS<CR>")
vim.keymap.set("i", "<C-A-b>", "<Cmd>wa<CR><Cmd>VimtexCompileSS<CR>")
vim.keymap.set("n", "<C-A-k>", "<Cmd>VimtexStop<CR>")
vim.keymap.set("n", "<C-A-R>", "<Cmd>VimtexReload<CR>")

vim.keymap.set("n", "<localleader>lb", "<Cmd>wa<CR><Cmd>VimtexCompileSS<CR>")
vim.keymap.set("n", "<localleader>lr", "<Cmd>VimtexReload<CR>")

local function createFile(path)
    local file = vim.loop.fs_open(path, 'w', 438)
    if not file then
        vim.notify('Could not create file' .. path, vim.log.levels.ERROR)
        return
    end
    vim.loop.fs_close(file)
end

local function deleteFile(path)
    local ok, err = vim.loop.fs_unlink(path)
    if not ok then
        vim.notify('Failed to delete file:', vim.log.levels.ERROR)
    end
end

local function scandir(directory)
    local i, t, popen = 0, {}, io.popen
    local pfile = popen('ls -a "' .. directory .. '"')
    if pfile == nil then return {} end
    for filename in pfile:lines() do
        i = i + 1
        t[i] = filename
    end
    pfile:close()
    return t
end

local function remove_other_latexmains(dir)
    -- Scan the directory for files ending in ".latexmain"
    --print(scandir(dir))
    local files = scandir(dir)
    for _, file in ipairs(files) do
        if file:match('%.latexmain$') then
            local fullpath = dir .. "/" .. file
            deleteFile(fullpath)
        end
    end
end


local function toggleMain()
    local currExt = vim.fn.expand('%:p:e')
    if currExt ~= 'tex' then
        vim.notify("Current buffer is not a TeX file.", vim.log.levels.WARN)
        return
    end
    local currBuf = vim.fn.expand('%:p:r')
    if currBuf == nil then return end

    local texmain_path = currBuf .. '.tex.latexmain'
    local file_info = vim.loop.fs_stat(texmain_path)

    if file_info then
        -- The file exists
        vim.notify("Removing " .. texmain_path)
        deleteFile(texmain_path)
    else
        local currDir = vim.fn.fnamemodify(currBuf, ":h")
        remove_other_latexmains(currDir)
        -- The file does not exist
        vim.notify("Creating " .. texmain_path)
        createFile(texmain_path)
    end
    vim.cmd([[VimtexReload]])
end

vim.api.nvim_create_user_command("ToggleMain", toggleMain, {})


vim.g.vimtex_quickfix_ignore_filters = {
    'Underfull',
    'Overfull',
}

if vim.loop.os_uname().sysname == "Darwin" then
    vim.g.vimtex_view_method = 'skim'   -- Choose which program to use to view PDF file
    vim.g.vimtex_view_skim_sync = 1     -- Value 1 allows forward search after every successful compilation
    vim.g.vimtex_view_skim_activate = 1 -- Value 1 allows change focus to skim after command `:VimtexView` is given
end
