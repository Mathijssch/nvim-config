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


local function toggleMain()
    local currBuf = vim.fn.expand('%:p:r')
    if currBuf == nil then return end

    local texmain_path = currBuf .. '.latexmain'
    local file_info = vim.loop.fs_stat(texmain_path)

    if file_info then
      -- The file exists
      vim.notify("Removing " .. texmain_path)
      deleteFile(texmain_path) 
    else
      -- The file does not exist
      vim.notify("Creating " .. texmain_path)
      createFile(texmain_path)
    end
end

vim.api.nvim_create_user_command("ToggleMain", toggleMain, {})

