vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

--vim.opt.smartindent = true
vim.opt.smartindent = false

vim.opt.wrap = false

vim.opt.conceallevel = 1
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- Check if the buffer corresponds to a file
--
local function is_empty()
    return vim.fn.empty(vim.fn.expand('%:t'))
end

local function draw_column()
    if vim.bo.buftype == 'terminal' then return false end
    if vim.bo.filetype == 'fugitive' then return false end
    --if is_empty() then return false end
    if not vim.fn.empty(vim.bo.buftype) then return false end
    return true
end



--vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" },
--    {
--        callback = function()
--            --print("I am so triggered")
--            if draw_column() then
--                --print("Enable column")
--                vim.cmd([[let &colorcolumn="80,".join(range(80,300),",")]])
--            else
--                --print("Disable column")
--                vim.cmd([[let &colorcolumn=""]])
--            end
--        end
--    }
--)


vim.cmd([[let &colorcolumn="80,".join(range(80,300),",")]])
vim.cmd([[set spell spelllang=en_us]])

vim.cmd([[set fillchars+=vert:▏]])

vim.opt.fillchars.vert = "▏"
