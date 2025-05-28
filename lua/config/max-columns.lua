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


vim.cmd([[let &colorcolumn="80,".join(range(80,300),",")]])
vim.cmd([[set spell spelllang=en_us]])

vim.cmd([[set fillchars+=vert:▏]])

vim.opt.fillchars.vert = "▏"
